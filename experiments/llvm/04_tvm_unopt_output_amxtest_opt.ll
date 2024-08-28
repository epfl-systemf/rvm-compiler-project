; ModuleID = 'llvm/04_tvm_unopt_output_amxtest_opt.bc'
source_filename = "TVMMod"
target datalayout = "e-m:e-p:32:32-p270:32:32-p271:32:32-p272:64:64-i64:64-i128:128-n32-S128"
target triple = "x86_64-unknown-linux-gnu"

%0 = type { double }
%1 = type { ptr, %2, i32, %3, ptr, ptr, i64 }
%2 = type { i32, i32 }
%3 = type { i8, i8, i16 }

@__tvm_module_ctx = linkonce dllexport global ptr null, align 4
@__TVMFuncCall = linkonce dllexport global ptr null, align 4
@__TVMBackendGetFuncFromEnv = linkonce dllexport global ptr null, align 4
@__TVMAPISetLastError = linkonce dllexport global ptr null, align 4
@__TVMBackendParallelLaunch = linkonce dllexport global ptr null, align 4
@__TVMBackendParallelBarrier = linkonce dllexport global ptr null, align 4
@.str = private constant [67 x i8] c"Assert fail: num_args == 3, before_tensorize: num_args should be 3\00", align 1
@.str.1 = private constant [146 x i8] c"Assert fail: A_handle_code == 3 or A_handle_code == 13 or A_handle_code == 7 or A_handle_code == 4, before_tensorize: Expect arg[0] to be pointer\00", align 1
@.str.2 = private constant [146 x i8] c"Assert fail: B_handle_code == 3 or B_handle_code == 13 or B_handle_code == 7 or B_handle_code == 4, before_tensorize: Expect arg[1] to be pointer\00", align 1
@.str.3 = private constant [146 x i8] c"Assert fail: C_handle_code == 3 or C_handle_code == 13 or C_handle_code == 7 or C_handle_code == 4, before_tensorize: Expect arg[2] to be pointer\00", align 1
@.str.4 = private constant [115 x i8] c"Assert fail: 2 == T.tvm_struct_get(A_handle, 0, 4, \22int32\22), before_tensorize.A_handle.ndim is expected to equal 2\00", align 1
@.str.5 = private constant [251 x i8] c"Assert fail: T.tvm_struct_get(A_handle, 0, 5, \22uint8\22) == T.uint8(2) and T.tvm_struct_get(A_handle, 0, 6, \22uint8\22) == T.uint8(32) and T.tvm_struct_get(A_handle, 0, 7, \22uint16\22) == T.uint16(1), before_tensorize.A_handle.dtype is expected to be float32\00", align 1
@.str.6 = private constant [205 x i8] c"Assert fail: T.Cast(\22int32\22, before_tensorize_A_handle_shape[0]) == 16, Argument before_tensorize.A_handle.shape[0] has an unsatisfied constraint: 16 == T.Cast(\22int32\22, before_tensorize_A_handle_shape[0])\00", align 1
@.str.7 = private constant [205 x i8] c"Assert fail: T.Cast(\22int32\22, before_tensorize_A_handle_shape[1]) == 16, Argument before_tensorize.A_handle.shape[1] has an unsatisfied constraint: 16 == T.Cast(\22int32\22, before_tensorize_A_handle_shape[1])\00", align 1
@.str.8 = private constant [201 x i8] c"Assert fail: 1 == T.Cast(\22int32\22, before_tensorize_A_handle_strides[1]) and 16 == T.Cast(\22int32\22, before_tensorize_A_handle_strides[0]), before_tensorize.A_handle.strides: expected to be compact array\00", align 1
@.str.9 = private constant [208 x i8] c"Assert fail: T.uint64(0) == T.tvm_struct_get(A_handle, 0, 8, \22uint64\22), Argument before_tensorize.A_handle.byte_offset has an unsatisfied constraint: T.uint64(0) == T.tvm_struct_get(A_handle, 0, 8, \22uint64\22)\00", align 1
@.str.10 = private constant [188 x i8] c"Assert fail: T.tvm_struct_get(A_handle, 0, 10, \22int32\22) == 1, Argument before_tensorize.A_handle.device_type has an unsatisfied constraint: 1 == T.tvm_struct_get(A_handle, 0, 10, \22int32\22)\00", align 1
@.str.11 = private constant [115 x i8] c"Assert fail: 2 == T.tvm_struct_get(B_handle, 0, 4, \22int32\22), before_tensorize.B_handle.ndim is expected to equal 2\00", align 1
@.str.12 = private constant [251 x i8] c"Assert fail: T.tvm_struct_get(B_handle, 0, 5, \22uint8\22) == T.uint8(2) and T.tvm_struct_get(B_handle, 0, 6, \22uint8\22) == T.uint8(32) and T.tvm_struct_get(B_handle, 0, 7, \22uint16\22) == T.uint16(1), before_tensorize.B_handle.dtype is expected to be float32\00", align 1
@.str.13 = private constant [205 x i8] c"Assert fail: T.Cast(\22int32\22, before_tensorize_B_handle_shape[0]) == 16, Argument before_tensorize.B_handle.shape[0] has an unsatisfied constraint: 16 == T.Cast(\22int32\22, before_tensorize_B_handle_shape[0])\00", align 1
@.str.14 = private constant [205 x i8] c"Assert fail: T.Cast(\22int32\22, before_tensorize_B_handle_shape[1]) == 16, Argument before_tensorize.B_handle.shape[1] has an unsatisfied constraint: 16 == T.Cast(\22int32\22, before_tensorize_B_handle_shape[1])\00", align 1
@.str.15 = private constant [201 x i8] c"Assert fail: 1 == T.Cast(\22int32\22, before_tensorize_B_handle_strides[1]) and 16 == T.Cast(\22int32\22, before_tensorize_B_handle_strides[0]), before_tensorize.B_handle.strides: expected to be compact array\00", align 1
@.str.16 = private constant [208 x i8] c"Assert fail: T.uint64(0) == T.tvm_struct_get(B_handle, 0, 8, \22uint64\22), Argument before_tensorize.B_handle.byte_offset has an unsatisfied constraint: T.uint64(0) == T.tvm_struct_get(B_handle, 0, 8, \22uint64\22)\00", align 1
@.str.17 = private constant [188 x i8] c"Assert fail: T.tvm_struct_get(B_handle, 0, 10, \22int32\22) == 1, Argument before_tensorize.B_handle.device_type has an unsatisfied constraint: 1 == T.tvm_struct_get(B_handle, 0, 10, \22int32\22)\00", align 1
@.str.18 = private constant [194 x i8] c"Assert fail: dev_id == T.tvm_struct_get(B_handle, 0, 9, \22int32\22), Argument before_tensorize.B_handle.device_id has an unsatisfied constraint: dev_id == T.tvm_struct_get(B_handle, 0, 9, \22int32\22)\00", align 1
@.str.19 = private constant [115 x i8] c"Assert fail: 2 == T.tvm_struct_get(C_handle, 0, 4, \22int32\22), before_tensorize.C_handle.ndim is expected to equal 2\00", align 1
@.str.20 = private constant [251 x i8] c"Assert fail: T.tvm_struct_get(C_handle, 0, 5, \22uint8\22) == T.uint8(2) and T.tvm_struct_get(C_handle, 0, 6, \22uint8\22) == T.uint8(32) and T.tvm_struct_get(C_handle, 0, 7, \22uint16\22) == T.uint16(1), before_tensorize.C_handle.dtype is expected to be float32\00", align 1
@.str.21 = private constant [205 x i8] c"Assert fail: T.Cast(\22int32\22, before_tensorize_C_handle_shape[0]) == 16, Argument before_tensorize.C_handle.shape[0] has an unsatisfied constraint: 16 == T.Cast(\22int32\22, before_tensorize_C_handle_shape[0])\00", align 1
@.str.22 = private constant [205 x i8] c"Assert fail: T.Cast(\22int32\22, before_tensorize_C_handle_shape[1]) == 16, Argument before_tensorize.C_handle.shape[1] has an unsatisfied constraint: 16 == T.Cast(\22int32\22, before_tensorize_C_handle_shape[1])\00", align 1
@.str.23 = private constant [201 x i8] c"Assert fail: 1 == T.Cast(\22int32\22, before_tensorize_C_handle_strides[1]) and 16 == T.Cast(\22int32\22, before_tensorize_C_handle_strides[0]), before_tensorize.C_handle.strides: expected to be compact array\00", align 1
@.str.24 = private constant [208 x i8] c"Assert fail: T.uint64(0) == T.tvm_struct_get(C_handle, 0, 8, \22uint64\22), Argument before_tensorize.C_handle.byte_offset has an unsatisfied constraint: T.uint64(0) == T.tvm_struct_get(C_handle, 0, 8, \22uint64\22)\00", align 1
@.str.25 = private constant [188 x i8] c"Assert fail: T.tvm_struct_get(C_handle, 0, 10, \22int32\22) == 1, Argument before_tensorize.C_handle.device_type has an unsatisfied constraint: 1 == T.tvm_struct_get(C_handle, 0, 10, \22int32\22)\00", align 1
@.str.26 = private constant [194 x i8] c"Assert fail: dev_id == T.tvm_struct_get(C_handle, 0, 9, \22int32\22), Argument before_tensorize.C_handle.device_id has an unsatisfied constraint: dev_id == T.tvm_struct_get(C_handle, 0, 9, \22int32\22)\00", align 1
@__tvm_main__ = weak dllexport constant [17 x i8] c"before_tensorize\00", align 1
@llvm.global_ctors = appending global [1 x { i32, ptr, ptr }] [{ i32, ptr, ptr } { i32 65535, ptr @__tvm_module_startup, ptr null }]

