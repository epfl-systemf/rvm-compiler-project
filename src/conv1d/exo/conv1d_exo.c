#include "conv1d_exo.h"

#include <stdio.h>
#include <stdlib.h>

#include <stdio.h>
#include <stdlib.h>


// exo_conv1d_tile_lt_kw(
//     data : i32[4, 16] @DRAM,
//     kernels : i32[16, 4, 4] @DRAM,
//     out : i32[16, 16] @DRAM
// )
void exo_conv1d_tile_lt_kw( void *ctxt, const int32_t* data, const int32_t* kernels, int32_t* out ) {
for (int_fast32_t ioo = 0; ioo < 1; ioo++) {
  for (int_fast32_t jo = 0; jo < 4; jo++) {
    #define out_tile "m7"
    asm volatile("mzero "out_tile);
    asm volatile("mzero "out_tile);
    asm volatile("mzero "out_tile);
    asm volatile("mzero "out_tile);
    for (int_fast32_t c = 0; c < 4; c++) {
      static int32_t y[4 * 4];
      for (int_fast32_t ji = 0; ji < 4; ji++) {
        for (int_fast32_t r = 0; r < 4; r++) {
          if (ji + r + 4 * jo < 4) {
            y[ji * 4 + r] = data[c * 16 + ji + r + 4 * jo];
          } else {
            y[ji * 4 + r] = ((int32_t) 0);
          }
        }
      }
      #define kernel_tile_0 "m6"
      #define kernel_tile_1 "m5"
      #define kernel_tile_2 "m4"
      #define data_tile "m3"
      asm volatile("mld.w "data_tile", (%1), %0" :: "r"(4*(((struct exo_win_2i32c){ &y[0], { 4, 1 } }).strides[0])), "r"(&y[0]));
      asm volatile("mld.w "kernel_tile_0", (%1), %0" :: "r"(4*(((struct exo_win_2i32c){ &kernels[(16 * ioo) * (16) + (c) * 4], { 16, 1 } }).strides[0])), "r"(&kernels[(16 * ioo) * (16) + (c) * 4]));
      asm volatile("mmasa.w "out_tile", "data_tile", "kernel_tile_0);
      asm volatile("mld.w "kernel_tile_1", (%1), %0" :: "r"(4*(((struct exo_win_2i32c){ &kernels[(4 + 16 * ioo) * (16) + (c) * 4], { 16, 1 } }).strides[0])), "r"(&kernels[(4 + 16 * ioo) * (16) + (c) * 4]));
      asm volatile("mmasa.w "out_tile", "data_tile", "kernel_tile_1);
      #undef kernel_tile_1
      asm volatile("mld.w "kernel_tile_2", (%1), %0" :: "r"(4*(((struct exo_win_2i32c){ &kernels[(8 + 16 * ioo) * (16) + (c) * 4], { 16, 1 } }).strides[0])), "r"(&kernels[(8 + 16 * ioo) * (16) + (c) * 4]));
      asm volatile("mmasa.w "out_tile", "data_tile", "kernel_tile_2);
      #undef kernel_tile_2
      asm volatile("mld.w "kernel_tile_0", (%1), %0" :: "r"(4*(((struct exo_win_2i32c){ &kernels[(12 + 16 * ioo) * (16) + (c) * 4], { 16, 1 } }).strides[0])), "r"(&kernels[(12 + 16 * ioo) * (16) + (c) * 4]));
      asm volatile("mmasa.w "out_tile", "data_tile", "kernel_tile_0);
      #undef data_tile
      #undef kernel_tile_0
    }
    asm volatile("mst.w "out_tile", (%1), %0" :: "r"(4*(((struct exo_win_2i32){ &out[(16 * ioo) * (16) + 4 * jo], { 16, 1 } }).strides[0])), "r"(&out[(16 * ioo) * (16) + 4 * jo]));
    asm volatile("mst.w "out_tile", (%1), %0" :: "r"(4*(((struct exo_win_2i32){ &out[(4 + 16 * ioo) * (16) + 4 * jo], { 16, 1 } }).strides[0])), "r"(&out[(4 + 16 * ioo) * (16) + 4 * jo]));
    asm volatile("mst.w "out_tile", (%1), %0" :: "r"(4*(((struct exo_win_2i32){ &out[(8 + 16 * ioo) * (16) + 4 * jo], { 16, 1 } }).strides[0])), "r"(&out[(8 + 16 * ioo) * (16) + 4 * jo]));
    asm volatile("mst.w "out_tile", (%1), %0" :: "r"(4*(((struct exo_win_2i32){ &out[(12 + 16 * ioo) * (16) + 4 * jo], { 16, 1 } }).strides[0])), "r"(&out[(12 + 16 * ioo) * (16) + 4 * jo]));
    #undef out_tile
  }
}
}


/* relying on the following instruction..."
rvm_mld(dst,src)
asm volatile("mld.w "{dst_int}", (%1), %0" :: "r"(4*({src}.strides[0])), "r"(&{src_data}));
*/

/* relying on the following instruction..."
rvm_mmasa(md,ms1,ms2)
asm volatile("mmasa.w "{md_int}", "{ms1_int}", "{ms2_int});
*/

/* relying on the following instruction..."
rvm_mst(src,dst)
asm volatile("mst.w "{src_int}", (%1), %0" :: "r"(4*({dst}.strides[0])), "r"(&{dst_data}));
*/

/* relying on the following instruction..."
rvm_mzero(dst)
asm volatile("mzero "{dst_int});
*/
