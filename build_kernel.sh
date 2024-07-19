#!/bin/bash

#export ARCH=arm64
#export PATH=$(pwd)/../PLATFORM/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9/bin:$PATH

#mkdir out

#make -C $(pwd) O=$(pwd)/out CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android crownqlte_chn_hk_defconfig
#make -j64 -C $(pwd) O=$(pwd)/out CROSS_COMPILE=aarch64-linux-android- KCFLAGS=-mno-android

#cp out/arch/arm64/boot/Image $(pwd)/arch/arm64/boot/Image

# The cross compilation toolchains path
export TOOLCHAIN=$(pwd)/../toolchain
export TOOLCHAIN32=$(pwd)/../toolchain32

# This is the directory for the compiled kernel
export OUTDIR="O=$(pwd)/../build"

export PATH=$TOOLCHAIN/bin:$TOOLCHAIN32/bin:$PATH
export ARCH=arm64
export CROSS_COMPILE=aarch64-linux-android-
export CROSS_COMPILE_ARM32=arm-linux-androideabi-
export THREADS=$(nproc --all)
export COMMON_ARGS="-j$THREADS $OUTDIR ARCH=$ARCH CFLAGS_MODULE=-mno-android"
if [ "$1" == "build" ]; then
        make $COMMON_ARGS star2qlte_chn_open_defconfig
        make $COMMON_ARGS
elif [ "$1" == "rebuild" ]; then
        make $COMMON_ARGS
elif [ "$1" == "clean" ]; then
        make $COMMON_ARGS distclean
        make $COMMON_ARGS clean
else
        echo "./build_kernel.sh build|rebuild|clean"
fi
