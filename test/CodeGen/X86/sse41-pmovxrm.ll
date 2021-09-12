; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=+sse4.1 | FileCheck %s --check-prefix=SSE41
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=+avx2 | FileCheck %s --check-prefix=AVX
; RUN: llc < %s -disable-peephole -mtriple=x86_64-apple-darwin -mattr=+avx512vl,avx512bw | FileCheck %s --check-prefix=AVX

define <8 x i16> @test_llvm_x86_sse41_pmovsxbw(<16 x i8>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovsxbw:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovsxbw (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovsxbw:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxbw (%rdi), %xmm0
; AVX-NEXT:    retq
  %1 = load <16 x i8>, <16 x i8>* %a, align 1
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %3 = sext <8 x i8> %2 to <8 x i16>
  ret <8 x i16> %3
}

define <4 x i32> @test_llvm_x86_sse41_pmovsxbd(<16 x i8>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovsxbd:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovsxbd (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovsxbd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxbd (%rdi), %xmm0
; AVX-NEXT:    retq
  %1 = load <16 x i8>, <16 x i8>* %a, align 1
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = sext <4 x i8> %2 to <4 x i32>
  ret <4 x i32> %3
}

define <2 x i64> @test_llvm_x86_sse41_pmovsxbq(<16 x i8>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovsxbq:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovsxbq (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovsxbq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxbq (%rdi), %xmm0
; AVX-NEXT:    retq
  %1 = load <16 x i8>, <16 x i8>* %a, align 1
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <2 x i32> <i32 0, i32 1>
  %3 = sext <2 x i8> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <4 x i32> @test_llvm_x86_sse41_pmovsxwd(<8 x i16>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovsxwd:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovsxwd (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovsxwd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxwd (%rdi), %xmm0
; AVX-NEXT:    retq
  %1 = load <8 x i16>, <8 x i16>* %a, align 1
  %2 = shufflevector <8 x i16> %1, <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = sext <4 x i16> %2 to <4 x i32>
  ret <4 x i32> %3
}

define <2 x i64> @test_llvm_x86_sse41_pmovsxwq(<8 x i16>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovsxwq:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovsxwq (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovsxwq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxwq (%rdi), %xmm0
; AVX-NEXT:    retq
  %1 = load <8 x i16>, <8 x i16>* %a, align 1
  %2 = shufflevector <8 x i16> %1, <8 x i16> undef, <2 x i32> <i32 0, i32 1>
  %3 = sext <2 x i16> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <2 x i64> @test_llvm_x86_sse41_pmovsxdq(<4 x i32>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovsxdq:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovsxdq (%rdi), %xmm0
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovsxdq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovsxdq (%rdi), %xmm0
; AVX-NEXT:    retq
  %1 = load <4 x i32>, <4 x i32>* %a, align 1
  %2 = shufflevector <4 x i32> %1, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  %3 = sext <2 x i32> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <8 x i16> @test_llvm_x86_sse41_pmovzxbw(<16 x i8>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovzxbw:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovzxbw {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovzxbw:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxbw {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero,mem[4],zero,mem[5],zero,mem[6],zero,mem[7],zero
; AVX-NEXT:    retq
  %1 = load <16 x i8>, <16 x i8>* %a, align 1
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <8 x i32> <i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 7>
  %3 = zext <8 x i8> %2 to <8 x i16>
  ret <8 x i16> %3
}

define <4 x i32> @test_llvm_x86_sse41_pmovzxbd(<16 x i8>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovzxbd:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovzxbd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxbd {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero,mem[2],zero,zero,zero,mem[3],zero,zero,zero
; AVX-NEXT:    retq
  %1 = load <16 x i8>, <16 x i8>* %a, align 1
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = zext <4 x i8> %2 to <4 x i32>
  ret <4 x i32> %3
}

define <2 x i64> @test_llvm_x86_sse41_pmovzxbq(<16 x i8>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovzxbq:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovzxbq {{.*#+}} xmm0 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovzxbq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxbq {{.*#+}} xmm0 = mem[0],zero,zero,zero,zero,zero,zero,zero,mem[1],zero,zero,zero,zero,zero,zero,zero
; AVX-NEXT:    retq
  %1 = load <16 x i8>, <16 x i8>* %a, align 1
  %2 = shufflevector <16 x i8> %1, <16 x i8> undef, <2 x i32> <i32 0, i32 1>
  %3 = zext <2 x i8> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <4 x i32> @test_llvm_x86_sse41_pmovzxwd(<8 x i16>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovzxwd:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovzxwd {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovzxwd:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxwd {{.*#+}} xmm0 = mem[0],zero,mem[1],zero,mem[2],zero,mem[3],zero
; AVX-NEXT:    retq
  %1 = load <8 x i16>, <8 x i16>* %a, align 1
  %2 = shufflevector <8 x i16> %1, <8 x i16> undef, <4 x i32> <i32 0, i32 1, i32 2, i32 3>
  %3 = zext <4 x i16> %2 to <4 x i32>
  ret <4 x i32> %3
}

define <2 x i64> @test_llvm_x86_sse41_pmovzxwq(<8 x i16>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovzxwq:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovzxwq {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovzxwq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxwq {{.*#+}} xmm0 = mem[0],zero,zero,zero,mem[1],zero,zero,zero
; AVX-NEXT:    retq
  %1 = load <8 x i16>, <8 x i16>* %a, align 1
  %2 = shufflevector <8 x i16> %1, <8 x i16> undef, <2 x i32> <i32 0, i32 1>
  %3 = zext <2 x i16> %2 to <2 x i64>
  ret <2 x i64> %3
}

define <2 x i64> @test_llvm_x86_sse41_pmovzxdq(<4 x i32>* %a) {
; SSE41-LABEL: test_llvm_x86_sse41_pmovzxdq:
; SSE41:       ## %bb.0:
; SSE41-NEXT:    pmovzxdq {{.*#+}} xmm0 = mem[0],zero,mem[1],zero
; SSE41-NEXT:    retq
;
; AVX-LABEL: test_llvm_x86_sse41_pmovzxdq:
; AVX:       ## %bb.0:
; AVX-NEXT:    vpmovzxdq {{.*#+}} xmm0 = mem[0],zero,mem[1],zero
; AVX-NEXT:    retq
  %1 = load <4 x i32>, <4 x i32>* %a, align 1
  %2 = shufflevector <4 x i32> %1, <4 x i32> undef, <2 x i32> <i32 0, i32 1>
  %3 = zext <2 x i32> %2 to <2 x i64>
  ret <2 x i64> %3
}