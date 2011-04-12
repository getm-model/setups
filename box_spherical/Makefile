#
# Makefile for making STATIC version of the - box_spherical - executable.
#

SHELL	= /bin/sh

name	= box_spherical
setup	= $(name)

include ../Rules.make

STATIC += -DSTATIC -DUV_TVD -DSPHERICAL

include ../Boxes.make