define dllexport i32 @before_tensorize(ptr %args, ptr %arg_type_ids, i32 %num_args, ptr %out_ret_value, ptr %out_ret_tcode, ptr %resource_handle) #0 !dbg !5 {
entry:
  %0 = alloca ptr, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %0, metadata !12, metadata !DIExpression()), !dbg !18
  store ptr %args, ptr %0, align 4, !dbg !18
  %1 = alloca ptr, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %1, metadata !13, metadata !DIExpression()), !dbg !18
  store ptr %arg_type_ids, ptr %1, align 4, !dbg !18
  %2 = alloca i32, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %2, metadata !14, metadata !DIExpression()), !dbg !18
  store i32 %num_args, ptr %2, align 4, !dbg !18
  %3 = alloca ptr, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %3, metadata !15, metadata !DIExpression()), !dbg !18
  store ptr %out_ret_value, ptr %3, align 4, !dbg !18
  %4 = alloca ptr, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %4, metadata !16, metadata !DIExpression()), !dbg !18
  store ptr %out_ret_tcode, ptr %4, align 4, !dbg !18
  %5 = alloca ptr, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %5, metadata !17, metadata !DIExpression()), !dbg !18
  store ptr %resource_handle, ptr %5, align 4, !dbg !18
  %6 = icmp eq i32 %num_args, 3, !dbg !18
  br i1 %6, label %assert_end, label %assert_fail, !dbg !18, !prof !19

assert_fail:                                      ; preds = %entry
  %7 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %7(ptr @.str), !dbg !18
  ret i32 -1, !dbg !18

