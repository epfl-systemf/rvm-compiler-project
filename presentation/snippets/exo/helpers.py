from exo import proc
import exo.API_cursors as pc
from exo.libs.memories import *
from exo.platforms.x86 import *
from exo.stdlib.scheduling import *

def fuse_two_loops(p, c):
    """
    for i in ...:         <- c
        for j in ...:
            s1
    for k in ...:         <- c.next()
        for i in ...:
            s2
    ---->
    for i in ...:         <- c
        for j in ...:
            s1
        for k in ...:
            s2
    """
    try:
        next_c = c.next()
    except:
        return p, False

    if isinstance(c, pc.ForCursor) and isinstance(next_c, pc.ForCursor):
        if c.name() == next_c.name() and expr_to_string(c.hi()) == expr_to_string(
            next_c.hi()
        ):
            p = fuse(p, c, next_c, unsafe_disable_check=False)
            return p, True
        else:
            tgt_c, count = find_child_loop(next_c, c.name())
            if tgt_c:
                p = lift_scope_n(p, tgt_c, n_lifts=count)
                p = fuse(p, c, tgt_c, unsafe_disable_check=False)
                return p, True

    return p, False


def fuse_all_loops(p, cursor):
    """
    recursively calls fuse_two_loops to all the loops
    """
    while True:
        if isinstance(cursor, pc.ForCursor):
            p = fuse_all_loops(p, cursor.body()[0])

        # Fuse in current scope
        p, b = fuse_two_loops(p, cursor)

        if b:
            cursor = p.forward(cursor)
        else:
            try:
                cursor = p.forward(cursor).next()
            except:
                break

    return p

def autolift_alloc(p, alloc_c, dep_set=None, max_size=0, lift=True):
    """
    for i in seq(0, 10):
        for j in seq(0, 20):
            a : R          <- alloc_c, dep_set = {'i'}
            a[i] = ...
    ---->
    a : R[10]              <- if size is less than max_size
    for i in seq(0, n):
        for j in seq(0, m):
            a[i] = ...
    """
    alloc_c = p.forward(alloc_c)
    loop_c = get_enclosing_loop(p, alloc_c)
    accum_size = 1
    while True:
        try:
            if not isinstance(loop_c, pc.ForCursor):
                break
            if dep_set == None or loop_c.name() in dep_set:
                if (
                    isinstance(loop_c.hi(), LiteralCursor)
                    and accum_size * loop_c.hi().value() <= max_size
                ):
                    p = expand_dim(p, alloc_c, loop_c.hi().value(), loop_c.name())
                    accum_size = accum_size * loop_c.hi().value()
                    if lift:
                        p = lift_alloc(p, alloc_c)
            loop_c = loop_c.parent()
        except:
            break
    return p