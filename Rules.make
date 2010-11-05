#$Id: Rules.make,v 1.2 2009-09-23 12:23:25 kb Exp $
#
# Included in the Makefiles for the different setups - kbk 20010523
#

.EXPORT_ALL_VARIABLES:

STATIC += -DSTATIC -D_$(shell echo $(name) | tr a-z A-Z)_TEST_

ifndef GOTMDIR
export GOTMDIR=$(HOME)/GOTM/gotm-cvs
endif

ifndef GETMDIR
export GETMDIR = $(HOME)/GETM/getm-git
endif
#export GETMDIR = $(HOME)/GETM/v1.7.x_femern
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

editscenario.py_args=-q -e nml --schemadir=$(GETMDIR)/schemas

tarflags = -C .. --files-from filelist --exclude=CVS -cvzf

model: link clean
	mkdir -p $(BINDIR)
	$(MAKE) -e -C $(srcdir)

nml2xml:
	nml2xml.py -q $(GETMDIR)/schemas/getm-1.9.schema . $(setup).xml
	mv getm.inp getm.inp.old

namelist:
	editscenario.py $(editscenario.py_args) $(name).xml .

link:
	(cd $(srcdir)/../include ; ln -sf $(GETM_SETUP)/$(name).dim dimensions.h)

run: model namelist input
	$(BINDIR)/getm_prod_$(FORTRAN_COMPILER) >& $(name).log

example:
	echo -n "Created at: " > timestamp
	date >> timestamp
	tar $(tarflags) ../$(setup).tar.gz

clean:

realclean: clean
	$(RM) -f modules/$(FORTRAN_COMPILER)/*
	$(RM) -f lib/$(FORTRAN_COMPILER)/*

archclean: realclean

distclean: clean
	$(RM) -r modules
	$(RM) -r lib
	$(RM) -r bin
	$(RM) -r $(name).?d.*nc
	$(RM) -r $(name)*.stdout
	$(RM) -r $(name)*.stderr

