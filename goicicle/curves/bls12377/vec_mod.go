// Copyright 2023 Ingonyama
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Code generated by Ingonyama DO NOT EDIT

package bls12377

// #cgo CFLAGS: -I./include/
// #cgo LDFLAGS: -L${SRCDIR}/../../ -lbls12_377
// #include "ve_mod_mult.h"
import "C"
import (
	"fmt"
	"unsafe"
)

func VecScalarMulMod(scalarVec1, scalarVec2 unsafe.Pointer, size int) int {
	scalarVec1C := (*C.BLS12_377_scalar_t)(scalarVec1)
	scalarVec2C := (*C.BLS12_377_scalar_t)(scalarVec2)
	sizeC := C.size_t(size)

	ret := C.vec_mod_mult_device_scalar_bls12_377(scalarVec1C, scalarVec2C, sizeC, 0)

	if ret != 0 {
		fmt.Print("error multiplying scalar vectors")
		return -1
	}

	return 0
}