assert_end:                                       ; preds = %entry
  %8 = getelementptr inbounds i32, ptr %arg_type_ids, i32 0, !dbg !18
  %A_handle.code = load i32, ptr %8, align 4, !dbg !18, !tbaa !23
  tail call void @llvm.dbg.declare(metadata i32 %A_handle.code, metadata !34, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata i32 %A_handle.code, metadata !34, metadata !DIExpression()), !dbg !18
  %9 = getelementptr inbounds i32, ptr %arg_type_ids, i32 1, !dbg !18
  %B_handle.code = load i32, ptr %9, align 4, !dbg !18, !tbaa !35
  tail call void @llvm.dbg.declare(metadata i32 %B_handle.code, metadata !37, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata i32 %B_handle.code, metadata !37, metadata !DIExpression()), !dbg !18
  %10 = getelementptr inbounds i32, ptr %arg_type_ids, i32 2, !dbg !18
  %C_handle.code = load i32, ptr %10, align 4, !dbg !18, !tbaa !38
  tail call void @llvm.dbg.declare(metadata i32 %C_handle.code, metadata !41, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata i32 %C_handle.code, metadata !41, metadata !DIExpression()), !dbg !18
  %11 = getelementptr inbounds %0, ptr %args, i32 0, !dbg !18
  %A_handle = load ptr, ptr %11, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %A_handle, metadata !42, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %A_handle, metadata !42, metadata !DIExpression()), !dbg !18
  %12 = getelementptr inbounds %0, ptr %args, i32 1, !dbg !18
  %B_handle = load ptr, ptr %12, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %B_handle, metadata !43, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %B_handle, metadata !43, metadata !DIExpression()), !dbg !18
  %13 = getelementptr inbounds %0, ptr %args, i32 2, !dbg !18
  %C_handle = load ptr, ptr %13, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %C_handle, metadata !44, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %C_handle, metadata !44, metadata !DIExpression()), !dbg !18
  %14 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 0, !dbg !18
  %A = load ptr, ptr %14, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %A, metadata !45, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %A, metadata !45, metadata !DIExpression()), !dbg !18
  call void @llvm.assume(i1 true) [ "align"(ptr %A, i32 64) ], !dbg !18
  %15 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 4, !dbg !18
  %before_tensorize.A_handle.shape = load ptr, ptr %15, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.A_handle.shape, metadata !48, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.A_handle.shape, metadata !48, metadata !DIExpression()), !dbg !18
  %16 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 5, !dbg !18
  %before_tensorize.A_handle.strides = load ptr, ptr %16, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.A_handle.strides, metadata !51, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.A_handle.strides, metadata !51, metadata !DIExpression()), !dbg !18
  %17 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 1, i32 1, !dbg !18
  %dev_id = load i32, ptr %17, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata i32 %dev_id, metadata !52, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata i32 %dev_id, metadata !52, metadata !DIExpression()), !dbg !18
  %18 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 0, !dbg !18
  %B = load ptr, ptr %18, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %B, metadata !53, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %B, metadata !53, metadata !DIExpression()), !dbg !18
  call void @llvm.assume(i1 true) [ "align"(ptr %B, i32 64) ], !dbg !18
  %19 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 4, !dbg !18
  %before_tensorize.B_handle.shape = load ptr, ptr %19, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.B_handle.shape, metadata !54, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.B_handle.shape, metadata !54, metadata !DIExpression()), !dbg !18
  %20 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 5, !dbg !18
  %before_tensorize.B_handle.strides = load ptr, ptr %20, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.B_handle.strides, metadata !55, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.B_handle.strides, metadata !55, metadata !DIExpression()), !dbg !18
  %21 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 0, !dbg !18
  %C = load ptr, ptr %21, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %C, metadata !56, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %C, metadata !56, metadata !DIExpression()), !dbg !18
  call void @llvm.assume(i1 true) [ "align"(ptr %C, i32 64) ], !dbg !18
  %22 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 4, !dbg !18
  %before_tensorize.C_handle.shape = load ptr, ptr %22, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.C_handle.shape, metadata !57, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.C_handle.shape, metadata !57, metadata !DIExpression()), !dbg !18
  %23 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 5, !dbg !18
  %before_tensorize.C_handle.strides = load ptr, ptr %23, align 4, !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.C_handle.strides, metadata !58, metadata !DIExpression()), !dbg !18
  tail call void @llvm.dbg.declare(metadata ptr %before_tensorize.C_handle.strides, metadata !58, metadata !DIExpression()), !dbg !18
  %24 = icmp eq i32 %A_handle.code, 4, !dbg !18
  %25 = icmp eq i32 %A_handle.code, 7, !dbg !18
  %26 = icmp eq i32 %A_handle.code, 13, !dbg !18
  %27 = icmp eq i32 %A_handle.code, 3, !dbg !18
  %28 = or i1 %27, %26, !dbg !18
  %29 = or i1 %28, %25, !dbg !18
  %30 = or i1 %29, %24, !dbg !18
  br i1 %30, label %assert_end2, label %assert_fail1, !dbg !18, !prof !19

assert_fail1:                                     ; preds = %assert_end
  %31 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %31(ptr @.str.1), !dbg !18
  ret i32 -1, !dbg !18

assert_end2:                                      ; preds = %assert_end
  %32 = icmp eq i32 %B_handle.code, 4, !dbg !18
  %33 = icmp eq i32 %B_handle.code, 7, !dbg !18
  %34 = icmp eq i32 %B_handle.code, 13, !dbg !18
  %35 = icmp eq i32 %B_handle.code, 3, !dbg !18
  %36 = or i1 %35, %34, !dbg !18
  %37 = or i1 %36, %33, !dbg !18
  %38 = or i1 %37, %32, !dbg !18
  br i1 %38, label %assert_end4, label %assert_fail3, !dbg !18, !prof !19

assert_fail3:                                     ; preds = %assert_end2
  %39 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %39(ptr @.str.2), !dbg !18
  ret i32 -1, !dbg !18

assert_end4:                                      ; preds = %assert_end2
  %40 = icmp eq i32 %C_handle.code, 4, !dbg !18
  %41 = icmp eq i32 %C_handle.code, 7, !dbg !18
  %42 = icmp eq i32 %C_handle.code, 13, !dbg !18
  %43 = icmp eq i32 %C_handle.code, 3, !dbg !18
  %44 = or i1 %43, %42, !dbg !18
  %45 = or i1 %44, %41, !dbg !18
  %46 = or i1 %45, %40, !dbg !18
  br i1 %46, label %assert_end6, label %assert_fail5, !dbg !18, !prof !19

assert_fail5:                                     ; preds = %assert_end4
  %47 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %47(ptr @.str.3), !dbg !18
  ret i32 -1, !dbg !18

assert_end6:                                      ; preds = %assert_end4
  %48 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 2, !dbg !18
  %49 = load i32, ptr %48, align 4, !dbg !18
  %50 = icmp eq i32 2, %49, !dbg !18
  br i1 %50, label %assert_end8, label %assert_fail7, !dbg !18, !prof !19

assert_fail7:                                     ; preds = %assert_end6
  %51 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %51(ptr @.str.4), !dbg !18
  ret i32 -1, !dbg !18

assert_end8:                                      ; preds = %assert_end6
  %52 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 2, !dbg !18
  %53 = load i32, ptr %52, align 4, !dbg !18
  %54 = icmp eq i32 2, %53, !dbg !18
  br i1 %54, label %assert_end10, label %assert_fail9, !dbg !18, !prof !19

assert_fail9:                                     ; preds = %assert_end8
  %55 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %55(ptr @.str.4), !dbg !18
  ret i32 -1, !dbg !18

assert_end10:                                     ; preds = %assert_end8
  %56 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 3, i32 2, !dbg !18
  %57 = load i16, ptr %56, align 2, !dbg !18
  %58 = icmp eq i16 %57, 1, !dbg !18
  %59 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 3, i32 1, !dbg !18
  %60 = load i8, ptr %59, align 1, !dbg !18
  %61 = icmp eq i8 %60, 32, !dbg !18
  %62 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 3, i32 0, !dbg !18
  %63 = load i8, ptr %62, align 1, !dbg !18
  %64 = icmp eq i8 %63, 2, !dbg !18
  %65 = and i1 %64, %61, !dbg !18
  %66 = and i1 %65, %58, !dbg !18
  br i1 %66, label %assert_end12, label %assert_fail11, !dbg !18, !prof !19

assert_fail11:                                    ; preds = %assert_end10
  %67 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %67(ptr @.str.5), !dbg !18
  ret i32 -1, !dbg !18

