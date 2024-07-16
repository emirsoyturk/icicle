#include <cuda.h>
#include <stdexcept>

#include "icicle/errors.h"
#include "icicle/vec_ops.h"
#include "gpu-utils/error_handler.h"
#include "error_translation.h"

#include "icicle/fields/field_config.h"
using namespace field_config;

#define MAX_THREADS_PER_BLOCK 256

template <typename E>
E* allocate_on_device(size_t byte_size, cudaStream_t cuda_stream)
{
  E* device_mem = nullptr;
  cudaMallocAsync(&device_mem, byte_size, cuda_stream);
  CHK_LAST();

  return device_mem;
}

template <typename E>
const E* allocate_and_copy_to_device(const E* host_mem, size_t byte_size, cudaStream_t cuda_stream)
{
  E* device_mem = nullptr;
  cudaMallocAsync(&device_mem, byte_size, cuda_stream);
  cudaMemcpyAsync(device_mem, host_mem, byte_size, cudaMemcpyHostToDevice, cuda_stream);
  CHK_LAST();

  return device_mem;
}

template <typename E, void (*Kernel)(const E*, const E*, int, E*)>
cudaError_t vec_op(const E* vec_a, const E* vec_b, int n, const VecOpsConfig& config, E* result)
{
  CHK_INIT_IF_RETURN();

  cudaStream_t cuda_stream = reinterpret_cast<cudaStream_t>(config.stream);

  // allocate device memory and copy if input/output not on device already
  const E* d_vec_a = config.is_a_on_device ? vec_a : allocate_and_copy_to_device(vec_a, n * sizeof(E), cuda_stream);
  const E* d_vec_b = config.is_b_on_device ? vec_b : allocate_and_copy_to_device(vec_b, n * sizeof(E), cuda_stream);
  E* d_result = config.is_result_on_device ? result : allocate_on_device<E>(n * sizeof(E), cuda_stream);

  // Call the kernel to perform element-wise operation
  int num_threads = MAX_THREADS_PER_BLOCK;
  int num_blocks = (n + num_threads - 1) / num_threads;
  Kernel<<<num_blocks, num_threads, 0, cuda_stream>>>(d_vec_a, d_vec_b, n, d_result);

  // copy back result to host if need to
  if (!config.is_result_on_device) {
    CHK_IF_RETURN(cudaMemcpyAsync(result, d_result, n * sizeof(E), cudaMemcpyDeviceToHost, cuda_stream));
    CHK_IF_RETURN(cudaFreeAsync(d_result, cuda_stream));
  }

  // release device memory, if allocated
  // the cast is ugly but it makes the code more compact
  if (!config.is_a_on_device) { CHK_IF_RETURN(cudaFreeAsync((void*)d_vec_a, cuda_stream)); }
  if (!config.is_b_on_device) { CHK_IF_RETURN(cudaFreeAsync((void*)d_vec_b, cuda_stream)); }

  // wait for stream to empty is not async
  if (!config.is_async) return CHK_STICKY(cudaStreamSynchronize(cuda_stream));

  return CHK_LAST();
}

/*============================== add ==============================*/
template <typename E>
__global__ void add_kernel(const E* element_vec1, const E* element_vec2, int n, E* result)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  if (tid < n) { result[tid] = element_vec1[tid] + element_vec2[tid]; }
}

template <typename E>
eIcicleError
add_cuda(const Device& device, const E* vec_a, const E* vec_b, int n, const VecOpsConfig& config, E* result)
{
  cudaError_t err = vec_op<E, add_kernel>(vec_a, vec_b, n, config, result);
  return translateCudaError(err);
}

/*============================== sub ==============================*/
template <typename E>
__global__ void sub_kernel(const E* element_vec1, const E* element_vec2, int n, E* result)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  if (tid < n) { result[tid] = element_vec1[tid] - element_vec2[tid]; }
}

