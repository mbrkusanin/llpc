; NOTE: Assertions have been autogenerated by utils/update_test_checks.py UTC_ARGS: --version 3
; RUN: opt --verify-each -passes='pre-coroutine-lowering,lint' -S %s 2>%t.stderr | FileCheck %s
; RUN: count 0 < %t.stderr

declare void @Use(i64)
declare i64 @_AmdGetCurrentFuncAddr()

define void @MyRayGen() {
; CHECK-LABEL: define void @MyRayGen() {
; CHECK-NEXT:  AllocaSpillBB:
; CHECK-NEXT:    call void @Use(i64 ptrtoint (ptr @MyRayGen to i64))
; CHECK-NEXT:    ret void
;
AllocaSpillBB:
  %val = call i64 @_AmdGetCurrentFuncAddr()
  call void @Use(i64 %val)
  ret void
}

define void @MyRayGen.resume.0() {
; CHECK-LABEL: define void @MyRayGen.resume.0() {
; CHECK-NEXT:  entryresume.0:
; CHECK-NEXT:    call void @Use(i64 ptrtoint (ptr @MyRayGen.resume.0 to i64))
; CHECK-NEXT:    ret void
;
entryresume.0:
  %val = call i64 @_AmdGetCurrentFuncAddr()
  call void @Use(i64 %val)
  ret void
}

