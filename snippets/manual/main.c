
/* Includes */
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "csr.h"
#include "x-heep.h"
#include "vcd_util.h"
#include "gpio.h"

#include "conv1Di32.h"
#include "core_v_mini_mcu.h"
#include "mmio.h"

////////////////////
// CONFIGURATION //
//////////////////

/* By default, printfs are activated for FPGA and disabled for simulation. */
#define PRINTF_IN_FPGA 1
#define PRINTF_IN_SIM 1

#define TILE 4

/////////////
// MACROS //
///////////

/* Select print mode */
#if TARGET_SIM && PRINTF_IN_SIM
#define PRINTF(fmt, ...) printf(fmt, ##__VA_ARGS__)
#elif TARGET_PYNQ_Z2 && PRINTF_IN_FPGA
#define PRINTF(fmt, ...) printf(fmt, ##__VA_ARGS__)
#else
#define PRINTF(...)
#endif

#define CEIL_DIV(a, b) ((((a) % (b)) != 0) ? (((a) / (b)) + 1) : (a) / (b))

int32_t __attribute__((section(".xheep_data_interleaved"))) out[OC * IW];
int32_t __attribute__((section(".xheep_data_interleaved"))) data_tile[TILE][IC * KW];
int32_t __attribute__((section(".xheep_data_interleaved"))) result[OC * IW];
int32_t __attribute__((section(".xheep_data_interleaved"))) small_data_tile_a[TILE*TILE];
int32_t __attribute__((section(".xheep_data_interleaved"))) small_data_tile_b[TILE*TILE];

int _write(int file, char *ptr, int len)
{
    int i;
    volatile uintptr_t *base = (volatile uintptr_t *)EXT_PERIPHERAL_START_ADDRESS;
    for (i = 0; i < len; i++)
    {
        *base = (int)ptr[i];
    }
    return len;
}
void sim_putchar(char c)
{
    volatile uintptr_t *base = (volatile uintptr_t *)EXT_PERIPHERAL_START_ADDRESS;
    *base = (int)c;
}

void sim_puts(char *s)
{
    while (*s)
    {
        sim_putchar(*s++);
    }
}

////////////////
// MAIN CODE //
//////////////

// Transform one tile of the data into im2col format.
// No padding for the time being, if an index goes over it is 0
void im2col_tile(int32_t *data, int32_t *data_tile, int tile_j)
{
    for (int chan = 0; chan < IC; chan++)
    {
        int d_r_addr = tile_j * TILE + chan * IW;
        int w_addr = chan * KW;
        for (int replica = 0; replica < TILE; replica++)
        {
            // can it be replaced by a DMA? one that handles padding of course
            for (int i = 0; i < KW; i++)
            {
                // Check that we are not out of bounds of the input in the current channel
                if (d_r_addr - chan * IW >= IW)
                {
                    data_tile[w_addr++] = 0;
                }
                else
                {
                    data_tile[w_addr++] = data[d_r_addr];
                }
                d_r_addr++;
            }
            // offset
            d_r_addr -= KW - 1;
            w_addr += KW * (IC - 1);
        }
    }
}

#define DATA_IN_t int32_t
#define DATA_OUT_t int32_t
void __attribute__((noinline)) matrixMul_CPU(DATA_IN_t *addrA, DATA_IN_t *addrB, DATA_OUT_t *addrC, int N, int strideI, int strideO)
{
    for (int i = 0; i < N; i++)
    {
        for (int j = 0; j < N; j++)
        {
            DATA_OUT_t acc = addrC[i * strideO + j];
            for (int k = 0; k < N; k++)
            {
                acc += addrA[i * strideI + k] * addrB[j * strideI + k];
            }
            addrC[i * strideO + j] = acc;
        }
    }
}

