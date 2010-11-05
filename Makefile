#$Id: Makefile,v 1.1.1.1 2007-06-27 09:43:52 kbk Exp $
#
# Master Makefile for making 'getm' v1.7.x and v1.8.x examples
#

SHELL = /bin/sh

ver=2.0.x

# Set the list of ready test setups
SETUPS=`cat SETUPS`

RHOST=gate
RUSER=kbk
#RDIR=/public/bolding-burchard.com/examples/
RDIR=/public/ftp/pub/getm-setups/

all: model

model:
ifdef SETUPS
	set -e; for i in $(SETUPS); do $(MAKE) -C $$i $@; done
endif

base:
#	cvs2cl
	tar -C ../ --exclude=CVS -cvzf getm_setups_base-$(ver).tar.gz \
	v$(ver)/{README,Makefile,Rules.make,SETUPS,ChangeLog,nml}

namelist input run example realclean distclean:
ifdef SETUPS
	set -e; for i in $(SETUPS); do $(MAKE) -C $$i $@; done
endif

release: clean base namelist input example
	scp ChangeLog *.gz $(RUSER)@$(RHOST):$(RDIR)/v$(ver)

clean:
	$(RM) *.tar.gz

#-----------------------------------------------------------------------
# Copyright (C) 2007 - Karsten Bolding, Lars Umlauf and Hans Burchard  !
#-----------------------------------------------------------------------
