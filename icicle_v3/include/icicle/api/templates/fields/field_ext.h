extern "C" void ${FIELD}_extension_generate_scalars(${FIELD}::extension_t* scalars, int size);

extern "C" eIcicleError ${FIELD}_extension_scalar_convert_montgomery(  
  const ${FIELD}::extension_t* input, uint64_t size, bool is_into, const VecOpsConfig& config, ${FIELD}::extension_t* output);