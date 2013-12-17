#
# Makefile for making STATIC version of the - North Sea - executable.
#
SHELL	= /bin/bash

name	= NorthSea
setup	= $(name)

STATIC += -DSTATIC -DSPHERICAL

include ../Rules.make

.PHONY: input

input:
	ln -sf Forcing/River/rivers.nc            river.nc
	ln -sf Forcing/Meteo/CFSR.daymean.2006.nc meteo.nc
	ln -sf Forcing/3D/bound_3D.CFSR.2006.nc   bdy.3d.nc
	ln -sf Forcing/2D/bdy.2d.2006.nc          bdy.2d.nc
	ln -sf Topo/NS6nm.v01.nc                  topo.nc

1p 2p 4p:
	ln -sf Parallel/$(name).$@.dim $(name).dim
	( export GETM_PARALLEL=true; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@  )
	$(RM) -r $@ && mkdir $@
	( export out_dir=$@ ; export parallel=True ; $(MAKE) namelist )
	mpiexec -np `echo $@ | cut -c 1,1` ./bin/getm_prod_$(FORTRAN_COMPILER)_$@ && mv *.stderr $@
	ln -sf Parallel/$(name).1p.dim $(name).dim

$(name)_clean:
	$(RM) -rv 1p 2p 4p store log

.PHONY: 1p 2p 4p
