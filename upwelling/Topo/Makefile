#$Id: Makefile,v 1.2 2009-09-23 12:20:26 kb Exp $
#
# Makefile for making 'topo.nc' forcing for - upwelling- setup.
#

CPPFLAGS = -DIMAX=202 -DJMAX=4 

topo: topo.o
	$(CC) $(CPPFLAGS) -o topo topo.o -lm
	cpp -P $(CPPFLAGS) < topo.proto > topo.cdl
	./topo >> topo.cdl
	ncgen -b topo.cdl
	$(RM) topo.cdl topo topo.o
	mv topo.nc ../

#-----------------------------------------------------------------------
# Copyright (C) 2006 - Karsten Bolding and Hans Burchard (BBH)         !
#-----------------------------------------------------------------------
