from __future__ import annotations
import os
import sys
from exo import proc
from exo.libs.memories import *
from exo.platforms.x86 import *
from exo.stdlib.scheduling import *
from exo.stdlib.stdlib import *
from helpers import *

IC = 4
N = 16
OC = 16
KW = 4
TILE = 4
@proc
def conv1d(
    data: i32[IC, N],
    kernels: i32[OC, IC, KW],
    out: i32[OC, N]
):
    assert(KW == TILE)
    for tile_i in seq(0, OC/TILE):
        for tile_j in seq(0, N/TILE):    
            for c in seq(0, IC):
                y: i32[TILE,TILE]
                for ji in seq(0, TILE):
                    for ri in seq(0, KW):
                        y[ji,ri] = 0
                        if (tile_j * TILE + ji + ri) < N: 
                            y[ji,ri] = data[c,tile_j * TILE + ji + ri]
                for im in seq(0, TILE):
                    for jm in seq(0, TILE):
                        for rm in seq(0, IC):
                            out[tile_i * TILE + im, tile_j * TILE + jm] += kernels[tile_i*TILE+im,c,rm] * y[jm,rm]

class RVM_TILE(StaticMemory):
    NUM_RVM_TILES = 8
    StaticMemory.init_state(NUM_RVM_TILES)
    tile_dict = {}

    # TODO: have a better way of doing this rather than manually
    # calling this after each test that fails to compile.
    @classmethod
    def reset_allocations(cls):
        cls.init_state(cls.NUM_RVM_TILES)
        cls.tile_dict = {}

    @classmethod
    def can_read(cls):
        return False

    @classmethod
    def alloc(cls, new_name, prim_type, shape, srcinfo):
        if not (shape[0].isdecimal() and int(shape[0]) == 4):
            raise MemGenError("Number of tile rows must be 4.")
        if not (shape[1].isdecimal() and int(shape[1]) == 4):
            raise MemGenError("Number of tile columns must be 4.")

        tile_num = cls.find_free_chunk()
        cls.mark(tile_num)
        cls.tile_dict[new_name] = tile_num
        return f"#define {new_name} \"m{7-tile_num}\""

    @classmethod
    def free(cls, new_name, prim_type, shape, srcinfo):
        tile_num = cls.tile_dict[new_name]
        del cls.tile_dict[new_name]
        cls.unmark(tile_num)
        return f"#undef {new_name}"
    
class DRAM_INTERLEAVED(DRAM):
    @classmethod
    def alloc(cls, new_name, prim_type, shape, srcinfo):
        # Error checking only
        for extent in shape:
            try:
                int(extent)
            except ValueError as e:
                raise MemGenError(
                    f"DRAM_STATIC requires constant shapes. Saw: {extent}"
                ) from e

        return f'static {prim_type} __attribute__((section(".xheep_data_interleaved"))) {new_name}[{" * ".join(shape)}];'

    @classmethod
    def free(cls, new_name, prim_type, shape, srcinfo):
        return ""

@instr('asm volatile("mmasa.w "{md_int}", "{ms1_int}", "{ms2_int});')
def rvm_mmasa(md: [i32][4,4] @ RVM_TILE, ms1: [i32][4,4] @ RVM_TILE, ms2: [i32][4,4] @ RVM_TILE):
    assert stride(md, 1) == 1
    assert stride(ms1, 1) == 1
    assert stride(ms2, 1) == 1
    for i in seq(0,4):
        for j in seq(0,4):
            for k in seq(0,4):
                md[i,j] += ms2[i,k] * ms1[j,k]

@instr('asm volatile("mld.w "{dst_int}", (%1), %0" :: "r"(4*({src}.strides[0])), "r"(&{src_data}));')
def rvm_mld(dst: [i32][4,4] @ RVM_TILE, src: [i32][4,4] @ DRAM):
    assert stride(src, 1) == 1
    assert stride(dst, 1) == 1

    for i in seq(0, 4):
        for j in seq(0,4):
            dst[i,j] = src[i,j]

@instr('asm volatile("mzero "{dst_int});')
def rvm_mzero(dst: [i32][4,4] @ RVM_TILE):
    assert stride(dst, 1) == 1

    for i in seq(0, 4):
        for j in seq(0,4):
            dst[i,j] = 0

@instr('asm volatile("mst.w "{src_int}", (%1), %0" :: "r"(4*({dst}.strides[0])), "r"(&{dst_data}));')
def rvm_mst(src: [i32][4,4] @ RVM_TILE, dst: [i32][4,4] @ DRAM):
    assert stride(src, 1) == 1
    assert stride(dst, 1) == 1

    for i in seq(0, 4):
        for j in seq(0,4):
            dst[i,j] = src[i,j]




# Setting up data tile load 
conv1d = stage_mem(conv1d, 'for im in _:_', f'y[0:{TILE}, 0:{TILE}]', "data_tile")
print(conv1d)
conv1d = set_memory(conv1d, "data_tile", RVM_TILE)
conv1d = replace(conv1d, "for i0 in _:_", rvm_mld)

# Setting up kernel tile load
conv1d = stage_mem(conv1d, 'for im in _:_', f'kernels[tile_i*{TILE}:tile_i*{TILE}+{TILE}, c, 0:{TILE}]', "kernel_tile")
conv1d = set_memory(conv1d, "kernel_tile", RVM_TILE)
conv1d = replace(conv1d, "for i0 in _:_", rvm_mld)

# Setting up output tiles
conv1d = stage_mem(conv1d, 'for c in _:_', f'out[tile_i*{TILE}:tile_i*{TILE}+{TILE}, tile_j*{TILE}:tile_j*{TILE}+{TILE}]', "output_tile")
conv1d = set_memory(conv1d, "output_tile", RVM_TILE)
conv1d = simplify(conv1d)
conv1d = replace(conv1d, "for im in _:_", rvm_mmasa)
conv1d = replace(conv1d, "for i0 in _:_ #1", rvm_mst)

from pygments import highlight
from pygments.lexers import get_lexer_by_name

# Formatting the output to be sent to a terminal
# Hence using Terminal256Formatter. Many other formatters 
from pygments.formatters import Terminal256Formatter, HtmlFormatter
print(highlight(str(conv1d), 
                lexer=get_lexer_by_name("python"), 
                formatter=Terminal256Formatter()))