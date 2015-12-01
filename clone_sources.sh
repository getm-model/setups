#!/bin/sh

# FABM
if [ -d "$FABM_BASE" ]; then
   echo "Using FABM source from $FABM_BASE"
elif [ ! -d FABM ]; then
   echo "Cloning FABM in `pwd`"
   mkdir FABM && cd FABM
   git clone git://git.code.sf.net/p/fabm/code
   cd ..
   echo "Using FABM source from `pwd`/FABM"
else
   echo "FABM source already cloned to FABM/"
fi

# GETM
if [ -d "$GETM_BASE" ]; then
   echo "Using GETM source from $GETM_BASE"
elif [ ! -d GETM ]; then
   echo "Cloning GETM"
   mkdir GETM && cd GETM
   git clone git://git.code.sf.net/p/getm/code
   cd ..
   echo "Using GETM source from `pwd`/GETM"
else
   echo "GETM source already cloned to GETM/"
fi

# GOTM
if [ -d "$GOTM_BASE" ]; then
   echo "Using GOTM source from $GOTM_BASE"
elif [ ! -d GOTM ]; then
   echo "Cloning GOTM"
   mkdir GOTM && cd GOTM
   git clone git://git.code.sf.net/p/gotm/code
   cd ..
   echo "Using GOTM source from `pwd`/GOTM"
else
   echo "GOTM source already cloned to GOTM/"
fi
