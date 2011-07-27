
execs: serial openmp mpi

serial:
	ln -sf $(name).1p.dim $(name).dim
	( unset GETM_PARALLEL; unset GETM_OMP; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
 	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@ )

openmp:
	( unset GETM_PARALLEL; \
	export GETM_OMP=true; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@  )
	ln -sf $(name).1p.dim $(name).dim

mpi:
	ln -sf $(name).4p.dim $(name).dim
	( unset GETM_OMP; \
	export GETM_PARALLEL=true; \
	export MODDIR=`pwd`/modules/$(FORTRAN_COMPILER)/$@/; \
	export LIBDIR=`pwd`/lib/$(FORTRAN_COMPILER)/$@/; \
	$(MAKE); \
	mv bin/getm_prod_$(FORTRAN_COMPILER) bin/getm_prod_$(FORTRAN_COMPILER)_$@  )
	ln -sf $(name).1p.dim $(name).dim



run_box_test: execs
	../run_box_test.sh $(setup)

.PHONY: run_box_test

$(name)_clean:
	$(RM) -r Serial OpenMP Parallel