assert_end12:                                     ; preds = %assert_end10
  %68 = getelementptr inbounds i64, ptr %before_tensorize.A_handle.shape, i32 0, !dbg !18
  %69 = load i64, ptr %68, align 8, !dbg !18, !tbaa !59
  %70 = trunc i64 %69 to i32, !dbg !18
  %71 = icmp eq i32 %70, 16, !dbg !18
  br i1 %71, label %assert_end14, label %assert_fail13, !dbg !18, !prof !19

assert_fail13:                                    ; preds = %assert_end12
  %72 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %72(ptr @.str.6), !dbg !18
  ret i32 -1, !dbg !18

assert_end14:                                     ; preds = %assert_end12
  %73 = getelementptr inbounds i64, ptr %before_tensorize.A_handle.shape, i32 1, !dbg !18
  %74 = load i64, ptr %73, align 8, !dbg !18, !tbaa !59
  %75 = trunc i64 %74 to i32, !dbg !18
  %76 = icmp eq i32 %75, 16, !dbg !18
  br i1 %76, label %assert_end16, label %assert_fail15, !dbg !18, !prof !19

assert_fail15:                                    ; preds = %assert_end14
  %77 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %77(ptr @.str.7), !dbg !18
  ret i32 -1, !dbg !18

assert_end16:                                     ; preds = %assert_end14
  %78 = icmp eq ptr %before_tensorize.A_handle.strides, null, !dbg !18
  %79 = xor i1 %78, true, !dbg !18
  br i1 %79, label %if_then, label %if_end, !dbg !18, !prof !19

if_then:                                          ; preds = %assert_end16
  %80 = getelementptr inbounds i64, ptr %before_tensorize.A_handle.strides, i32 0, !dbg !18
  %81 = load i64, ptr %80, align 8, !dbg !18, !tbaa !59
  %82 = trunc i64 %81 to i32, !dbg !18
  %83 = icmp eq i32 16, %82, !dbg !18
  %84 = getelementptr inbounds i64, ptr %before_tensorize.A_handle.strides, i32 1, !dbg !18
  %85 = load i64, ptr %84, align 8, !dbg !18, !tbaa !59
  %86 = trunc i64 %85 to i32, !dbg !18
  %87 = icmp eq i32 1, %86, !dbg !18
  %88 = and i1 %87, %83, !dbg !18
  br i1 %88, label %assert_end18, label %assert_fail17, !dbg !18, !prof !19

if_end:                                           ; preds = %assert_end18, %assert_end16
  %89 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 6, !dbg !18
  %90 = load i64, ptr %89, align 8, !dbg !18
  %91 = icmp eq i64 0, %90, !dbg !18
  br i1 %91, label %assert_end20, label %assert_fail19, !dbg !18, !prof !19

assert_fail17:                                    ; preds = %if_then
  %92 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %92(ptr @.str.8), !dbg !18
  ret i32 -1, !dbg !18

assert_end18:                                     ; preds = %if_then
  br label %if_end, !dbg !18

assert_fail19:                                    ; preds = %if_end
  %93 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %93(ptr @.str.9), !dbg !18
  ret i32 -1, !dbg !18

assert_end20:                                     ; preds = %if_end
  %94 = getelementptr inbounds %1, ptr %A_handle, i32 0, i32 1, i32 0, !dbg !18
  %95 = load i32, ptr %94, align 4, !dbg !18
  %96 = icmp eq i32 %95, 1, !dbg !18
  br i1 %96, label %assert_end22, label %assert_fail21, !dbg !18, !prof !19

assert_fail21:                                    ; preds = %assert_end20
  %97 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %97(ptr @.str.10), !dbg !18
  ret i32 -1, !dbg !18

assert_end22:                                     ; preds = %assert_end20
  %98 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 2, !dbg !18
  %99 = load i32, ptr %98, align 4, !dbg !18
  %100 = icmp eq i32 2, %99, !dbg !18
  br i1 %100, label %assert_end24, label %assert_fail23, !dbg !18, !prof !19

assert_fail23:                                    ; preds = %assert_end22
  %101 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %101(ptr @.str.11), !dbg !18
  ret i32 -1, !dbg !18

assert_end24:                                     ; preds = %assert_end22
  %102 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 2, !dbg !18
  %103 = load i32, ptr %102, align 4, !dbg !18
  %104 = icmp eq i32 2, %103, !dbg !18
  br i1 %104, label %assert_end26, label %assert_fail25, !dbg !18, !prof !19

assert_fail25:                                    ; preds = %assert_end24
  %105 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %105(ptr @.str.11), !dbg !18
  ret i32 -1, !dbg !18

assert_end26:                                     ; preds = %assert_end24
  %106 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 3, i32 2, !dbg !18
  %107 = load i16, ptr %106, align 2, !dbg !18
  %108 = icmp eq i16 %107, 1, !dbg !18
  %109 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 3, i32 1, !dbg !18
  %110 = load i8, ptr %109, align 1, !dbg !18
  %111 = icmp eq i8 %110, 32, !dbg !18
  %112 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 3, i32 0, !dbg !18
  %113 = load i8, ptr %112, align 1, !dbg !18
  %114 = icmp eq i8 %113, 2, !dbg !18
  %115 = and i1 %114, %111, !dbg !18
  %116 = and i1 %115, %108, !dbg !18
  br i1 %116, label %assert_end28, label %assert_fail27, !dbg !18, !prof !19

assert_fail27:                                    ; preds = %assert_end26
  %117 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %117(ptr @.str.12), !dbg !18
  ret i32 -1, !dbg !18

assert_end28:                                     ; preds = %assert_end26
  %118 = getelementptr inbounds i64, ptr %before_tensorize.B_handle.shape, i32 0, !dbg !18
  %119 = load i64, ptr %118, align 8, !dbg !18, !tbaa !59
  %120 = trunc i64 %119 to i32, !dbg !18
  %121 = icmp eq i32 %120, 16, !dbg !18
  br i1 %121, label %assert_end30, label %assert_fail29, !dbg !18, !prof !19

assert_fail29:                                    ; preds = %assert_end28
  %122 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %122(ptr @.str.13), !dbg !18
  ret i32 -1, !dbg !18

assert_end30:                                     ; preds = %assert_end28
  %123 = getelementptr inbounds i64, ptr %before_tensorize.B_handle.shape, i32 1, !dbg !18
  %124 = load i64, ptr %123, align 8, !dbg !18, !tbaa !59
  %125 = trunc i64 %124 to i32, !dbg !18
  %126 = icmp eq i32 %125, 16, !dbg !18
  br i1 %126, label %assert_end32, label %assert_fail31, !dbg !18, !prof !19

assert_fail31:                                    ; preds = %assert_end30
  %127 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %127(ptr @.str.14), !dbg !18
  ret i32 -1, !dbg !18

