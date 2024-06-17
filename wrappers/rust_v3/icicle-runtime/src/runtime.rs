use std::ffi::CString;
use std::os::raw::{c_char, c_void};

use crate::device::Device;
use crate::errors::eIcicleError;

pub type IcicleStreamHandle = *mut c_void;

extern "C" {
    fn icicle_load_backend(path: *const c_char, is_recursive: bool) -> eIcicleError;
    fn icicle_set_device(device: &Device) -> eIcicleError;
    fn icicle_is_device_avialable(device: &Device) -> eIcicleError;
    pub fn icicle_malloc(ptr: *mut *mut c_void, size: usize) -> eIcicleError;
    // fn icicle_malloc_async(ptr: *mut *mut c_void, size: usize, stream: IcicleStreamHandle) -> eIcicleError;
    pub fn icicle_free(ptr: *mut c_void) -> eIcicleError;
    // fn icicle_free_async(ptr: *mut c_void, stream: IcicleStreamHandle) -> eIcicleError;
    // fn icicle_get_available_memory(total: *mut usize, free: *mut usize) -> eIcicleError;
    pub fn icicle_copy_to_host(dst: *mut c_void, src: *const c_void, size: usize) -> eIcicleError;
    // fn icicle_copy_to_host_async(dst: *mut u8, src: *const u8, size: usize, stream: IcicleStreamHandle)
    //     -> eIcicleError;
    pub fn icicle_copy_to_device(dst: *mut c_void, src: *const c_void, size: usize) -> eIcicleError;
    // fn icicle_copy_to_device_async(
    //     dst: *mut u8,
    //     src: *const u8,
    //     size: usize,
    //     stream: IcicleStreamHandle,
    // ) -> eIcicleError;
    pub fn icicle_create_stream(stream: *mut IcicleStreamHandle) -> eIcicleError;
    pub fn icicle_destroy_stream(stream: IcicleStreamHandle) -> eIcicleError;
    pub fn icicle_stream_synchronize(stream: IcicleStreamHandle) -> eIcicleError;
    fn icicle_device_synchronize() -> eIcicleError;
    // fn icicle_get_device_properties(properties: *mut DeviceProperties) -> eIcicleError;
}

pub fn load_backend(path: &str, is_recursive: bool) -> eIcicleError {
    let c_path = CString::new(path).unwrap();
    unsafe { icicle_load_backend(c_path.as_ptr(), is_recursive) }
}

pub fn set_device(device: &Device) -> eIcicleError {
    unsafe { icicle_set_device(device) }
}

pub fn is_device_available(device: &Device) -> eIcicleError {
    unsafe { icicle_is_device_avialable(device) }
}

// pub fn malloc_async(size: usize, stream: IcicleStreamHandle) -> Result<*mut c_void, eIcicleError> {
//     let mut ptr: *mut c_void = std::ptr::null_mut();
//     let result = unsafe { icicle_malloc_async(&mut ptr, size, stream) };
//     if result == eIcicleError::Success {
//         Ok(ptr)
//     } else {
//         Err(result)
//     }
// }

// pub fn free(ptr: *mut c_void) -> eIcicleError {
//     unsafe { icicle_free(ptr) }
// }

// pub fn free_async(ptr: *mut c_void, stream: IcicleStreamHandle) -> eIcicleError {
//     unsafe { icicle_free_async(ptr, stream) }
// }

// pub fn get_available_memory() -> Result<(usize, usize), eIcicleError> {
//     let mut total: usize = 0;
//     let mut free: usize = 0;
//     let result = unsafe { icicle_get_available_memory(&mut total, &mut free) };
//     if result == eIcicleError::Success {
//         Ok((total, free))
//     } else {
//         Err(result)
//     }
// }

// pub fn copy_to_host_async(dst: *mut u8, src: *const u8, size: usize, stream: IcicleStreamHandle) -> eIcicleError {
//     unsafe { icicle_copy_to_host_async(dst, src, size, stream) }
// }

// pub fn copy_to_device_async(dst: *mut u8, src: *const u8, size: usize, stream: IcicleStreamHandle) -> eIcicleError {
//     unsafe { icicle_copy_to_device_async(dst, src, size, stream) }
// }

// pub fn create_stream() -> Result<IcicleStreamHandle, eIcicleError> {
//     let mut stream: IcicleStreamHandle = std::ptr::null_mut();
//     let result = unsafe { icicle_create_stream(&mut stream) };
//     if result == eIcicleError::Success {
//         Ok(stream)
//     } else {
//         Err(result)
//     }
// }

// pub fn destroy_stream(stream: IcicleStreamHandle) -> eIcicleError {
//     unsafe { icicle_destroy_stream(stream) }
// }

// pub fn stream_synchronize(stream: IcicleStreamHandle) -> eIcicleError {
//     unsafe { icicle_stream_synchronize(stream) }
// }

pub fn device_synchronize() -> eIcicleError {
    unsafe { icicle_device_synchronize() }
}

// pub fn get_device_properties() -> Result<DeviceProperties, eIcicleError> {
//     let mut properties = DeviceProperties {
//         using_host_memory: false,
//         num_memory_regions: 0,
//         supports_pinned_memory: false,
//     };
//     let result = unsafe { icicle_get_device_properties(&mut properties) };
//     if result == eIcicleError::Success {
//         Ok(properties)
//     } else {
//         Err(result)
//     }
// }