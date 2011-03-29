#$Id: Makefile,v 1.2 2009-09-23 12:20:26 kb Exp $
#
# Makefile for making 'topo.nc' forcing for - seamount - setup.
#
#

#CPPFLAGS = -DIMAX=66 -DJMAX=66 -DHMAX=4500. -DL=25000. -DA=0.9	# moderately steep
CPPFLAGS = -DIMAX=66 -DJMAX=66 -DHMAX=4500. -DL=50000. -DA=0.6	# very steep

topo: topo.o
	$(CC) -o topo topo.o -lm
	cpp -P $(CPPFLAGS) < topo.proto > topo.cdl
	./topo >> topo.cdl
	ncgen -b topo.cdl
	$(RM) topo.cdl topo topo.o
	( cd .. ; ln -sf Topo/topo.nc )

#-----------------------------------------------------------------------
# Copyright (C) 2002 - Karsten Bolding and Hans Burchard (BBH)         !
#-----------------------------------------------------------------------
