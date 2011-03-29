#
# Makefile for making 'topo.nc' forcing for - seamount - setup.
#

CFLAGS = -DKMAX=500

temp: temp.o
	$(CC) -o temp temp.o -lm
	./temp > ./tprofile.dat
	$(RM) temp temp.o
	( cd .. ; ln -sf Temp/tprofile.dat )

#-----------------------------------------------------------------------
# Copyright (C) 2006 - Karsten Bolding and Hans Burchard (BBH)         !
#-----------------------------------------------------------------------
