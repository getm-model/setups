#!/bin/sh

# FABM
if [ ! -d FABM ]; then
   echo "Cloning FABM"
   mkdir FABM && cd FABM
   git clone git://git.code.sf.net/p/fabm/code
   cd ..
else
   echo "FABM already cloned"
fi

# GETM
if [ ! -d GETM ]; then
   echo "Cloning GETM"
   mkdir GETM && cd GETM
   git clone git://git.code.sf.net/p/getm/code
   cd ..
else
   echo "GETM already cloned"
fi

# GOTM
if [ ! -d GOTM ]; then
   echo "Cloning GOTM"
   mkdir GOTM && cd GOTM
   git clone git://git.code.sf.net/p/gotm/code
   cd ..
else
   echo "GOTM already cloned"
fi