template <typename E>
eIcicleError
sub_cuda(const Device& device, const E* vec_a, const E* vec_b, int n, const VecOpsConfig& config, E* result)
{
  cudaError_t err = vec_op<E, sub_kernel>(vec_a, vec_b, n, config, result);
  return translateCudaError(err);
}

/*============================== mul ==============================*/
template <typename E>
__global__ void mul_kernel(const E* scalar_vec, const E* element_vec, int n, E* result)
{
  int tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid < n) { result[tid] = scalar_vec[tid] * element_vec[tid]; }
}

template <typename E>
eIcicleError
mul_cuda(const Device& device, const E* vec_a, const E* vec_b, int n, const VecOpsConfig& config, E* result)
{
  cudaError_t err = vec_op<E, mul_kernel>(vec_a, vec_b, n, config, result);
  return translateCudaError(err);
}

template <typename E, typename S>
__global__ void mul_scalar_kernel(const E* element_vec, const S scalar, int n, E* result)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  if (tid < n) { result[tid] = element_vec[tid] * (scalar); }
}

/*============================== div ==============================*/
template <typename E>
__global__ void div_element_wise_kernel(const E* element_vec1, const E* element_vec2, int n, E* result)
{
  // TODO:implement better based on https://eprint.iacr.org/2008/199
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  if (tid < n) { result[tid] = element_vec1[tid] * E::inverse(element_vec2[tid]); }
}
/*============================== transpose ==============================*/

template <typename E>
__global__ void transpose_kernel(const E* in, E* out, uint32_t row_size, uint32_t column_size)
{
  int tid = blockDim.x * blockIdx.x + threadIdx.x;
  if (tid >= row_size * column_size) return;
  out[(tid % row_size) * column_size + (tid / row_size)] = in[tid];
}

template <typename E>
cudaError_t transpose_matrix(
  const E* mat_in,
  E* mat_out,
  uint32_t row_size,
  uint32_t column_size,
  cudaStream_t stream,
  bool on_device,
  bool is_async)
{
  int number_of_threads = MAX_THREADS_PER_BLOCK;
  int number_of_blocks = (row_size * column_size + number_of_threads - 1) / number_of_threads;

  const E* d_mat_in;
  E* d_allocated_input = nullptr;
  E* d_mat_out;
  if (!on_device) {
    CHK_IF_RETURN(cudaMallocAsync(&d_allocated_input, row_size * column_size * sizeof(E), stream));
    CHK_IF_RETURN(
      cudaMemcpyAsync(d_allocated_input, mat_in, row_size * column_size * sizeof(E), cudaMemcpyHostToDevice, stream));

    CHK_IF_RETURN(cudaMallocAsync(&d_mat_out, row_size * column_size * sizeof(E), stream));
    d_mat_in = d_allocated_input;
  } else {
    d_mat_in = mat_in;
    d_mat_out = mat_out;
  }

  transpose_kernel<<<number_of_blocks, number_of_threads, 0, stream>>>(d_mat_in, d_mat_out, row_size, column_size);

  if (!on_device) {
    CHK_IF_RETURN(
      cudaMemcpyAsync(mat_out, d_mat_out, row_size * column_size * sizeof(E), cudaMemcpyDeviceToHost, stream));
    CHK_IF_RETURN(cudaFreeAsync(d_mat_out, stream));
    CHK_IF_RETURN(cudaFreeAsync(d_allocated_input, stream));
  }
  if (!is_async) return CHK_STICKY(cudaStreamSynchronize(stream));

  return CHK_LAST();
}