void conv1d(int32_t *data, int32_t *kernels, int32_t *out)
{
    // should be ceil_div(ic*kw, tile) * tile
    // and initialized to 0
    int tile_i_len = CEIL_DIV(OC, TILE);
    int tile_j_len = CEIL_DIV(IW, TILE);
    for (int tile_i = 0; tile_i < tile_i_len; tile_i++)
    {
        for (int tile_j = 0; tile_j < tile_j_len; tile_j++)
        {
            im2col_tile(data, data_tile, tile_j);

            int stride = IC * KW;
            int32_t *outptr = (out + (tile_i * IW + tile_j) * TILE);
#ifdef USE_CPU
            int32_t temp[TILE][TILE];
            for (int i = 0; i < TILE; i++)
            {
                for (int j = 0; j < TILE; j++)
                {
                    temp[i][j] = 0;
                }
            }
            for (int k = 0; k < stride; k += TILE)
            {
                matrixMul_CPU((&kernel_tile[0][k]), (&data_tile[0][k]), temp[0], TILE, stride, TILE);
                for (int i = 0; i < TILE; i++)
                {
                    for (int j = 0; j < TILE; j++)
                    {
                        int out_i_idx = tile_i * TILE + i;
                        int out_j_idx = tile_j * TILE + j;
                        out[out_i_idx * IW + out_j_idx] = temp[i][j];
                    }
                }
            }
#else
            asm volatile("mzero m2");
            int32_t *kernel_base = kernels + tile_i * TILE * IC * KW;
            for (int k = 0; k < stride; k += TILE)
            {
                asm volatile("mld.w m0, (%1), %0" ::"r"(stride * 4), "r"(&data_tile[0][k]));
                asm volatile("mld.w m1, (%1), %0" ::"r"(stride * 4), "r"(kernel_base + k));
                asm volatile("mmasa.w m2, m0, m1");
                for (volatile int i = 0; i < 5; i++)
                    ;
            }
            asm volatile("mst.w m2, (%1), %0" ::"r"(IW * 4), "r"(outptr));
#endif
        }
    }
}

