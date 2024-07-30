#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to display usage information
show_help() {
  echo "Usage: $0 [-d DEVICE_TYPE] [-b BACKEND_INSTALL_DIR]"
  echo
  echo "Options:"
  echo "  -d DEVICE_TYPE            Specify the device type (default: CPU)"
  echo "  -b BACKEND_INSTALL_DIR    Specify the backend installation directory (default: empty)"
  echo "  -h                        Show this help message"
  exit 0
}

# Parse command line options
while getopts ":d:b:h" opt; do
  case ${opt} in
    d )
      DEVICE_TYPE=$OPTARG
      ;;
    b )
      BACKEND_INSTALL_DIR="$(realpath ${OPTARG})"
      ;;
    h )
      show_help
      ;;
    \? )
      echo "Invalid option: -$OPTARG" 1>&2
      show_help
      ;;
    : )
      echo "Invalid option: -$OPTARG requires an argument" 1>&2
      show_help
      ;;
  esac
done

# Set default values if not provided
: "${DEVICE_TYPE:=CPU}"
: "${BACKEND_INSTALL_DIR:=}"

# Create necessary directories
mkdir -p build/example
mkdir -p build/icicle

ICILE_DIR=$(realpath "../../../icicle_v3/")
ICICLE_CUDA_SOURCE_DIR="${ICILE_DIR}/backend/cuda"

# Build Icicle and the example app that links to it
if [ "$DEVICE_TYPE" == "CUDA" ] && [ ! -d "${BACKEND_INSTALL_DIR}" ] && [ -d "${ICICLE_CUDA_SOURCE_DIR}" ]; then
  echo "Building icicle with CUDA backend"
  BACKEND_INSTALL_DIR="./target/release/deps/icicle/lib/backend"
  cargo run --release --features=cuda -- --device-type "${DEVICE_TYPE}" --backend-install-dir "${BACKEND_INSTALL_DIR}"
else
  echo "Building icicle without CUDA backend, BACKEND_INSTALL_DIR=${BACKEND_INSTALL_DIR}"
  cargo run --release -- --device-type "${DEVICE_TYPE}" --backend-install-dir "${BACKEND_INSTALL_DIR}"
fi