#!/bin/sh

GETM_BASE=${GETM_BASE=$HOME/GETM/code}
GOTM_BASE=${GOTM_BASE=$HOME/GOTM/code}
fabm=${fabm=on}
FABM_BASE=${FABM_BASE=$HOME/FABM/code}
compiler=${compiler=ifort}
parallel=${parallel=off}
coordinate=${coordinate=Cartesian}

# set compiler flags here - this will be fixed soon
#CMAKE_Fortran_FLAGS=${CMAKE_Fortran_FLAGS="-03"}

GETM_FLAGS=${GETM_FLAGS=""}

cmake $GETM_BASE/src \
     -DGOTM_BASE=$GOTM_BASE \
     -DGETM_USE_FABM=$fabm \
     -DFABM_BASE=$FABM_BASE \
     -DCMAKE_Fortran_COMPILER=$compiler \
     -DCMAKE_INSTALL_PREFIX=../ \
     -DGETM_USE_PARALLEL=$parallel \
     -DGETM_COORDINATE_TYPE=$coordinate \
     -DCMAKE_Fortran_FLAGS=$CMAKE_Fortran_FLAGS \
     -DGETM_FLAGS=$GETM_FLAGS
