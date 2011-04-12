#
# Makefile for making STATIC version of the - upwelling - executable.
#

SHELL	= /bin/sh

name = upwelling
setup = $(name)

include ../Rules.make

STATIC += -DSTATIC -DUV_TVD -DSLICE_MODEL

input: topo temp

temp:
	$(MAKE) -C ./Temp

topo:
	$(MAKE) -C ./Topo

$(name)_clean:
