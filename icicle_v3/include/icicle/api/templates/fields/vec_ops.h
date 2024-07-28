extern "C" eIcicleError ${FIELD}_vector_mul(
  const ${FIELD}::scalar_t* vec_a, const ${FIELD}::scalar_t* vec_b, uint64_t n, const VecOpsConfig& config, ${FIELD}::scalar_t* result);

extern "C" eIcicleError ${FIELD}vector_add(
  const ${FIELD}::scalar_t* vec_a, const ${FIELD}::scalar_t* vec_b, uint64_t n, const VecOpsConfig& config, ${FIELD}::scalar_t* result);

// extern "C" eIcicleError ${FIELD}_accumulate_cuda(
//   const ${FIELD}::scalar_t* vec_a, const ${FIELD}::scalar_t* vec_b, uint64_t n, const VecOpsConfig& config);

extern "C" eIcicleError ${FIELD}_vector_sub(
  const ${FIELD}::scalar_t* vec_a, const ${FIELD}::scalar_t* vec_b, uint64_t n, const VecOpsConfig& config, ${FIELD}::scalar_t* result);

extern "C" eIcicleError ${FIELD}_transpose_matrix(
  const ${FIELD}::scalar_t* input,
  uint32_t nof_rows,
  uint32_t nof_cols,
  const VecOpsConfig& config,
  ${FIELD}::scalar_t* output);

extern "C" eIcicleError ${FIELD}_bit_reverse(
  const ${FIELD}::scalar_t* input, uint64_t n, const VecOpsConfig& config, ${FIELD}::scalar_t* output);