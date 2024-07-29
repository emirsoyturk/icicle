extern "C" bool ${CURVE}_eq(${CURVE}::projective_t* point1, ${CURVE}::projective_t* point2);

extern "C" void ${CURVE}_to_affine(${CURVE}::projective_t* point, ${CURVE}::affine_t* point_out);

extern "C" void ${CURVE}_generate_projective_points(${CURVE}::projective_t* points, int size);

extern "C" void ${CURVE}_generate_affine_points(${CURVE}::affine_t* points, int size);

extern "C" eIcicleError ${CURVE}_affine_convert_montgomery(
  const ${CURVE}::affine_t* input, size_t n, bool is_into, const VecOpsConfig& config, ${CURVE}::affine_t* output);

extern "C" eIcicleError ${CURVE}_projective_convert_montgomery(
  const ${CURVE}::projective_t* input, size_t n, bool is_into, const VecOpsConfig& config, ${CURVE}::projective_t* output);  