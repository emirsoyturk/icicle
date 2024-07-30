// WARNING: This file is auto-generated by a script.
// Any changes made to this file may be overwritten.
// Please modify the code generation script instead.
// Path to the code generation script: scripts/gen_c_api.py

#pragma once

#include "icicle/curves/params/bls12_381.h"
#include "icicle/ntt.h"
#include "icicle/msm.h"
#include "icicle/vec_ops.h"

extern "C" eIcicleError bls12_381_g2_precompute_msm_bases(
  const bls12_381::g2_affine_t* bases, int nof_bases, const MSMConfig& config, bls12_381::g2_affine_t* output_bases);

extern "C" eIcicleError bls12_381_g2_msm(
  const bls12_381::scalar_t* scalars,
  const bls12_381::g2_affine_t* points,
  int msm_size,
  const MSMConfig& config,
  bls12_381::g2_projective_t* out);

extern "C" eIcicleError bls12_381_precompute_msm_bases(
  const bls12_381::affine_t* bases, int nof_bases, const MSMConfig& config, bls12_381::affine_t* output_bases);

extern "C" eIcicleError bls12_381_msm(
  const bls12_381::scalar_t* scalars,
  const bls12_381::affine_t* points,
  int msm_size,
  const MSMConfig& config,
  bls12_381::projective_t* out);

extern "C" bool bls12_381_g2_eq(bls12_381::g2_projective_t* point1, bls12_381::g2_projective_t* point2);

extern "C" void bls12_381_g2_to_affine(bls12_381::g2_projective_t* point, bls12_381::g2_affine_t* point_out);

extern "C" void bls12_381_g2_generate_projective_points(bls12_381::g2_projective_t* points, int size);

extern "C" void bls12_381_g2_generate_affine_points(bls12_381::g2_affine_t* points, int size);

extern "C" eIcicleError bls12_381_g2_affine_convert_montgomery(
  const bls12_381::g2_affine_t* input,
  size_t n,
  bool is_into,
  const VecOpsConfig& config,
  bls12_381::g2_affine_t* output);

extern "C" eIcicleError bls12_381_g2_projective_convert_montgomery(
  const bls12_381::g2_projective_t* input,
  size_t n,
  bool is_into,
  const VecOpsConfig& config,
  bls12_381::g2_projective_t* output);

extern "C" eIcicleError bls12_381_ecntt(
  const bls12_381::projective_t* input,
  int size,
  NTTDir dir,
  NTTConfig<bls12_381::scalar_t>& config,
  bls12_381::projective_t* output);

extern "C" bool bls12_381_eq(bls12_381::projective_t* point1, bls12_381::projective_t* point2);

extern "C" void bls12_381_to_affine(bls12_381::projective_t* point, bls12_381::affine_t* point_out);

extern "C" void bls12_381_generate_projective_points(bls12_381::projective_t* points, int size);

extern "C" void bls12_381_generate_affine_points(bls12_381::affine_t* points, int size);

extern "C" eIcicleError bls12_381_affine_convert_montgomery(
  const bls12_381::affine_t* input, size_t n, bool is_into, const VecOpsConfig& config, bls12_381::affine_t* output);

extern "C" eIcicleError bls12_381_projective_convert_montgomery(
  const bls12_381::projective_t* input,
  size_t n,
  bool is_into,
  const VecOpsConfig& config,
  bls12_381::projective_t* output);

extern "C" eIcicleError bls12_381_vector_mul(
  const bls12_381::scalar_t* vec_a,
  const bls12_381::scalar_t* vec_b,
  uint64_t n,
  const VecOpsConfig& config,
  bls12_381::scalar_t* result);

extern "C" eIcicleError bls12_381vector_add(
  const bls12_381::scalar_t* vec_a,
  const bls12_381::scalar_t* vec_b,
  uint64_t n,
  const VecOpsConfig& config,
  bls12_381::scalar_t* result);

// extern "C" eIcicleError bls12_381_accumulate_cuda(
//   const bls12_381::scalar_t* vec_a, const bls12_381::scalar_t* vec_b, uint64_t n, const VecOpsConfig& config);

extern "C" eIcicleError bls12_381_vector_sub(
  const bls12_381::scalar_t* vec_a,
  const bls12_381::scalar_t* vec_b,
  uint64_t n,
  const VecOpsConfig& config,
  bls12_381::scalar_t* result);

extern "C" eIcicleError bls12_381_transpose_matrix(
  const bls12_381::scalar_t* input,
  uint32_t nof_rows,
  uint32_t nof_cols,
  const VecOpsConfig& config,
  bls12_381::scalar_t* output);

extern "C" eIcicleError bls12_381_bit_reverse(
  const bls12_381::scalar_t* input, uint64_t n, const VecOpsConfig& config, bls12_381::scalar_t* output);

extern "C" void bls12_381_generate_scalars(bls12_381::scalar_t* scalars, int size);

extern "C" void bls12_381_scalar_convert_montgomery(
  const bls12_381::scalar_t* input,
  uint64_t size,
  bool is_into,
  const VecOpsConfig& config,
  bls12_381::scalar_t* output);

extern "C" eIcicleError
bls12_381_ntt_init_domain(bls12_381::scalar_t* primitive_root, const NTTInitDomainConfig& config);

extern "C" eIcicleError bls12_381_ntt(
  const bls12_381::scalar_t* input,
  int size,
  NTTDir dir,
  NTTConfig<bls12_381::scalar_t>& config,
  bls12_381::scalar_t* output);

extern "C" eIcicleError bls12_381_ntt_release_domain();
