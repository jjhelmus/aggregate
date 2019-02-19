#!/bin/bash

set -ex

export CMAKE_LIBRARY_PATH=$PREFIX/lib:$PREFIX/include:$CMAKE_LIBRARY_PATH
export CMAKE_PREFIX_PATH=$PREFIX
export TH_BINARY_BUILD=1
export PYTORCH_BUILD_VERSION=$PKG_VERSION
export PYTORCH_BUILD_NUMBER=$PKG_BUILDNUM

if [ ${cudatoolkit} == "8.0" ]; then
    # compile for Kepler, Kepler+Tesla, Maxwell, Pascal
    export TORCH_CUDA_ARCH_LIST="3.0;3.5;5.0;5.2+PTX;6.0;6.1"
elif [ ${cudatoolkit} == "9.0" ]; then
    # compile for Kepler, Kepler+Tesla, Maxwell, Pascal, Volta
    export TORCH_CUDA_ARCH_LIST="3.0;3.5;5.0;5.2+PTX;6.0;6.1;7.0"
fi

export TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
export NCCL_ROOT_DIR=/usr/local/cuda
export USE_STATIC_CUDNN=1
export USE_STATIC_NCCL=1
export ATEN_STATIC_CUDA=1
export USE_CUDA_STATIC_LINK=1
#export NO_MKLDNN=1

export EXTRA_CAFFE2_CMAKE_FLAGS="-DCMAKE_VERBOSE_MAKEFILE:BOOL=ON"

# use conda provided nccl
#export NCCL_ROOT_DIR="${PREFIX}"
#export NCCL_LIB_DIR="${PREFIX}/lib"
#export NCCL_INCLUDE_DIR="${PREFIX}/include"

#export LDFLAGS="$LDFLAGS -Wl,-rpath-link,$PREFIX/lib -Wl,-v"
#export LD_LIBRARY_PATH=$PREFIX/lib
#export CMAKE_MODULE_LINKER_FLAGS="$LDFLAGS"

python setup.py install
# use conda provided nccl
#export NCCL_ROOT_DIR="${PREFIX}"
#export NCCL_LIB_DIR="${PREFIX}/lib"
#export NCCL_INCLUDE_DIR="${PREFIX}/include"

#export MAGMA_HOME="${PREFIX}"
#export PYTORCH_BINARY_BUILD=1
#export LIBRT=$(find ${BUILD_PREFIX} -name "librt.so")

#mkdir build
#cd build
#bash ../tools/build_pytorch_libs.sh --use-cuda --use-nnpack --use-mkldnn --use-qnnpack caffe2
#exit 9

