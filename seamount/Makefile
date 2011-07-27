#
# Makefile for making STATIC version of the - seamount - executable.
#

SHELL	= /bin/sh

name = seamount
setup = $(name)

include ../Rules.make

STATIC += -DUV_TVD

.PHONY: input
input: topo temp

topo:
	$(MAKE) -C ./Topo

temp:
	$(MAKE) -C ./Temp

1p 2p 4p 8p:
	ln -sf $(name).$@.dim $(name).dim
	( export GETM_PARALLEL=true; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@  )
	$(RM) -r $@ && mkdir $@
	( export out_dir=$@ ; export parallel=True ; $(MAKE) namelist )
	mpiexec -np `echo $@ | cut -c 1,1` ./bin/getm_prod_$(FORTRAN_COMPILER)_$@ && mv *.stderr $@
	ln -sf $(name).1p.dim $(name).dim

$(name)_clean:
	$(RM) -r 1p 2p 4p 8p

.PHONY: 1p 2p 3p 4p
