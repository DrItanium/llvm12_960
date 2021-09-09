; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=amdgcn-mesa-mesa3d -mcpu=gfx908 < %s | FileCheck --check-prefix=GCN %s

; Test using saddr addressing mode of global_* flat atomic instructions.

; --------------------------------------------------------------------------------
; amdgcn global atomic fadd
; --------------------------------------------------------------------------------

define amdgpu_ps void @global_fadd_saddr_f32_nortn(i8 addrspace(1)* inreg %sbase, i32 %voffset, float %data) {
; GCN-LABEL: global_fadd_saddr_f32_nortn:
; GCN:       ; %bb.0:
; GCN-NEXT:    global_atomic_add_f32 v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %zext.offset = zext i32 %voffset to i64
  %gep0 = getelementptr inbounds i8, i8 addrspace(1)* %sbase, i64 %zext.offset
  %cast.gep0 = bitcast i8 addrspace(1)* %gep0 to float addrspace(1)*
  %ret = call float @llvm.amdgcn.global.atomic.fadd.f32.p1f32(float addrspace(1)* %cast.gep0, float %data)
  ret void
}

define amdgpu_ps void @global_fadd_saddr_f32_nortn_neg128(i8 addrspace(1)* inreg %sbase, i32 %voffset, float %data) {
; GCN-LABEL: global_fadd_saddr_f32_nortn_neg128:
; GCN:       ; %bb.0:
; GCN-NEXT:    global_atomic_add_f32 v0, v1, s[2:3] offset:-128
; GCN-NEXT:    s_endpgm
  %zext.offset = zext i32 %voffset to i64
  %gep0 = getelementptr inbounds i8, i8 addrspace(1)* %sbase, i64 %zext.offset
  %gep1 = getelementptr inbounds i8, i8 addrspace(1)* %gep0, i64 -128
  %cast.gep1 = bitcast i8 addrspace(1)* %gep1 to float addrspace(1)*
  %ret = call float @llvm.amdgcn.global.atomic.fadd.f32.p1f32(float addrspace(1)* %cast.gep1, float %data)
  ret void
}

define amdgpu_ps void @global_fadd_saddr_v2f16_nortn(i8 addrspace(1)* inreg %sbase, i32 %voffset, <2 x half> %data) {
; GCN-LABEL: global_fadd_saddr_v2f16_nortn:
; GCN:       ; %bb.0:
; GCN-NEXT:    global_atomic_pk_add_f16 v0, v1, s[2:3]
; GCN-NEXT:    s_endpgm
  %zext.offset = zext i32 %voffset to i64
  %gep0 = getelementptr inbounds i8, i8 addrspace(1)* %sbase, i64 %zext.offset
  %cast.gep0 = bitcast i8 addrspace(1)* %gep0 to <2 x half> addrspace(1)*
  %ret = call <2 x half> @llvm.amdgcn.global.atomic.fadd.v2f16.p1v2f16(<2 x half> addrspace(1)* %cast.gep0, <2 x half> %data)
  ret void
}

define amdgpu_ps void @global_fadd_saddr_v2f16_nortn_neg128(i8 addrspace(1)* inreg %sbase, i32 %voffset, <2 x half> %data) {
; GCN-LABEL: global_fadd_saddr_v2f16_nortn_neg128:
; GCN:       ; %bb.0:
; GCN-NEXT:    global_atomic_pk_add_f16 v0, v1, s[2:3] offset:-128
; GCN-NEXT:    s_endpgm
  %zext.offset = zext i32 %voffset to i64
  %gep0 = getelementptr inbounds i8, i8 addrspace(1)* %sbase, i64 %zext.offset
  %gep1 = getelementptr inbounds i8, i8 addrspace(1)* %gep0, i64 -128
  %cast.gep1 = bitcast i8 addrspace(1)* %gep1 to <2 x half> addrspace(1)*
  %ret = call <2 x half> @llvm.amdgcn.global.atomic.fadd.v2f16.p1v2f16(<2 x half> addrspace(1)* %cast.gep1, <2 x half> %data)
  ret void
}

declare float @llvm.amdgcn.global.atomic.fadd.f32.p1f32(float addrspace(1)* nocapture, float) #0
declare <2 x half> @llvm.amdgcn.global.atomic.fadd.v2f16.p1v2f16(<2 x half> addrspace(1)* nocapture, <2 x half>) #0

attributes #0 = { argmemonly nounwind willreturn }