assert_end32:                                     ; preds = %assert_end30
  %128 = icmp eq ptr %before_tensorize.B_handle.strides, null, !dbg !18
  %129 = xor i1 %128, true, !dbg !18
  br i1 %129, label %if_then33, label %if_end34, !dbg !18, !prof !19

if_then33:                                        ; preds = %assert_end32
  %130 = getelementptr inbounds i64, ptr %before_tensorize.B_handle.strides, i32 0, !dbg !18
  %131 = load i64, ptr %130, align 8, !dbg !18, !tbaa !59
  %132 = trunc i64 %131 to i32, !dbg !18
  %133 = icmp eq i32 16, %132, !dbg !18
  %134 = getelementptr inbounds i64, ptr %before_tensorize.B_handle.strides, i32 1, !dbg !18
  %135 = load i64, ptr %134, align 8, !dbg !18, !tbaa !59
  %136 = trunc i64 %135 to i32, !dbg !18
  %137 = icmp eq i32 1, %136, !dbg !18
  %138 = and i1 %137, %133, !dbg !18
  br i1 %138, label %assert_end36, label %assert_fail35, !dbg !18, !prof !19

if_end34:                                         ; preds = %assert_end36, %assert_end32
  %139 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 6, !dbg !18
  %140 = load i64, ptr %139, align 8, !dbg !18
  %141 = icmp eq i64 0, %140, !dbg !18
  br i1 %141, label %assert_end38, label %assert_fail37, !dbg !18, !prof !19

assert_fail35:                                    ; preds = %if_then33
  %142 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %142(ptr @.str.15), !dbg !18
  ret i32 -1, !dbg !18

assert_end36:                                     ; preds = %if_then33
  br label %if_end34, !dbg !18

assert_fail37:                                    ; preds = %if_end34
  %143 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %143(ptr @.str.16), !dbg !18
  ret i32 -1, !dbg !18

assert_end38:                                     ; preds = %if_end34
  %144 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 1, i32 0, !dbg !18
  %145 = load i32, ptr %144, align 4, !dbg !18
  %146 = icmp eq i32 %145, 1, !dbg !18
  br i1 %146, label %assert_end40, label %assert_fail39, !dbg !18, !prof !19

assert_fail39:                                    ; preds = %assert_end38
  %147 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %147(ptr @.str.17), !dbg !18
  ret i32 -1, !dbg !18

assert_end40:                                     ; preds = %assert_end38
  %148 = getelementptr inbounds %1, ptr %B_handle, i32 0, i32 1, i32 1, !dbg !18
  %149 = load i32, ptr %148, align 4, !dbg !18
  %150 = icmp eq i32 %dev_id, %149, !dbg !18
  br i1 %150, label %assert_end42, label %assert_fail41, !dbg !18, !prof !19

assert_fail41:                                    ; preds = %assert_end40
  %151 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %151(ptr @.str.18), !dbg !18
  ret i32 -1, !dbg !18

assert_end42:                                     ; preds = %assert_end40
  %152 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 2, !dbg !18
  %153 = load i32, ptr %152, align 4, !dbg !18
  %154 = icmp eq i32 2, %153, !dbg !18
  br i1 %154, label %assert_end44, label %assert_fail43, !dbg !18, !prof !19

assert_fail43:                                    ; preds = %assert_end42
  %155 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %155(ptr @.str.19), !dbg !18
  ret i32 -1, !dbg !18

assert_end44:                                     ; preds = %assert_end42
  %156 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 2, !dbg !18
  %157 = load i32, ptr %156, align 4, !dbg !18
  %158 = icmp eq i32 2, %157, !dbg !18
  br i1 %158, label %assert_end46, label %assert_fail45, !dbg !18, !prof !19

assert_fail45:                                    ; preds = %assert_end44
  %159 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %159(ptr @.str.19), !dbg !18
  ret i32 -1, !dbg !18

assert_end46:                                     ; preds = %assert_end44
  %160 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 3, i32 2, !dbg !18
  %161 = load i16, ptr %160, align 2, !dbg !18
  %162 = icmp eq i16 %161, 1, !dbg !18
  %163 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 3, i32 1, !dbg !18
  %164 = load i8, ptr %163, align 1, !dbg !18
  %165 = icmp eq i8 %164, 32, !dbg !18
  %166 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 3, i32 0, !dbg !18
  %167 = load i8, ptr %166, align 1, !dbg !18
  %168 = icmp eq i8 %167, 2, !dbg !18
  %169 = and i1 %168, %165, !dbg !18
  %170 = and i1 %169, %162, !dbg !18
  br i1 %170, label %assert_end48, label %assert_fail47, !dbg !18, !prof !19

assert_fail47:                                    ; preds = %assert_end46
  %171 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %171(ptr @.str.20), !dbg !18
  ret i32 -1, !dbg !18

assert_end48:                                     ; preds = %assert_end46
  %172 = getelementptr inbounds i64, ptr %before_tensorize.C_handle.shape, i32 0, !dbg !18
  %173 = load i64, ptr %172, align 8, !dbg !18, !tbaa !59
  %174 = trunc i64 %173 to i32, !dbg !18
  %175 = icmp eq i32 %174, 16, !dbg !18
  br i1 %175, label %assert_end50, label %assert_fail49, !dbg !18, !prof !19

assert_fail49:                                    ; preds = %assert_end48
  %176 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %176(ptr @.str.21), !dbg !18
  ret i32 -1, !dbg !18

assert_end50:                                     ; preds = %assert_end48
  %177 = getelementptr inbounds i64, ptr %before_tensorize.C_handle.shape, i32 1, !dbg !18
  %178 = load i64, ptr %177, align 8, !dbg !18, !tbaa !59
  %179 = trunc i64 %178 to i32, !dbg !18
  %180 = icmp eq i32 %179, 16, !dbg !18
  br i1 %180, label %assert_end52, label %assert_fail51, !dbg !18, !prof !19

assert_fail51:                                    ; preds = %assert_end50
  %181 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %181(ptr @.str.22), !dbg !18
  ret i32 -1, !dbg !18

assert_end52:                                     ; preds = %assert_end50
  %182 = icmp eq ptr %before_tensorize.C_handle.strides, null, !dbg !18
  %183 = xor i1 %182, true, !dbg !18
  br i1 %183, label %if_then53, label %if_end54, !dbg !18, !prof !19

if_then53:                                        ; preds = %assert_end52
  %184 = getelementptr inbounds i64, ptr %before_tensorize.C_handle.strides, i32 0, !dbg !18
  %185 = load i64, ptr %184, align 8, !dbg !18, !tbaa !59
  %186 = trunc i64 %185 to i32, !dbg !18
  %187 = icmp eq i32 16, %186, !dbg !18
  %188 = getelementptr inbounds i64, ptr %before_tensorize.C_handle.strides, i32 1, !dbg !18
  %189 = load i64, ptr %188, align 8, !dbg !18, !tbaa !59
  %190 = trunc i64 %189 to i32, !dbg !18
  %191 = icmp eq i32 1, %190, !dbg !18
  %192 = and i1 %191, %187, !dbg !18
  br i1 %192, label %assert_end56, label %assert_fail55, !dbg !18, !prof !19

