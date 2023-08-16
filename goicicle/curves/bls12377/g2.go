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

import (
	"encoding/binary"
	"unsafe"
)

// #cgo CFLAGS: -I./include/
// #cgo LDFLAGS: -L${SRCDIR}/../../ -lbls12_377
// #include "projective.h"
// #include "ve_mod_mult.h"
import "C"

// G2 extension field

type G2Element [6]uint64

type ExtentionField struct {
	A0, A1 G2Element
}

type G2PointAffine struct {
	X, Y ExtentionField
}

type G2Point struct {
	X, Y, Z ExtentionField
}

func (p *G2Point) Random() *G2Point {
	rand := C.random_projective_bls12_377()

	*p = *(*G2Point)(unsafe.Pointer(rand))

	return p
}

func (p *G2Point) Eq(pCompare *G2Point) bool {
	// Cast *PointBLS12_377 to *C.BLS12_377_projective_t
	// The unsafe.Pointer cast is necessary because Go doesn't allow direct casts
	// between different pointer types.
	// It's your responsibility to ensure that the types are compatible.
	pC := (*C.BLS12_377_g2_projective_t)(unsafe.Pointer(p))
	pCompareC := (*C.BLS12_377_g2_projective_t)(unsafe.Pointer(pCompare))

	// Call the C function
	// The C function doesn't keep any references to the data,
	// so it's fine if the Go garbage collector moves or deletes the data later.
	return bool(C.eq_g2_bls12_377(pC, pCompareC))
}

func (f *G2Element) ToBytesLe() []byte {
	var bytes []byte
	for _, val := range f {
		buf := make([]byte, 8) // 8 bytes because uint64 is 64-bit
		binary.LittleEndian.PutUint64(buf, val)
		bytes = append(bytes, buf...)
	}
	return bytes
}

func (p *G2PointAffine) ToProjective() G2Point {
	return G2Point{
		X: p.X,
		Y: p.Y,
		Z: ExtentionField{
			A0: G2Element{1, 0, 0, 0},
			A1: G2Element{0, 0, 0, 0},
		},
	}
}

func (p *G2PointAffine) FromProjective(projective *G2Point) *G2PointAffine {
	in := (*C.BLS12_377_g2_projective_t)(unsafe.Pointer(projective))

	out := C.g2_projective_to_affine_bls12_377(in)

	// Directly copy memory from the C struct to the Go struct
	*p = *(*G2PointAffine)(unsafe.Pointer(out))

	return p
}

func (p *G2Point) IsOnCurve() bool {
	// Directly copy memory from the C struct to the Go struct
	point := (*C.BLS12_377_g2_projective_t)(unsafe.Pointer(p))
	res := C.g2_projective_is_on_curve_bls12_377(point)

	return bool(res)
}
