#
# Master Makefile for making 'getm' v2.1.x
#

SHELL = /bin/sh

# Set the list of ready test setups
SETUPS=`cat SETUPS`

all: model

model namelist input run example realclean distclean:
ifdef SETUPS
	set -e; for i in $(SETUPS); do $(MAKE) -C $$i $@; done
endif

clean:
	$(RM) *.tar.gz

#-----------------------------------------------------------------------
# Copyright (C) 2007 - Karsten Bolding, Lars Umlauf and Hans Burchard  !
#-----------------------------------------------------------------------