if_end54:                                         ; preds = %assert_end56, %assert_end52
  %193 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 6, !dbg !18
  %194 = load i64, ptr %193, align 8, !dbg !18
  %195 = icmp eq i64 0, %194, !dbg !18
  br i1 %195, label %assert_end58, label %assert_fail57, !dbg !18, !prof !19

assert_fail55:                                    ; preds = %if_then53
  %196 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %196(ptr @.str.23), !dbg !18
  ret i32 -1, !dbg !18

assert_end56:                                     ; preds = %if_then53
  br label %if_end54, !dbg !18

assert_fail57:                                    ; preds = %if_end54
  %197 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %197(ptr @.str.24), !dbg !18
  ret i32 -1, !dbg !18

assert_end58:                                     ; preds = %if_end54
  %198 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 1, i32 0, !dbg !18
  %199 = load i32, ptr %198, align 4, !dbg !18
  %200 = icmp eq i32 %199, 1, !dbg !18
  br i1 %200, label %assert_end60, label %assert_fail59, !dbg !18, !prof !19

assert_fail59:                                    ; preds = %assert_end58
  %201 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %201(ptr @.str.25), !dbg !18
  ret i32 -1, !dbg !18

assert_end60:                                     ; preds = %assert_end58
  %202 = getelementptr inbounds %1, ptr %C_handle, i32 0, i32 1, i32 1, !dbg !18
  %203 = load i32, ptr %202, align 4, !dbg !18
  %204 = icmp eq i32 %dev_id, %203, !dbg !18
  br i1 %204, label %assert_end62, label %assert_fail61, !dbg !18, !prof !19

assert_fail61:                                    ; preds = %assert_end60
  %205 = load ptr, ptr @__TVMAPISetLastError, align 4, !dbg !18, !tbaa !20
  call void %205(ptr @.str.26), !dbg !18
  ret i32 -1, !dbg !18

assert_end62:                                     ; preds = %assert_end60
  %206 = call i32 @before_tensorize_compute_(ptr %C), !dbg !18
  %207 = icmp eq i32 %206, 0, !dbg !18
  br i1 %207, label %call_end, label %call_fail, !dbg !18, !prof !19

call_fail:                                        ; preds = %assert_end62
  ret i32 %206, !dbg !18

call_end:                                         ; preds = %assert_end62
  ret i32 0, !dbg !18

ret_dummy:                                        ; No predecessors!
  ret i32 0, !dbg !18
}

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write)
declare void @llvm.assume(i1 noundef) #2

define internal i32 @before_tensorize_compute_(ptr align 64 %C) #0 !dbg !61 {
entry:
  %0 = alloca ptr, align 4, !dbg !66
  tail call void @llvm.dbg.declare(metadata ptr %0, metadata !65, metadata !DIExpression()), !dbg !66
  store ptr %C, ptr %0, align 4, !dbg !66
  br label %for_begin_i_0, !dbg !66

for_begin_i_0:                                    ; preds = %for_end_j_0, %entry
  %i_0 = phi i32 [ 0, %entry ], [ %3, %for_end_j_0 ], !dbg !66
  tail call void @llvm.dbg.declare(metadata i32 %i_0, metadata !67, metadata !DIExpression()), !dbg !66
  %1 = icmp slt i32 %i_0, 4, !dbg !66
  br i1 %1, label %for_body_i_0, label %for_end_i_0, !dbg !66, !prof !19

for_body_i_0:                                     ; preds = %for_begin_i_0
  br label %for_begin_j_0, !dbg !66

for_end_i_0:                                      ; preds = %for_begin_i_0
  ret i32 0, !dbg !66

for_begin_j_0:                                    ; preds = %for_end_k_0, %for_body_i_0
  %j_0 = phi i32 [ 0, %for_body_i_0 ], [ %11, %for_end_k_0 ], !dbg !66
  tail call void @llvm.dbg.declare(metadata i32 %j_0, metadata !68, metadata !DIExpression()), !dbg !66
  %2 = icmp slt i32 %j_0, 4, !dbg !66
  br i1 %2, label %for_body_j_0, label %for_end_j_0, !dbg !66, !prof !19

for_body_j_0:                                     ; preds = %for_begin_j_0
  br label %for_begin_k_0, !dbg !66

for_end_j_0:                                      ; preds = %for_begin_j_0
  %3 = add nsw i32 %i_0, 1, !dbg !66
  br label %for_begin_i_0, !dbg !66

for_begin_k_0:                                    ; preds = %for_body_k_0, %for_body_j_0
  %k_0 = phi i32 [ 0, %for_body_j_0 ], [ %10, %for_body_k_0 ], !dbg !66
  tail call void @llvm.dbg.declare(metadata i32 %k_0, metadata !69, metadata !DIExpression()), !dbg !66
  %4 = icmp slt i32 %k_0, 4, !dbg !66
  br i1 %4, label %for_body_k_0, label %for_end_k_0, !dbg !66, !prof !19

for_body_k_0:                                     ; preds = %for_begin_k_0
  %5 = mul nsw i32 %j_0, 4, !dbg !66
  %6 = mul nsw i32 %i_0, 64, !dbg !66
  %cse_var_1 = add nsw i32 %6, %5, !dbg !66
  tail call void @llvm.dbg.declare(metadata i32 %cse_var_1, metadata !70, metadata !DIExpression()), !dbg !66
  tail call void @llvm.dbg.declare(metadata i32 %cse_var_1, metadata !70, metadata !DIExpression()), !dbg !66
  %7 = getelementptr inbounds float, ptr %C, i32 %cse_var_1, !dbg !66
  %8 = getelementptr inbounds float, ptr %C, i32 %cse_var_1, !dbg !66
  call void @llvm.x86.tileloadd64(i8 0, ptr %7, i64 64)
  call void @llvm.x86.tileloadd64(i8 1, ptr %8, i64 64)
  call void @llvm.x86.tdpbsud(i8 1, i8 1, i8 0)
  %9 = getelementptr inbounds float, ptr %C, i32 %cse_var_1, !dbg !66
  call void @llvm.x86.tilestoredd64(i8 1, ptr %9, i64 64)
  %10 = add nsw i32 %k_0, 1, !dbg !66
  br label %for_begin_k_0, !dbg !66

