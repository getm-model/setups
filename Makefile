#
# Master Makefile for making test cases for getm-2.4
#

SHELL = /bin/sh

# Set the list of ready test setups
SETUPS=`cat SETUPS`

all: model

model namelist input run example realclean distclean nml2xml:
ifdef SETUPS
	set -e; for i in $(SETUPS); do $(MAKE) -C $$i $@; done
endif

clean:
	$(RM) *.tar.gz

#-----------------------------------------------------------------------
# Copyright (C) 2007 - Karsten Bolding, Lars Umlauf and Hans Burchard  !
#-----------------------------------------------------------------------
