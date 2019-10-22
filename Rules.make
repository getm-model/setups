#
# Included in the Makefiles for the different setups - kbk 20010523
#

.EXPORT_ALL_VARIABLES:

MAKE_PROCS?=1

ADDARGS=
STATIC += -D_$(shell echo $(name) | tr a-z A-Z)_TEST_ $(ADDARGS)

ver=2.5

ifndef GETMDIR
$(warning GETMDIR not defined!)
endif
srcdir  = $(GETMDIR)/src

ifndef GETM_SETUP
export GETM_SETUP:=$(shell pwd)
endif

ifndef LIBDIR
export LIBDIR=$(GETM_SETUP)/lib/$(FORTRAN_COMPILER)
endif
ifndef MODDIR
export MODDIR=$(GETM_SETUP)/modules/$(FORTRAN_COMPILER)
endif
ifndef BINDIR
export BINDIR=$(GETM_SETUP)/bin
endif

ifneq ($(wildcard $(GETMDIR)/CMakeLists.txt),)
GETM_CMAKE=$(GETMDIR)
else
GETM_CMAKE=$(GETMDIR)/src
endif

ifdef GETM_PREFIX
external_GETM_PREFIX=$(GETM_PREFIX)
else
GETM_PREFIX=$(CURDIR)/build
endif

ifdef GOTM_PREFIX
GOTM_ARG=-DGOTM_PREFIX=$(GOTM_PREFIX)
else
ifndef GOTMDIR
$(error GOTMDIR must be defined!)
endif
GOTM_ARG="-DGOTM_BASE=$(GOTMDIR)"
endif

#ifneq ($(FABM),false)
#bwd compatibility with old GOTM cmake using env(FABM_PREFIX)
ifeq ($(FABM),true)
ifdef FABM_PREFIX
FABM_ARG = -DGETM_USE_FABM=ON -DFABM_PREFIX=$(FABM_PREFIX)
else
ifndef GOTM_PREFIX
FABM_ARG = -DGETM_USE_FABM=ON -DFABM_EMBED_VERSION=ON
ifdef FABMDIR
FABM_ARG += -DFABM_BASE=$(FABMDIR)
endif
endif
endif
endif

ifeq ($(GETM_PARALLEL),true)
GETM_USE_PARALLEL=ON
else
GETM_USE_PARALLEL=OFF
endif

ARFLAGS=rvU

editscenario.py_args=-q -e nml . --schemadir=$(GETMDIR)/schemas --targetversion=getm-$(ver)

tarflags = -C .. --files-from filelist --exclude=CVS -cvzf

model: link
	mkdir -p $(BINDIR)
	$(MAKE) -C $(srcdir)

ifdef external_GETM_PREFIX
getm:
else
getm: cmake
endif
	@mkdir -p $(CURDIR)/bin
	ln -snf $(GETM_PREFIX)/bin/getm* $(CURDIR)/bin/getm

cmake: link
	@mkdir -p build
	@(cd build ; cmake $(GETM_CMAKE)  -DCMAKE_INSTALL_PREFIX=`pwd` \
                                     -DCMAKE_INSTALL_RPATH_USE_LINK_PATH=ON \
                                     -DGETM_EMBED_VERSION=ON \
                                     -DGETM_USE_FLEXIBLE_OUTPUT=ON \
                                     -DGETM_USE_PARALLEL=$(GETM_USE_PARALLEL) \
                                     -DCMAKE_Fortran_FLAGS="$(EXTRA_FFLAGS)" \
                                     -DGETM_FLAGS="$(STATIC)" \
                                     $(GOTM_ARG) \
                                     $(FABM_ARG) || false)
	@(cd build ; make -s install -j$(MAKE_PROCS))

clone_sources:
	. ../clone_sources.sh

cmake_config:
	. ../CMake_configure.sh

compile_getm:
	. ../compile_getm.sh

confall confdir confflags:
	$(MAKE) -C $(srcdir) $@

nml2xml:
	nml2xml -q $(GETMDIR)/schemas/getm-$(ver).schema . -e xml $(setup).xml
	mv getm.inp getm.inp.old

namelist:
	editscenario $(name).xml $(editscenario.py_args)

namelist-gui:
	editscenario $(name).xml -g $(editscenario.py_args)

link:
	(cd $(srcdir)/../include ; ln -sf $(GETM_SETUP)/$(name).dim dimensions.h)

run: input model namelist
	$(BINDIR)/getm_prod_$(FORTRAN_COMPILER) 2> $(name).log

example:
	echo -n "Created at: " > timestamp
	date >> timestamp
	tar $(tarflags) ../$(setup).tar.gz

clean:
	$(RM)    $(name).[2-3]d.nc $(name).[2-3]d.[0-9][0-9][0-9][0-9].nc
	$(RM)    $(name).mean.nc $(name).mean.[0-9][0-9][0-9][0-9].nc
	$(RM) -r $(name)*.stdout
	$(RM) -r $(name)*.stderr

realclean: clean
	$(RM) -f modules/$(FORTRAN_COMPILER)/*
	$(RM) -f lib/$(FORTRAN_COMPILER)/*

archclean: realclean

distclean: clean $(name)_clean
	$(RM) timestamp
	$(RM) -r modules
	$(RM) -r lib
	$(RM) -r bin
	$(RM) -r build

