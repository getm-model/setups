#!/bin/sh

if [ $# -eq 0 ]; then
   build_dir="build"
else
   build_dir=$1
fi

old=`pwd`
if [ ! -d "$build_dir" ]; then
   mkdir $build_dir
fi
cd $build_dir

export name=NorthSea
export fabm=off
#export compiler=
export parallel=off
export coordinate=Spherical
export GETM_FLAGS=-D_`echo $name | tr a-z A-Z`_TEST_

#export CMAKE_Fortran_FLAGS=""

. $old/../CMake_configure.sh

cd $old

echo "cd to $build_dir and do a 'make install'"

