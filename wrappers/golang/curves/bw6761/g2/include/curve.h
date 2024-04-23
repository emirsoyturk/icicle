#include <cuda_runtime.h>
#include <stdbool.h>

#ifndef _BW6_761_G2CURVE_H
#define _BW6_761_G2CURVE_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct g2_projective_t g2_projective_t;
typedef struct g2_affine_t g2_affine_t;
typedef struct DeviceContext DeviceContext;

bool bw6_761_g2_eq(g2_projective_t* point1, g2_projective_t* point2);
void bw6_761_g2_to_affine(g2_projective_t* point, g2_affine_t* point_out);
void bw6_761_g2_generate_projective_points(g2_projective_t* points, int size);
void bw6_761_g2_generate_affine_points(g2_affine_t* points, int size);
cudaError_t bw6_761_g2_affine_convert_montgomery(g2_affine_t* points, size_t n, bool is_into, DeviceContext* ctx);
cudaError_t bw6_761_g2_projective_convert_montgomery(g2_projective_t* points, size_t n, bool is_into, DeviceContext* ctx);

#ifdef __cplusplus
}
#endif

#endif
