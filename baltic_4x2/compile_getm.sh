#!/bin/sh

compiler=ifort
coordinate=Spherical

if [ ! -d build/getm ]; then
   mkdir -p build/getm
   cd build/getm
   mkdir -p $compiler/$coordinate
   cd $compiler/$coordinate
   FABM_BASE=../../../../FABM/code
   GETM_BASE=../../../../GETM/code
   GOTM_BASE=../../../../GOTM/code
   cmake $GETM_BASE/src \
         -DGOTM_BASE=$GOTM_BASE \
         -DGETM_USE_FABM=on \
         -DFABM_BASE=$FABM_BASE \
         -DCMAKE_Fortran_COMPILER=$compiler \
         -DGETM_USE_PARALLEL=on \
         -DGETM_COORDINATE_TYPE=$coordinate \
         -DCMAKE_INSTALL_PREFIX=../../../.. | tee ../log.cmake.$coordinate
else
   cd build/getm/$compiler/$coordinate
fi

make install | tee ../log.make.$coordinate

cd ../../../..