// Target case: 23 IC, 128 OC, 3 KW, 1024 IW
void conv1d_tile_lt_kw(int32_t *data, int32_t *kernels, int32_t *out)
{
    // should be ceil_div(ic*kw, tile) * tile
    // and initialized to 0
    int tile_i_len = CEIL_DIV(OC, TILE);
    int tile_j_len = CEIL_DIV(IW, TILE);
    int data_base;
    int32_t *kernel_base = kernels;
    int32_t *small_data_tile = small_data_tile_a;
    for (int tile_i = 0; tile_i < tile_i_len; tile_i++)
    {
        data_base = 0;
        for (int tile_j = 0; tile_j < tile_j_len; tile_j++)
        {
            asm volatile("mzero m3");
            int data_row = 0;
            for (int tile_k = 0; tile_k < IC; tile_k++)
            {
                for (int replica = 0; replica < TILE; replica++)
                {
                    for (int i = 0; i < KW; i++)
                    {
                        int ofs = data_base + replica + i;
                        // Check that we are not out of bounds of the input in the current channel
                        small_data_tile[replica*TILE + i] = -(ofs < IW) & data[data_row + ofs];
                    }
                }
                data_row += IW;
                
                asm volatile("mld.w m2, (%1), %0" ::"r"(TILE * 4), "r"(small_data_tile));
                asm volatile("mld.w m1, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base));

                //for (int i = 0; i < TILE; i++) {
                //    for (int j = 0; j < TILE; j++) {
                //        printf("%d ", small_data_tile[i][j]);
                //    }
                //    printf("\t");
                //    for (int j = 0; j < TILE; j++) {
                //        printf("%d ", *(kernel_base + i *IC*KW + j));
                //    }
                //    printf("\n");
                //}

                asm volatile("mmasa.w m3, m2, m1");
                kernel_base += KW;
            }
            int32_t *outptr = (out + (tile_i * IW + tile_j) * TILE);
            //asm volatile("mmasa.w m3, m0, m0");
            asm volatile("mst.w m3, (%1), %0" ::"r"(IW * 4), "r"(outptr));
            data_base += TILE;
            kernel_base -= KW * IC;
        }
        kernel_base += TILE * IC * KW;
    }
}

void conv1d_tile_lt_kw_pip(int32_t *data, int32_t *kernels, int32_t *out)
{
    // should be ceil_div(ic*kw, tile) * tile
    // and initialized to 0
    int tile_i_len = CEIL_DIV(OC, TILE);
    int tile_j_len = CEIL_DIV(IW, TILE);
    int data_base;
    int cycles;
    int32_t *kernel_base = kernels;
    register int32_t *small_data_tile_cur = small_data_tile_a;
    register int32_t *small_data_tile_old = small_data_tile_b;
    register int32_t *temp;
    for (int tile_i = 0; tile_i < tile_i_len; tile_i++)
    {
        data_base = 0;
        for (int tile_j = 0; tile_j < tile_j_len; tile_j++)
        {
            asm volatile("mzero m2");            
            int data_row = 0;
            for (int tile_k = 0; tile_k <= IC; tile_k++)
            {
                if (tile_k != IC) {
                    //CSR_CLEAR_BITS(CSR_REG_MCOUNTINHIBIT, 0x1);
                    //CSR_WRITE(CSR_REG_MCYCLE, 0);
                    for (int replica = 0; replica < TILE; replica++)
                    {
                        int ofs = data_base + replica;
                        int drow_ofs = data_row + ofs;
                        int dtile_ofs = replica*TILE;
                        int lim = (IW-ofs > KW) ? KW : IW-ofs;
                        for (int i = 0; i < lim; i++)
                        {
                            // Check that we are not out of bounds of the input in the current channel
                            // this should not block: addresses are different
                            small_data_tile_cur[dtile_ofs] = data[drow_ofs];
                            drow_ofs++;
                            dtile_ofs++;
                        }
                    }
                    //CSR_READ(CSR_REG_MCYCLE, &cycles);
                    //printf("cyc: %d\n", cycles);
                    data_row += IW;
                }
                
                if (tile_k != 0) {
                    
                    asm volatile("mld.w m0, (%1), %0" ::"r"(TILE * 4), "r"(small_data_tile_old));
                    asm volatile("mld.w m1, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base));

                    //for (int i = 0; i < TILE; i++) {
                    //    for (int j = 0; j < TILE; j++) {
                    //        printf("%d ", small_data_tile[i][j]);
                    //    }
                    //    printf("\t");
                    //    for (int j = 0; j < TILE; j++) {
                    //        printf("%d ", *(kernel_base + i *IC*KW + j));
                    //    }
                    //    printf("\n");
                    //}
                    asm volatile("mmasa.w m2, m0, m1");
                    
                    kernel_base += KW;
                }
                // swap
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_old) : "r"(small_data_tile_cur));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
                temp = small_data_tile_cur;
                small_data_tile_cur = small_data_tile_old;
                small_data_tile_old = temp;
            }
            int32_t *outptr = (out + (tile_i * IW + tile_j) * TILE);
            asm volatile("mst.w m2, (%1), %0" ::"r"(IW * 4), "r"(outptr));

            data_base += TILE;
            kernel_base -= KW * IC;
        }
        kernel_base += TILE * IC * KW;
    }
}