for_end_k_0:                                      ; preds = %for_begin_k_0
  %11 = add nsw i32 %j_0, 1, !dbg !66
  br label %for_begin_j_0, !dbg !66
}

define internal void @__tvm_module_startup() #0 {
entry:
  ret void, !dbg !18
}

; Function Attrs: nounwind memory(none)
define weak dso_local i16 @__truncsfhf2(float %a0) local_unnamed_addr #3 section ".text.tvm.fp16.conv" {
b0:
  %v0 = bitcast float %a0 to i32
  %v1 = and i32 %v0, 2147483647
  %v2 = add nsw i32 %v1, -947912704
  %v3 = add nsw i32 %v1, -1199570944
  %v4 = icmp ult i32 %v2, %v3
  br i1 %v4, label %b1, label %b5

b1:                                               ; preds = %b0
  %v5 = lshr i32 %v0, 13
  %v6 = and i32 %v5, 65535
  %v7 = add nuw nsw i32 %v6, -114688
  %v8 = and i32 %v0, 8191
  %v9 = icmp ugt i32 %v8, 4096
  br i1 %v9, label %b2, label %b3

b2:                                               ; preds = %b1
  %v10 = add nuw nsw i32 %v6, -114687
  br label %b13

b3:                                               ; preds = %b1
  %v11 = icmp eq i32 %v8, 4096
  br i1 %v11, label %b4, label %b13

b4:                                               ; preds = %b3
  %v12 = and i32 %v7, 65535
  %v13 = and i32 %v5, 1
  %v14 = add nuw nsw i32 %v12, %v13
  br label %b13

b5:                                               ; preds = %b0
  %v15 = icmp ugt i32 %v1, 2139095040
  br i1 %v15, label %b6, label %b7

b6:                                               ; preds = %b5
  %v16 = lshr i32 %v0, 13
  %v17 = and i32 %v16, 511
  %v18 = or i32 %v17, 32256
  br label %b13

b7:                                               ; preds = %b5
  %v19 = icmp ugt i32 %v1, 1199570943
  br i1 %v19, label %b13, label %b8

b8:                                               ; preds = %b7
  %v20 = icmp ult i32 %v1, 754974720
  br i1 %v20, label %b13, label %b9

b9:                                               ; preds = %b8
  %v21 = lshr i32 %v1, 23
  %v22 = sub nsw i32 113, %v21
  %v23 = and i32 %v0, 8388607
  %v24 = or i32 %v23, 8388608
  %v25 = add nsw i32 %v21, -81
  %v26 = shl i32 %v24, %v25
  %v27 = icmp ne i32 %v26, 0
  %v28 = lshr i32 %v24, %v22
  %v29 = zext i1 %v27 to i32
  %v30 = lshr i32 %v28, 13
  %v31 = and i32 %v28, 8191
  %v32 = or i32 %v31, %v29
  %v33 = icmp ugt i32 %v32, 4096
  br i1 %v33, label %b10, label %b11

b10:                                              ; preds = %b9
  %v34 = add nuw nsw i32 %v30, 1
  br label %b13

b11:                                              ; preds = %b9
  %v35 = icmp eq i32 %v32, 4096
  br i1 %v35, label %b12, label %b13

b12:                                              ; preds = %b11
  %v36 = and i32 %v30, 1
  %v37 = add nuw nsw i32 %v36, %v30
  br label %b13

b13:                                              ; preds = %b12, %b11, %b10, %b8, %b7, %b6, %b4, %b3, %b2
  %v38 = phi i32 [ %v18, %b6 ], [ %v10, %b2 ], [ %v14, %b4 ], [ %v7, %b3 ], [ 31744, %b7 ], [ 0, %b8 ], [ %v34, %b10 ], [ %v37, %b12 ], [ %v30, %b11 ]
  %v39 = lshr i32 %v0, 16
  %v40 = and i32 %v39, 32768
  %v41 = or i32 %v38, %v40
  %vlast = trunc i32 %v41 to i16
  %vres = add i16 %vlast, 0
  ret i16 %vres
}

; Function Attrs: nounwind memory(none)
define weak dso_local float @__extendhfsf2(i16 %a0) local_unnamed_addr #3 section ".text.tvm.fp16.conv" {
b0:
  %vinp = add i16 %a0, 0
  %v1 = and i16 %vinp, 32767
  %v2 = zext i16 %v1 to i32
  %v3 = add nsw i16 %v1, -1024
  %v4 = icmp ult i16 %v3, 30720
  br i1 %v4, label %b1, label %b2

b1:                                               ; preds = %b0
  %v5 = shl nuw nsw i32 %v2, 13
  %v6 = add nuw nsw i32 %v5, 939524096
  br label %b6

b2:                                               ; preds = %b0
  %v7 = icmp ugt i16 %v1, 31743
  br i1 %v7, label %b3, label %b4

b3:                                               ; preds = %b2
  %v8 = shl nuw nsw i32 %v2, 13
  %v9 = or i32 %v8, 2139095040
  br label %b6

b4:                                               ; preds = %b2
  %v10 = icmp eq i16 %v1, 0
  br i1 %v10, label %b6, label %b5

b5:                                               ; preds = %b4
  %v11 = icmp ult i16 %v1, 256
  %v12 = lshr i32 %v2, 8
  %v13 = select i1 %v11, i32 %v2, i32 %v12
  %v14 = select i1 %v11, i32 32, i32 24
  %v15 = icmp ult i32 %v13, 16
  %v16 = lshr i32 %v13, 4
  %v17 = add nsw i32 %v14, -4
  %v18 = select i1 %v15, i32 %v13, i32 %v16
  %v19 = select i1 %v15, i32 %v14, i32 %v17
  %v20 = icmp ult i32 %v18, 4
  %v21 = lshr i32 %v18, 2
  %v22 = add nsw i32 %v19, -2
  %v23 = select i1 %v20, i32 %v18, i32 %v21
  %v24 = select i1 %v20, i32 %v19, i32 %v22
  %v25 = icmp ult i32 %v23, 2
  %v26 = sub nsw i32 0, %v23
  %v27 = select i1 %v25, i32 %v26, i32 -2
  %v28 = add nsw i32 %v27, %v24
  %v29 = add nsw i32 %v28, -8
  %v30 = shl i32 %v2, %v29
  %v31 = xor i32 %v30, 8388608
  %v32 = shl i32 %v28, 23
  %v33 = sub i32 1124073472, %v32
  %v34 = or i32 %v31, %v33
  br label %b6

b6:                                               ; preds = %b5, %b4, %b3, %b1
  %v35 = phi i32 [ %v6, %b1 ], [ %v9, %b3 ], [ %v34, %b5 ], [ 0, %b4 ]
  %v36 = and i16 %vinp, -32768
  %v37 = zext i16 %v36 to i32
  %v38 = shl nuw i32 %v37, 16
  %v39 = or i32 %v35, %v38
  %v40 = bitcast i32 %v39 to float
  ret float %v40
}

