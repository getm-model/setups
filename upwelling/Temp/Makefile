#$Id: Makefile,v 1.1 2007-06-27 12:38:07 kbk Exp $
#
# Makefile for making 'tprofile.dat' forcing for - upwelling - setup.
#
#

CFLAGS = -DKMAX=500

topo: temp.o
	$(CC) -o temp temp.o -lm
	./temp > ../tprofile.dat
	$(RM) temp temp.o

#-----------------------------------------------------------------------
# Copyright (C) 2006 - Karsten Bolding and Hans Burchard (BBH)         !
#-----------------------------------------------------------------------
