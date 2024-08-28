#include "defs.h"
void conv1d_cpu(int32_t *data, int32_t *kernels, int32_t *out) {
    for (int i = 0; i < OC; i++) {
        for (int j = 0; j < N; j++) {
            out[i][j] = 0;
            for (int c = 0; c < IC; c++) {
                for (int r = 0; r < W; r++) {
                    if ((j + r) < N) {
                        out[i][j] += data[c][j + r] * kernels[i][c][r];
                    }                    
                }
            }
        }
    }
}