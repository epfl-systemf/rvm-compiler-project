#include "defs.h"
#define TILE 4
void conv1d_im2col_tile(int32_t *data, int32_t *kernels, int32_t *out) {
    for (int tile_i = 0; tile_i < OC/TILE; tile_i++) {
        for (int tile_j = 0; tile_j < N/TILE; tile_j++) {
            for (int c = 0; c < IC; c++) {
                int32_t y[TILE][TILE];
                // perform im2col
                for (int j = 0; j < TILE; j++) {
                    // assumed that W == TILE!
                    for (int r = 0; r < TILE; r++) {
                        if (((tile_j*TILE + j) + r) < N) {
                            y[j][r] = data[c][(tile_j*TILE + j)+r];
                        } else {
                            y[j][r] = 0;
                        }                    
                    }
                }
                // matrix multiplication
                for (int i = 0; i < TILE; i++) {
                    for (int j = 0; j < TILE; j++) {
                        out[i][j] = 0;
                        for (int r = 0; r < TILE; r++) {
                            out[i][j] += y[j][r] * kernels[tile_i*TILE + i][c][r];
                        }
                    }
                }
            }
        }
    }
}