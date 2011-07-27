#
# Makefile for making STATIC version of the - box_cartesian - executable.
#

SHELL	= /bin/sh

name	= box_cartesian
setup	= $(name)

STATIC += -DUV_TVD

include ../Rules.make

include ../Boxes.make

.PHONY: input
input:
