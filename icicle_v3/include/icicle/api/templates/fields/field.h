extern "C" void ${FIELD}_generate_scalars(${FIELD}::scalar_t* scalars, int size);

extern "C" void ${FIELD}_scalar_convert_montgomery(
  const ${FIELD}::scalar_t* input, uint64_t size, bool is_into, const VecOpsConfig& config, ${FIELD}::scalar_t* output);