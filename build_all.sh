#!/bin/bash

compiler=ifort
mkdir -p _build

# Start with static compilation
setups="box_cartesian box_curvilinear NorthSea seamount upwelling"
setups="sylt"

for setup in $setups; do
	echo $setup
	mkdir -p _build/getm_$setup/
	cd _build/getm_$setup/
	cmake ../../ -DGETM_SETUP=$setup -DCMAKE_Fortran_COMPILER=$compiler 
	make install
	cd ../..
done

coordinates="Cartesian Spherical Curvilinear"
coordinates=""
for coordinate in $coordinates; do
	echo $coordinate
	mkdir -p _build/getm_$coordinate/
	cd _build/getm_$coordinate/
	cmake ../../ -DGETM_COORDINATE_TYPE=$coordinate -DCMAKE_Fortran_COMPILER=$compiler 
	make install
	cd ../..
done