template <typename F>
eIcicleError matrix_transpose_cuda(
  const Device& device, const F* in, uint32_t nof_rows, uint32_t nof_cols, const VecOpsConfig& config, F* out)
{
  // TODO relax this limitation
  ICICLE_ASSERT(config.is_a_on_device == config.is_result_on_device)
    << "CUDA matrix transpose expects both input and output on host or on device";

  // assert that it is not an inplace computation
  const bool is_on_device = config.is_a_on_device;
  const bool is_inplace = in == out;
  ICICLE_ASSERT(!is_on_device || !is_inplace) << "(CUDA) matrix-transpose-inplace not implemented";
  cudaStream_t cuda_stream = reinterpret_cast<cudaStream_t>(config.stream);
  auto err = transpose_matrix(in, out, nof_cols, nof_rows, cuda_stream, config.is_a_on_device, config.is_async);
  return translateCudaError(err);
}

/*============================== Bit-reverse ==============================*/

template <typename E>
__global__ void bit_reverse_kernel(const E* input, uint64_t n, unsigned shift, E* output)
{
  uint64_t tid = uint64_t(blockIdx.x) * blockDim.x + threadIdx.x;
  // Handling arbitrary vector size
  if (tid < n) {
    int reversed_index = __brevll(tid) >> shift;
    output[reversed_index] = input[tid];
  }
}
template <typename E>
__global__ void bit_reverse_inplace_kernel(E* input, uint64_t n, unsigned shift)
{
  uint64_t tid = uint64_t(blockIdx.x) * blockDim.x + threadIdx.x;
  // Handling arbitrary vector size
  if (tid < n) {
    int reversed_index = __brevll(tid) >> shift;
    if (reversed_index > tid) {
      E temp = input[tid];
      input[tid] = input[reversed_index];
      input[reversed_index] = temp;
    }
  }
}

template <typename E>
cudaError_t bit_reverse_cuda_impl(const E* input, uint64_t size, const VecOpsConfig& cfg, E* output)
{
  cudaStream_t cuda_stream = reinterpret_cast<cudaStream_t>(cfg.stream);

  if (size & (size - 1)) THROW_ICICLE_ERR(eIcicleError::INVALID_ARGUMENT, "bit_reverse: size must be a power of 2");
  if ((input == output) & (cfg.is_a_on_device != cfg.is_result_on_device))
    THROW_ICICLE_ERR(
      eIcicleError::INVALID_ARGUMENT, "bit_reverse: equal devices should have same is_on_device parameters");

  E* d_output;
  if (cfg.is_result_on_device) {
    d_output = output;
  } else {
    // allocate output on gpu
    CHK_IF_RETURN(cudaMallocAsync(&d_output, sizeof(E) * size, cuda_stream));
  }

  uint64_t shift = __builtin_clzll(size) + 1;
  uint64_t num_blocks = (size + MAX_THREADS_PER_BLOCK - 1) / MAX_THREADS_PER_BLOCK;

  if ((input != output) & cfg.is_a_on_device) {
    bit_reverse_kernel<<<num_blocks, MAX_THREADS_PER_BLOCK, 0, cuda_stream>>>(input, size, shift, d_output);
  } else {
    if (!cfg.is_a_on_device) {
      CHK_IF_RETURN(cudaMemcpyAsync(d_output, input, sizeof(E) * size, cudaMemcpyHostToDevice, cuda_stream));
    }
    bit_reverse_inplace_kernel<<<num_blocks, MAX_THREADS_PER_BLOCK, 0, cuda_stream>>>(d_output, size, shift);
  }
  if (!cfg.is_result_on_device) {
    CHK_IF_RETURN(cudaMemcpyAsync(output, d_output, sizeof(E) * size, cudaMemcpyDeviceToHost, cuda_stream));
    CHK_IF_RETURN(cudaFreeAsync(d_output, cuda_stream));
  }
  if (!cfg.is_async) CHK_IF_RETURN(cudaStreamSynchronize(cuda_stream));
  return CHK_LAST();
}

template <typename T>
eIcicleError bit_reverse_cuda(const Device& device, const T* in, uint64_t size, const VecOpsConfig& config, T* out)
{
  auto err = bit_reverse_cuda_impl<T>(in, size, config, out);
  return translateCudaError(err);
}

