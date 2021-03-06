; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -verify-machineinstrs -mtriple=powerpc64-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl
; RUN: llc -verify-machineinstrs -mtriple=powerpc64le-unknown-linux-gnu -O2 \
; RUN:   -ppc-gpr-icmps=all -ppc-asm-full-reg-names -mcpu=pwr8 < %s | FileCheck %s \
; RUN:  --implicit-check-not cmpw --implicit-check-not cmpd --implicit-check-not cmpl

define signext i32 @test(i8 zeroext %a, i8 zeroext %b) {
; CHECK-LABEL: test:
; CHECK:       # %bb.0: # %entry
; CHECK-NEXT:    rlwinm r3, r3, 0, 31, 31
; CHECK-NEXT:    rlwinm r4, r4, 0, 31, 31
; CHECK-NEXT:    clrldi r3, r3, 32
; CHECK-NEXT:    clrldi r4, r4, 32
; CHECK-NEXT:    sub r3, r4, r3
; CHECK-NEXT:    rldicl r3, r3, 1, 63
; CHECK-NEXT:    xori r3, r3, 1
; CHECK-NEXT:    blr
entry:
  %0 = and i8 %a, 1
  %1 = and i8 %b, 1
  %cmp = icmp ule i8 %0, %1
  %conv3 = zext i1 %cmp to i32
  ret i32 %conv3
}