void conv1d_tile_lt_kw_pip_reord(int32_t *data, int32_t *kernels, int32_t *out)
{
    // should be ceil_div(ic*kw, tile) * tile
    // and initialized to 0
    int tile_i_len = CEIL_DIV(OC, TILE*4);
    int tile_j_len = CEIL_DIV(IW, TILE);
    int data_base;
    int cycles;
    int32_t *kernel_base = kernels;
    register int32_t *small_data_tile_cur = small_data_tile_a;
    register int32_t *small_data_tile_old = small_data_tile_b;
    register int32_t *temp;
    for (int tile_i = 0; tile_i < tile_i_len; tile_i++)
    {
        data_base = 0;
        for (int tile_j = 0; tile_j < tile_j_len; tile_j++)
        {
            asm volatile("mzero m1");            
            asm volatile("mzero m2");
            asm volatile("mzero m3");            
            asm volatile("mzero m4");
            int data_row = 0;
            for (int tile_k = 0; tile_k <= IC; tile_k++)
            {
                if (tile_k != IC) {
                    //CSR_CLEAR_BITS(CSR_REG_MCOUNTINHIBIT, 0x1);
                    //CSR_WRITE(CSR_REG_MCYCLE, 0);
                    for (int replica = 0; replica < TILE; replica++)
                    {
                        int ofs = data_base + replica;
                        int drow_ofs = data_row + ofs;
                        int dtile_ofs = replica*TILE;
                        for (int i = 0; i < KW; i++)
                        {
                            // Check that we are not out of bounds of the input in the current channel
                            // this should not block: addresses are different
                            (ofs < IW) ? data[drow_ofs] : 0;
                            small_data_tile_cur[dtile_ofs] = -(ofs < IW) & data[drow_ofs];
                            
                            ofs++;
                            drow_ofs++;
                            dtile_ofs++;
                        }
                    }
                    //CSR_READ(CSR_REG_MCYCLE, &cycles);
                    //printf("cyc: %d\n", cycles);
                    data_row += IW;
                }
                
                if (tile_k != 0) {
                    asm volatile("mld.w m0, (%1), %0" ::"r"(TILE * 4), "r"(small_data_tile_old));
                    asm volatile("mld.w m5, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base));
                    asm volatile("mmasa.w m1, m0, m5");
                    asm volatile("mld.w m6, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW));
                    asm volatile("mmasa.w m2, m0, m6");
                    asm volatile("mld.w m7, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW*2));
                    asm volatile("mmasa.w m3, m0, m7");
                    asm volatile("mld.w m5, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW*3));
                    asm volatile("mmasa.w m4, m0, m5");      
                    kernel_base += KW;
                }
                // swap
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_old) : "r"(small_data_tile_cur));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
                temp = small_data_tile_cur;
                small_data_tile_cur = small_data_tile_old;
                small_data_tile_old = temp;
            }
            int32_t *outptr = (out + (tile_i * IW * 4 + tile_j) * TILE);
            asm volatile("mst.w m1, (%1), %0" ::"r"(IW * 4), "r"(outptr));
            asm volatile("mst.w m2, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW));
            asm volatile("mst.w m3, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW*2));
            asm volatile("mst.w m4, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW*3));

            data_base += TILE;
            kernel_base -= KW * IC;
        }
        kernel_base += TILE * IC * KW*4;
    }
}

void conv1d_tile_lt_kw_reord(int32_t *data, int32_t *kernels, int32_t *out)
{
    // should be ceil_div(ic*kw, tile) * tile
    // and initialized to 0
    int tile_i_len = CEIL_DIV(OC, TILE*4);
    int tile_j_len = CEIL_DIV(IW, TILE);
    int data_base;
    int cycles;
    int32_t *kernel_base = kernels;
    register int32_t *small_data_tile = small_data_tile_a;
    register int32_t *temp;
    for (int tile_i = 0; tile_i < tile_i_len; tile_i++)
    {
        data_base = 0;
        for (int tile_j = 0; tile_j < tile_j_len; tile_j++)
        {
            asm volatile("mzero m1");            
            asm volatile("mzero m2");
            asm volatile("mzero m3");            
            asm volatile("mzero m4");
            int data_row = 0;
            for (int tile_k = 0; tile_k < IC; tile_k++)
            {
                //CSR_CLEAR_BITS(CSR_REG_MCOUNTINHIBIT, 0x1);
                //CSR_WRITE(CSR_REG_MCYCLE, 0);
                for (int replica = 0; replica < TILE; replica++)
                {
                    int ofs = data_base + replica;
                    int drow_ofs = data_row + ofs;
                    int dtile_ofs = replica*TILE;
                    for (int i = 0; i < KW; i++)
                    {
                        // Check that we are not out of bounds of the input in the current channel
                        // this should not block: addresses are different
                        small_data_tile[dtile_ofs] = 0; 
                        if (ofs < IW) {
                            small_data_tile[dtile_ofs] = data[drow_ofs];
                        }
                        
                        ofs++;
                        drow_ofs++;
                        dtile_ofs++;
                    }
                    //CSR_READ(CSR_REG_MCYCLE, &cycles);
                    //printf("cyc: %d\n", cycles);
                }
                data_row += IW;

                asm volatile("mld.w m0, (%1), %0" ::"r"(TILE * 4), "r"(small_data_tile));
                asm volatile("mld.w m5, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base));
                asm volatile("mmasa.w m1, m0, m5");
                asm volatile("mld.w m6, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW));
                asm volatile("mmasa.w m2, m0, m6");
                asm volatile("mld.w m7, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW*2));
                asm volatile("mmasa.w m3, m0, m7");
                asm volatile("mld.w m5, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW*3));
                asm volatile("mmasa.w m4, m0, m5");      
                kernel_base += KW;
                // swap
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_old) : "r"(small_data_tile_cur));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
            }
            int32_t *outptr = (out + (tile_i * IW * 4 + tile_j) * TILE);
            asm volatile("mst.w m1, (%1), %0" ::"r"(IW * 4), "r"(outptr));
            asm volatile("mst.w m2, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW));
            asm volatile("mst.w m3, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW*2));
            asm volatile("mst.w m4, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW*3));

            data_base += TILE;
            kernel_base -= KW * IC;
        }
        kernel_base += TILE * IC * KW*4;
    }
}

void conv1d_tile_lt_kw_reord_theoretical(int32_t *data, int32_t *kernels, int32_t *out)
{
    // should be ceil_div(ic*kw, tile) * tile
    // and initialized to 0
    int tile_i_len = CEIL_DIV(OC, TILE*4);
    int tile_j_len = CEIL_DIV(IW, TILE);
    int data_base;
    int cycles;
    int32_t *kernel_base = kernels;
    register int32_t *small_data_tile = small_data_tile_a;
    register int32_t *temp;
    for (int tile_i = 0; tile_i < tile_i_len; tile_i++)
    {
        data_base = 0;
        for (int tile_j = 0; tile_j < tile_j_len; tile_j++)
        {
            asm volatile("mzero m1");            
            asm volatile("mzero m2");
            asm volatile("mzero m3");            
            asm volatile("mzero m4");
            int data_row = 0;
            for (int tile_k = 0; tile_k < IC; tile_k++)
            {
                asm volatile("mzero m0");
                asm volatile("mzero m5");
                asm volatile("mzero m6");
                asm volatile("mzero m7");

                for (int replica = 0; replica < TILE; replica++)
                {
                    int ofs = data_base + replica;
                    int drow_ofs = data_row + ofs;
                    int dtile_ofs = replica*TILE;
                    int lim = (IW-ofs > KW) ? KW : IW-ofs;
                    for (int i = 0; i < lim; i++)
                    {
                        // Check that we are not out of bounds of the input in the current channel
                        // this should not block: addresses are different
                        small_data_tile[dtile_ofs] = data[drow_ofs];
                        drow_ofs++;
                        dtile_ofs++;
                    }
                    /*for (int i = lim; i < KW; i++)
                    {
                        // Check that we are not out of bounds of the input in the current channel
                        // this should not block: addresses are different
                        small_data_tile[dtile_ofs] = 0;
                        dtile_ofs++;
                    }*/
                }
                data_row += IW;

                asm volatile("mld.w m0, (%1), %0" ::"r"(TILE * 4), "r"(small_data_tile));
                asm volatile("mld.w m5, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base));
                asm volatile("mmasa.w m1, m0, m5");
                asm volatile("mld.w m6, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW));
                asm volatile("mmasa.w m2, m0, m6");
                asm volatile("mld.w m7, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW*2));
                asm volatile("mmasa.w m3, m0, m7");
                asm volatile("mld.w m5, (%1), %0" ::"r"(IC * KW * 4), "r"(kernel_base+TILE * IC * KW*3));
                asm volatile("mmasa.w m4, m0, m5");      
                kernel_base += KW;
                // swap
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_old) : "r"(small_data_tile_cur));
                // asm ("xor %0, %0, %1" : "=r"(small_data_tile_cur) : "r"(small_data_tile_old));
            }
            int32_t *outptr = (out + (tile_i * IW * 4 + tile_j) * TILE);
            asm volatile("mst.w m1, (%1), %0" ::"r"(IW * 4), "r"(outptr));
            asm volatile("mst.w m2, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW));
            asm volatile("mst.w m3, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW*2));
            asm volatile("mst.w m4, (%1), %0" ::"r"(IW * 4), "r"(outptr + TILE*IW*3));

            data_base += TILE;
            kernel_base -= KW * IC;
        }
        kernel_base += TILE * IC * KW*4;
    }
}

#define BRANCHLESS_TERNARY(c, x, y) ((-(c) & x) | (~(-(c)) & y));

void conv1d_cpu(int32_t *data, int32_t *kernels, int32_t *out)
{
    for (int i = 0; i < OC; i++)
    {
        for (int j = 0; j < IW; j++)
        {
            out[IW * i + j] = 0;
            for (int w_i = 0; w_i < KW; w_i++)
            {
                for (int w_j = 0; w_j < IC; w_j++)
                {
                    int data_idx = j + w_i;
                    int kernel_idx = (IC * i + w_j) * KW + w_i;
                    int data_at_idx = BRANCHLESS_TERNARY(data_idx < IW, data[w_j * IW + j + w_i], 0);
                    out[IW * i + j] += data_at_idx * kernels[kernel_idx];
                }
            }
        }
    }
}

/*
void conv1d_cpu(int32_t *data, int32_t *kernels, int32_t *out)
{
    for (int i = 0; i < OC; i++)
    {
        for (int j = 0; j < N; j++)
        {
            out[N * i + j] = 0;
            for (int c = 0; c < IC; c++)
            {
                for (int r = 0; r < W; r++)
                {
                    if ((j + r) < N) {
                        out[IW * i + j] += data[c * IW + j + r] * kernels[(IC * i + c) * KW + r];
                    }                    
                }
            }
        }
    }
}*/

int check_result(int32_t *result) {
    int err = 0;
    for (int i = 0; i < OC; i++)
    {
        for (int j = 0; j < IW; j++)
        {
            if (result[IW * i + j] != EXPECTED[IW * i + j])
            {
                err++;
                //PRINTF("exp %d got %d\n\r", EXPECTED[IW * i + j], result[IW * i + j]);
            }
        }
    }
    return err;
}

#include "exo/conv1d_exo.h"

int main()
{
    unsigned int cycles;
    unsigned int cpucycles;
    for (int i = 0; i < TILE; i++)
    {
        for (int j = 0; j < TILE; j++)
        {
            small_data_tile_a[i*TILE+j] = 0;
            small_data_tile_b[i*TILE+j] = 0;
        }
    }

    CSR_CLEAR_BITS(CSR_REG_MCOUNTINHIBIT, 0x1);
    CSR_WRITE(CSR_REG_MCYCLE, 0);
#if 0
    conv1d_tile_lt_kw_reord_theoretical(DATA, KERNELS, result);
#else 
    struct exo_win_2i32c data_in = {
        DATA,
        {0,0}
    };
    struct exo_win_2i32c kernels_in = {
        KERNELS,
        {0,0}
    };
    struct exo_win_2i32 result_out = {
        result,
        {0,0}
    };
    exo_conv1d_tile_lt_kw(NULL, DATA, KERNELS, result);
#endif
    CSR_READ(CSR_REG_MCYCLE, &cycles);   
    
    PRINTF("err: %d\n\r", check_result(result));

    CSR_CLEAR_BITS(CSR_REG_MCOUNTINHIBIT, 0x1);
    CSR_WRITE(CSR_REG_MCYCLE, 0);
    conv1d_tile_lt_kw_reord(DATA, KERNELS, result);
    CSR_READ(CSR_REG_MCYCLE, &cpucycles);   

    PRINTF("Accelerated: %d\n\r"
           "CPU:         %d\n\r", cycles, cpucycles);
    return 0;
}