/*============================== slice ==============================*/
template <typename T>
__global__ void slice_kernel(const T* in, T* out, int offset, int stride, int size)
{
  int tid = blockIdx.x * blockDim.x + threadIdx.x;
  if (tid < size) { out[tid] = in[offset + tid * stride]; }
}

template <typename E>
cudaError_t slice(const E* vec_a, int offset, int stride, int size, const VecOpsConfig& config, E* result)
{
  CHK_INIT_IF_RETURN();

  cudaStream_t cuda_stream = reinterpret_cast<cudaStream_t>(config.stream);

  // allocate device memory and copy if input/output not on device already
  // need to copy consecutive memory where output elements reside in vec_a
  const int input_elements_required = stride * size;
  const E* d_vec_a = config.is_a_on_device
                       ? vec_a
                       : allocate_and_copy_to_device(vec_a + offset, input_elements_required * sizeof(E), cuda_stream);
  offset = config.is_a_on_device ? offset : 0; // already copied from offset so reset to zero
  E* d_result = config.is_result_on_device ? result : allocate_on_device<E>(size * sizeof(E), cuda_stream);

  // Call the kernel to perform element-wise operation
  int num_threads = MAX_THREADS_PER_BLOCK;
  int num_blocks = (input_elements_required + num_threads - 1) / num_threads;
  slice_kernel<<<num_blocks, num_threads, 0, cuda_stream>>>(d_vec_a, d_result, offset, stride, size);

  // copy back result to host if need to
  if (!config.is_result_on_device) {
    CHK_IF_RETURN(cudaMemcpyAsync(result, d_result, size * sizeof(E), cudaMemcpyDeviceToHost, cuda_stream));
    CHK_IF_RETURN(cudaFreeAsync(d_result, cuda_stream));
  }

  // release device memory, if allocated
  // the cast is ugly but it makes the code more compact
  if (!config.is_a_on_device) { CHK_IF_RETURN(cudaFreeAsync((void*)d_vec_a, cuda_stream)); }

  // wait for stream to empty is not async
  if (!config.is_async) return CHK_STICKY(cudaStreamSynchronize(cuda_stream));

  return CHK_LAST();
}

template <typename E>
eIcicleError slice_cuda(
  const Device& device, const E* vec_a, int offset, int stride, int size, const VecOpsConfig& config, E* result)
{
  cudaError_t err = slice<E>(vec_a, offset, stride, size, config, result);
  return translateCudaError(err);
}

/************************************ REGISTRATION ************************************/

REGISTER_VECTOR_ADD_BACKEND("CUDA", add_cuda<scalar_t>);
REGISTER_VECTOR_SUB_BACKEND("CUDA", sub_cuda<scalar_t>);
REGISTER_VECTOR_MUL_BACKEND("CUDA", mul_cuda<scalar_t>);
REGISTER_MATRIX_TRANSPOSE_BACKEND("CUDA", matrix_transpose_cuda<scalar_t>);
REGISTER_BIT_REVERSE_BACKEND("CUDA", bit_reverse_cuda<scalar_t>);
REGISTER_SLICE_BACKEND("CUDA", slice_cuda<scalar_t>);

#ifdef EXT_FIELD
REGISTER_VECTOR_ADD_EXT_FIELD_BACKEND("CUDA", add_cuda<extension_t>);
REGISTER_VECTOR_SUB_EXT_FIELD_BACKEND("CUDA", sub_cuda<extension_t>);
REGISTER_VECTOR_MUL_EXT_FIELD_BACKEND("CUDA", mul_cuda<extension_t>);
REGISTER_MATRIX_TRANSPOSE_EXT_FIELD_BACKEND("CUDA", matrix_transpose_cuda<extension_t>);
REGISTER_BIT_REVERSE_EXT_FIELD_BACKEND("CUDA", bit_reverse_cuda<extension_t>);
REGISTER_SLICE_EXT_FIELD_BACKEND("CUDA", slice_cuda<extension_t>);
#endif // EXT_FIELD
