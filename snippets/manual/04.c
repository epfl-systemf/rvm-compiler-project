#include "defs.h"
#define TILE 4
void conv1d_im2col_tile(int32_t *data, int32_t *kernels, int32_t *out) {
    for (int tile_i = 0; tile_i < OC/TILE; tile_i++) {
        for (int tile_j = 0; tile_j < N/TILE; tile_j++) {
            asm volatile ("mzero m2");
            for (int c = 0; c < IC; c++) {
                int32_t y[TILE][TILE];
                for (int j = 0; j < TILE; j++) {
                    for (int r = 0; r < TILE; r++) {
                        if (((tile_j*TILE + j) + r) < N) {
                            y[j][r] = data[c][(tile_j*TILE + j)+r];
                        } else {
                            y[j][r] = 0;
                        }                    
                    }
                }
                // matrix multiplication
                asm volatile ("mld.w m0, (%0), %1"
                    :: "r"(y), "r"(TILE*4));
                asm volatile ("mld.w m1, (%0), %1"
                    :: "r"(&kernels[tile_i*TILE][c][0]), "r"(IC * W * 4));
                asm volatile ("mmasa.w m2, m0, m1");
            }
            asm volatile ("mst.w m2, (%0), %1"
                :: "r"(&out[tile_i*TILE][tile_j*TILE]), "r"(N * 4));
        }
    }
}