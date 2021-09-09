; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple riscv32-unknown-elf -o - %s \
; RUN: 2>&1 | FileCheck %s -check-prefix CHECK-RV32
; RUN: llc -mtriple riscv32-unknown-elf -mattr=+f -o - %s \
; RUN: 2>&1 | FileCheck %s -check-prefix CHECK-RV32-F
; RUN: llc -mtriple riscv32-unknown-elf -mattr=+f,+d -o - %s \
; RUN: 2>&1 | FileCheck %s -check-prefix CHECK-RV32-FD
;
; The test case check that the function call in an interrupt handler will use
; the correct CallPreservedMask as normal function. So only callee saved
; registers could live through the function call.

define dso_local void @handler() nounwind {
; CHECK-RV32-LABEL: handler:
; CHECK-RV32:       # %bb.0: # %entry
; CHECK-RV32-NEXT:    addi sp, sp, -16
; CHECK-RV32-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; CHECK-RV32-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; CHECK-RV32-NEXT:    lui a0, 2
; CHECK-RV32-NEXT:    addi a0, a0, 4
; CHECK-RV32-NEXT:    call read@plt
; CHECK-RV32-NEXT:    mv s0, a0
; CHECK-RV32-NEXT:    call callee@plt
; CHECK-RV32-NEXT:    mv a0, s0
; CHECK-RV32-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; CHECK-RV32-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; CHECK-RV32-NEXT:    addi sp, sp, 16
; CHECK-RV32-NEXT:    tail write@plt
;
; CHECK-RV32-F-LABEL: handler:
; CHECK-RV32-F:       # %bb.0: # %entry
; CHECK-RV32-F-NEXT:    addi sp, sp, -16
; CHECK-RV32-F-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; CHECK-RV32-F-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; CHECK-RV32-F-NEXT:    lui a0, 2
; CHECK-RV32-F-NEXT:    addi a0, a0, 4
; CHECK-RV32-F-NEXT:    call read@plt
; CHECK-RV32-F-NEXT:    mv s0, a0
; CHECK-RV32-F-NEXT:    call callee@plt
; CHECK-RV32-F-NEXT:    mv a0, s0
; CHECK-RV32-F-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; CHECK-RV32-F-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; CHECK-RV32-F-NEXT:    addi sp, sp, 16
; CHECK-RV32-F-NEXT:    tail write@plt
;
; CHECK-RV32-FD-LABEL: handler:
; CHECK-RV32-FD:       # %bb.0: # %entry
; CHECK-RV32-FD-NEXT:    addi sp, sp, -16
; CHECK-RV32-FD-NEXT:    sw ra, 12(sp) # 4-byte Folded Spill
; CHECK-RV32-FD-NEXT:    sw s0, 8(sp) # 4-byte Folded Spill
; CHECK-RV32-FD-NEXT:    lui a0, 2
; CHECK-RV32-FD-NEXT:    addi a0, a0, 4
; CHECK-RV32-FD-NEXT:    call read@plt
; CHECK-RV32-FD-NEXT:    mv s0, a0
; CHECK-RV32-FD-NEXT:    call callee@plt
; CHECK-RV32-FD-NEXT:    mv a0, s0
; CHECK-RV32-FD-NEXT:    lw s0, 8(sp) # 4-byte Folded Reload
; CHECK-RV32-FD-NEXT:    lw ra, 12(sp) # 4-byte Folded Reload
; CHECK-RV32-FD-NEXT:    addi sp, sp, 16
; CHECK-RV32-FD-NEXT:    tail write@plt
entry:
  %call = tail call i32 @read(i32 8196)
  tail call void bitcast (void (...)* @callee to void ()*)()
  tail call void @write(i32 %call)
  ret void
}

declare i32 @read(i32)
declare void @callee(...)
declare void @write(i32)
