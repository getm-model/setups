#
# Makefile for making STATIC version of the 'sylt' executable.
#

SHELL	= /bin/sh

export GETM_NO_BAROCLINIC=true

name    = sylt
setup	= $(name)

include ../Rules.make

STATIC  += -DSTATIC -DMUDFLAT

.PHONY: input
input:

$(name)_clean:
