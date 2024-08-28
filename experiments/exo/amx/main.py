from __future__ import annotations

import os
import pytest

from exo import proc
from exo.stdlib.scheduling import *

@proc
def matmul_on_amx(
    M: size,
    K: size,
    N: size,
    A: i8[M, 4 * K] @ DRAM,
    B: i8[K, 4 * N] @ DRAM,
    C: i32[M, N] @ DRAM,
):
    assert M % 32 == 0
    assert N % 32 == 0
    assert K % 16 == 0
    config()
    for i in seq(0, M / 32):
        for j in seq(0, N / 32):
            tileC1: i32[16, 16] @ AMX_TILE
            tileC2: i32[16, 16] @ AMX_TILE
            tileC3: i32[16, 16] @ AMX_TILE
            tileC4: i32[16, 16] @ AMX_TILE

            ld_i32(16, 16, C[i * 32 : i * 32 + 16, j * 32 : j * 32 + 16], tileC1)
            ld_i32(
                16, 16, C[i * 32 : i * 32 + 16, j * 32 + 16 : j * 32 + 32], tileC2
            )
            ld_i32(
                16, 16, C[i * 32 + 16 : i * 32 + 32, j * 32 : j * 32 + 16], tileC3
            )
            ld_i32(
                16,
                16,
                C[i * 32 + 16 : i * 32 + 32, j * 32 + 16 : j * 32 + 32],
                tileC4,
            )

            for k in seq(0, K / 16):
                tileA1: i8[16, 64] @ AMX_TILE
                tileA2: i8[16, 64] @ AMX_TILE
                tileB1: i8[16, 64] @ AMX_TILE
                tileB2: i8[16, 64] @ AMX_TILE

                ld_i8(
                    16,
                    64,
                    A[16 * 2 * i : 16 * (2 * i + 1), 64 * k : 64 * (k + 1)],
                    tileA1,
                )
                ld_i8(
                    16,
                    64,
                    A[16 * (2 * i + 1) : 16 * (2 * i + 2), 64 * k : 64 * (k + 1)],
                    tileA2,
                )
                ld_i8(
                    16,
                    64,
                    B[16 * k : 16 * (k + 1), 64 * 2 * j : 64 * (2 * j + 1)],
                    tileB1,
                )
                ld_i8(
                    16,
                    64,
                    B[16 * k : 16 * (k + 1), 64 * (2 * j + 1) : 64 * (2 * j + 2)],
                    tileB2,
                )
                dpbssd(16, 16, 16, tileA1, tileB1, tileC1)
                dpbssd(16, 16, 16, tileA1, tileB2, tileC2)
                dpbssd(16, 16, 16, tileA2, tileB1, tileC3)
                dpbssd(16, 16, 16, tileA2, tileB2, tileC4)

            st_i32(
                16,
                16,
                tileC1,
                C[16 * 2 * i : 16 * (2 * i + 1), 16 * 2 * j : 16 * (2 * j + 1)],
            )
            st_i32(
                16,
                16,
                tileC2,
                C[
                    16 * 2 * i : 16 * (2 * i + 1),
                    16 * (2 * j + 1) : 16 * (2 * j + 2),
                ],
            )
            st_i32(
                16,
                16,
                tileC3,
                C[
                    16 * (2 * i + 1) : 16 * (2 * i + 2),
                    16 * 2 * j : 16 * (2 * j + 1),
                ],
            )
            st_i32(
                16,
                16,
                tileC4,
                C[
                    16 * (2 * i + 1) : 16 * (2 * i + 2),
                    16 * (2 * j + 1) : 16 * (2 * j + 2),
                ],
            )

size1 = 256
size2 = 256
