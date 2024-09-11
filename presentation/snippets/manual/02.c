#include "defs.h"
void conv1d_im2col(int32_t *data, int32_t *kernels, int32_t *out) {
    int32_t y[N][IC][W];
    // perform im2col
    for (int j = 0; j < N; j++) {
        for (int c = 0; c < IC; c++) {
            for (int r = 0; r < W; r++) {
                if ((j + r) < N) {
                    y[j][c][r] = data[c][j+r];
                } else {
                    y[j][c][r] = 0;
                }                    
            }
        }
    }
    // matrix multiplication
    for (int i = 0; i < OC; i++) {
        for (int j = 0; j < N; j++) {
            out[i][j] = 0;
            for (int c = 0; c < IC; c++) {
                for (int r = 0; r < W; r++) {
                    out[i][j] += y[j][c][r] * kernels[i][c][r];
                }
            }
        }
    }
}