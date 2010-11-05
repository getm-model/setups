#$Id: Makefile,v 1.1 2007-06-27 12:38:07 kbk Exp $
#
# Makefile for making STATIC version of the 'sylt' executable.
#

SHELL	= /bin/sh

export GETM_NO_BAROCLINIC=true

name    = sylt
setup	= $(name)

include ../Rules.make

STATIC  += -DUV_TVD -DMUDFLAT

input:

#-----------------------------------------------------------------------
# Copyright (C) 2006 - Hans Burchard and Karsten Bolding (BBH)         !
#-----------------------------------------------------------------------
