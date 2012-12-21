#
# Included in the Makefiles for the different setups - kbk 20010523
#

.EXPORT_ALL_VARIABLES:

ADDARGS=
STATIC += -D_$(shell echo $(name) | tr a-z A-Z)_TEST_ $(ADDARGS)

ifndef GOTMDIR
export GOTMDIR=$(HOME)/GOTM/gotm-git
endif

ver=2.3

ifndef GETMDIR
export GETMDIR = $(HOME)/GETM/getm-git
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

editscenario.py_args=-q -e nml --schemadir=$(GETMDIR)/schemas --targetversion=getm-$(ver)

tarflags = -C .. --files-from filelist --exclude=CVS -cvzf

model: link clean
	mkdir -p $(BINDIR)
	$(MAKE) -e -C $(srcdir)

confall confdir confflags:
	$(MAKE) -C $(srcdir) $@

nml2xml:
	nml2xml.py -q $(GETMDIR)/schemas/getm-$(ver).schema . $(setup).xml
	mv getm.inp getm.inp.old

namelist:
	editscenario.py $(editscenario.py_args) $(name).xml .

link:
	(cd $(srcdir)/../include ; ln -sf $(GETM_SETUP)/$(name).dim dimensions.h)

run: input model namelist
	$(BINDIR)/getm_prod_$(FORTRAN_COMPILER) 2> $(name).log

example:
	echo -n "Created at: " > timestamp
	date >> timestamp
	tar $(tarflags) ../$(setup).tar.gz

clean:

realclean: clean
	$(RM) -f modules/$(FORTRAN_COMPILER)/*
	$(RM) -f lib/$(FORTRAN_COMPILER)/*

archclean: realclean

distclean: clean $(name)_clean
	$(RM) timestamp
	$(RM) -r modules
	$(RM) -r lib
	$(RM) -r bin
	$(RM) -r $(name).?d.*nc
	$(RM) -r $(name)*.stdout
	$(RM) -r $(name)*.stderr

