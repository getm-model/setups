#
# Makefile for making STATIC version of the - box_cartesian - executable.
#

SHELL	= /bin/sh

name	= box_cartesian
setup	= $(name)

STATIC += -DUV_TVD

include ../Rules.make

input:

executables: serial openmp mpi

serial:
	ln -sf box_cartesian.1p.dim box_cartesian.dim
	( unset GETM_PARALLEL; unset GETM_OMP; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
 	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@ )

openmp:
	ln -sf box_cartesian.4p.dim box_cartesian.dim
	( unset GETM_PARALLEL; \
	export GETM_OMP=true; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@  )
	ln -sf box_cartesian.1p.dim box_cartesian.dim

mpi:
	ln -sf box_cartesian.4p.dim box_cartesian.dim
	( unset GETM_OMP; \
	export GETM_PARALLEL=true; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@  )
	ln -sf box_cartesian.1p.dim box_cartesian.dim

run_tests: executables
	./run_tests.sh

.PHONY: run_tests

#-----------------------------------------------------------------------
# Copyright (C) 2006 - Lars Unmlauf and Karsten Bolding                !
#-----------------------------------------------------------------------
