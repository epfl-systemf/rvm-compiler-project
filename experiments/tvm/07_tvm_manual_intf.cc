#include "dlpack/dlpack.h"
#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>

#include "../out/tvm_out.h"

#define N 16

void fill_buffer_rand(float* buf, size_t n, unsigned int seed) {
    srand(seed);
    for (int i = 0; i < n; i++) {
        buf[i] = (float)(rand() >> 15);
    }
}

void print_mat(DLTensor* dt) {
    int n = dt->shape[0];
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            printf("%0.2f ", ((float*)dt->data)[i*n+j]);
        }
        printf("\n");
    }
}
void ref_matmul(float *x, float *y, float *z) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            z[i * N + j] = 0;
            for (int k = 0; k < N; k++) {
                z[i * N + j] += x[i * N + k] * y[j * N + k];
            }
        }
    }
}

int cmp_mat(float *z, float *z_ref) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            if (z_ref[i * N + j] - z[i * N + j] > 0.01) {
                printf("FATAL MISMATCH: got %f, exp %f\n", z[i * N + j],
                       z_ref[i * N + j]);
                return -1;
            }
        }
    }
    printf("Pass!\n");
    return 0;
}

int64_t SHAPE[] = {N,N};

int main() {

    DLTensor* A = (DLTensor*)malloc(sizeof(DLTensor));
    A->data = calloc(N * N, sizeof(float));
    A->ndim = 2;
    A->dtype = (DLDataType){kDLFloat, 32, 1};
    A->shape = SHAPE;
    A->device = (DLDevice){kDLCPU, 0};
    A->strides = NULL;
    fill_buffer_rand((float*)A->data, N*N, 0);

    TVMValue At;
    At.v_handle = A;

    DLTensor* B = (DLTensor*)malloc(sizeof(DLTensor));
    B->data = calloc(N * N, sizeof(float));
    B->ndim = 2;
    B->dtype = (DLDataType){kDLFloat, 32, 1};
    B->shape = SHAPE;
    B->device = (DLDevice){kDLCPU, 0};
    B->strides = NULL;
    fill_buffer_rand((float*)(B->data), N*N, 1);

    TVMValue Bt;
    Bt.v_handle = B;

    DLTensor* C = (DLTensor*)malloc(sizeof(DLTensor));
    C->data = calloc(N * N, sizeof(float));
    C->ndim = 2;
    C->dtype = (DLDataType){kDLFloat, 32, 1};
    C->shape = SHAPE;
    C->device = (DLDevice){kDLCPU, 0};
    C->strides = NULL;

    TVMValue Ct;
    Ct.v_handle = C;

    printf("A:\n");
    print_mat(A);
    printf("B:\n");
    print_mat(B);

    TVMValue args[] = {At,Bt,Ct};
    int arg_type_ids[]  = {0,0,0};
    __tvm_main__(args, arg_type_ids, 3, NULL, NULL, NULL);

    float c_ref[N*N] = {0};
    ref_matmul((float*)A->data, (float*)B->data, c_ref);
    cmp_mat((float*)C->data, c_ref);


    return 0;
}