; Function Attrs: nounwind
declare void @llvm.x86.tdpbsud(i8 immarg, i8 immarg, i8 immarg) #4

; Function Attrs: nounwind
declare void @llvm.x86.tileloadd64(i8 immarg, ptr, i64) #4

declare void @llvm.x86.tilestoredd64(i8, ptr, i64) #5

attributes #0 = { "target-cpu"="generic" "target-features"="+amx-tile" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: write) }
attributes #3 = { nounwind memory(none) "target-cpu"="generic" "target-features"="+amx-tile" }
attributes #4 = { nounwind }
attributes #5 = { "target-features"="+amx-tile" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!2, !3, !4}

!0 = distinct !DICompileUnit(language: DW_LANG_C, file: !1, producer: "TVM", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug)
!1 = !DIFile(filename: "IRModule.CodeGenLLVM", directory: ".")
!2 = !{i32 2, !"tvm_target", !"llvm -mtriple=riscv32-unknown-elf"}
!3 = !{i32 4, !"Debug Info Version", i32 3}
!4 = !{i32 4, !"Dwarf Version", i32 4}
!5 = distinct !DISubprogram(name: "before_tensorize", scope: !1, file: !1, type: !6, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !11)
!6 = !DISubroutineType(types: !7)
!7 = !{!8, !9, !10, !8, !9, !10, !9}
!8 = !DIBasicType(name: "int32", size: 32, encoding: DW_ATE_signed)
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null)
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !8)
!11 = !{!12, !13, !14, !15, !16, !17}
!12 = !DILocalVariable(name: "args", arg: 1, scope: !5, file: !1, type: !9)
!13 = !DILocalVariable(name: "arg_type_ids", arg: 2, scope: !5, file: !1, type: !10)
!14 = !DILocalVariable(name: "num_args", arg: 3, scope: !5, file: !1, type: !8)
!15 = !DILocalVariable(name: "out_ret_value", arg: 4, scope: !5, file: !1, type: !9)
!16 = !DILocalVariable(name: "out_ret_tcode", arg: 5, scope: !5, file: !1, type: !10)
!17 = !DILocalVariable(name: "resource_handle", arg: 6, scope: !5, file: !1, type: !9)
!18 = !DILocation(line: 0, scope: !5)
!19 = !{!"branch_weights", i32 1048576, i32 1}
!20 = !{!21, !21, i64 0}
!21 = !{!"ctx_ptr", !22, i64 0}
!22 = !{!"tvm-tbaa"}
!23 = !{!24, !24, i64 0}
!24 = !{!"0x55c4a102a1e0.w4.b0", !25, i64 0}
!25 = !{!"0x55c4a102a1e0.w8.b0", !26, i64 0}
!26 = !{!"0x55c4a102a1e0.w16.b0", !27, i64 0}
!27 = !{!"0x55c4a102a1e0.w32.b0", !28, i64 0}
!28 = !{!"0x55c4a102a1e0.w64.b0", !29, i64 0}
!29 = !{!"0x55c4a102a1e0.w128.b0", !30, i64 0}
!30 = !{!"0x55c4a102a1e0.w256.b0", !31, i64 0}
!31 = !{!"0x55c4a102a1e0.w512.b0", !32, i64 0}
!32 = !{!"0x55c4a102a1e0.w1024.b0", !33, i64 0}
!33 = !{!"0x55c4a102a1e0", !22, i64 0}
!34 = !DILocalVariable(name: "A_handle.code", scope: !5, file: !1, type: !8)
!35 = !{!36, !36, i64 0}
!36 = !{!"0x55c4a102a1e0.w4.b4", !25, i64 0}
!37 = !DILocalVariable(name: "B_handle.code", scope: !5, file: !1, type: !8)
!38 = !{!39, !39, i64 0}
!39 = !{!"0x55c4a102a1e0.w4.b8", !40, i64 0}
!40 = !{!"0x55c4a102a1e0.w8.b8", !26, i64 0}
!41 = !DILocalVariable(name: "C_handle.code", scope: !5, file: !1, type: !8)
!42 = !DILocalVariable(name: "A_handle", scope: !5, file: !1, type: !9)
!43 = !DILocalVariable(name: "B_handle", scope: !5, file: !1, type: !9)
!44 = !DILocalVariable(name: "C_handle", scope: !5, file: !1, type: !9)
!45 = !DILocalVariable(name: "A", scope: !5, file: !1, type: !46)
!46 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !47)
!47 = !DIBasicType(name: "float32", size: 32, encoding: DW_ATE_float)
!48 = !DILocalVariable(name: "before_tensorize.A_handle.shape", scope: !5, file: !1, type: !49)
!49 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !50)
!50 = !DIBasicType(name: "int64", size: 64, encoding: DW_ATE_signed)
!51 = !DILocalVariable(name: "before_tensorize.A_handle.strides", scope: !5, file: !1, type: !49)
!52 = !DILocalVariable(name: "dev_id", scope: !5, file: !1, type: !8)
!53 = !DILocalVariable(name: "B", scope: !5, file: !1, type: !46)
!54 = !DILocalVariable(name: "before_tensorize.B_handle.shape", scope: !5, file: !1, type: !49)
!55 = !DILocalVariable(name: "before_tensorize.B_handle.strides", scope: !5, file: !1, type: !49)
!56 = !DILocalVariable(name: "C", scope: !5, file: !1, type: !46)
!57 = !DILocalVariable(name: "before_tensorize.C_handle.shape", scope: !5, file: !1, type: !49)
!58 = !DILocalVariable(name: "before_tensorize.C_handle.strides", scope: !5, file: !1, type: !49)
!59 = !{!60, !60, i64 0}
!60 = !{!"tvm-alias", !22}
!61 = distinct !DISubprogram(name: "before_tensorize_compute_", scope: !1, file: !1, type: !62, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition | DISPFlagOptimized, unit: !0, retainedNodes: !64)
!62 = !DISubroutineType(types: !63)
!63 = !{!8, !46}
!64 = !{!65}
!65 = !DILocalVariable(name: "C", arg: 1, scope: !61, file: !1, type: !46)
!66 = !DILocation(line: 0, scope: !61)
!67 = !DILocalVariable(name: "i_0", scope: !61, file: !1, type: !8)
!68 = !DILocalVariable(name: "j_0", scope: !61, file: !1, type: !8)
!69 = !DILocalVariable(name: "k_0", scope: !61, file: !1, type: !8)
!70 = !DILocalVariable(name: "cse_var_1", scope: !61, file: !1, type: !8)
