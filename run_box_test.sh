#!/bin/bash

setup=$1

make execs

if [ ! -d Serial ]; then
mkdir Serial
fi
export parallel=False; export out_dir=./Serial; make namelist
time ( bin/getm_prod_IFORT_serial >& ./Serial/log.serial ) >& Serial/log.time
mv getm.inp Serial/

if [ ! -d OpenMP ]; then
mkdir OpenMP
fi
export parallel=False; export out_dir=./OpenMP; make namelist
export OMP_NUM_THREADS=4 ; export OMP_SCHEDULE=guided,1
#time ( bin/getm_prod_IFORT_openmp >& ./OpenMP/log.openmp ) >& OpenMP/log.time
mv getm.inp OpenMP/

if [ ! -d Parallel ]; then
mkdir Parallel
fi
export parallel=True; export out_dir=./Parallel;  make namelist
mpdboot
#time ( mpiexec -np 4 bin/getm_prod_IFORT_mpi ) >& Parallel/log.time 
ncmerge Parallel/*.2d.???.nc Parallel/$setup.2d.nc && ncmerge Parallel/*.3d.???.nc Parallel/$setup.3d.nc
rm Parallel/*.[23]d.???.nc
mv *.stderr getm.inp Parallel/
rm *.stdout

../show_timer_speedup.pl Serial/log.serial OpenMP/log.openmp > log.speedup


