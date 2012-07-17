#     _____________________________________________________________________________________
#  	ccide - C Language Decision Table Code Generator 
#	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
#
#   	This file is part of ccide, the C Language Decision Table Code Generator.
#
#   	Ccide is free software: you can redistribute it and/or modify
#   	it under the terms of the GNU General Public License as published by
#    	the Free Software Foundation, either version 3 of the License, or
#   	(at your option) any later version.
#
#    	Ccide is distributed in the hope that it will be useful,
#    	but WITHOUT ANY WARRANTY; without even the implied warranty of
#    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    	GNU General Public License for more details.
#
#    	You should have received a copy of the GNU General Public License
#    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
#    	write to the Free Software Foundation, Inc., 51 Franklin St, 
#    	Fifth Floor, Boston, MA 02110-1301 USA.
#     _____________________________________________________________________________________
#
#
# Process this file with autoconf0 to produce a configure script.
# See 'build' script for complete build process.
AC_PREREQ(2.59)
AC_INIT([ccide], [0.6.2], [ccide@twyoung.com])
#AUTOMAKE_OPTIONS foreign|gnu  

AC_PROG_INSTALL
AC_PROG_CC
AC_PROG_MAKE_SET

# Required to build parser and lexer C files initially.  
AC_PROG_YACC
AM_PROG_LEX

# Not sure if these are really needed.
AC_PROG_LN_S
AC_PROG_RANLIB

# For compiling and testing C++ sample programs.  Not required for ccide itself.
AC_PROG_CXX
# For compiling and testing Java sample programs.  Not required for ccide itself.
AM_PROG_GCJ

# Build shared libs only
AC_DISABLE_STATIC
AM_PROG_LIBTOOL 

# Checks for system type. Defines target_cpu, etc.
AC_CANONICAL_SYSTEM
TARGET=$target_cpu-$target_os

AM_INIT_AUTOMAKE([ccide], [0.6.2])
# For bootstrap system.  See: http://sources.redhat.com/autobook/autobook/autobook_43.html#SEC43
AM_MAINTAINER_MODE(TRUE)

# Do not use 'RELEASE=0'.  Cygwin starts at ...-1.
RELEASE=1
LIBVER=0
LIBCCIDE=libccide
DESCR="C Language Decision Table Code Generator"

LONG_DESCR="Ccide reads a source file of C source code containing\
embedded decision tables from STDIN, analyzes it, and expands the\
tables. All statements not within a decision table are copied unchanged\
to STDOUT, forming a compilable C source module. Erratic side effects\
are avoided by evaluating all condition expressions exactly once and by\
performing all evaluations and actions in the original sequence."

# MY_CFLAGS='-g -Wall -Wtraditional -DRELEASE=\"${RELEASE}\"'
MY_CFLAGS='-O3 -Wall -DRELEASE=\"${RELEASE}\"'

AC_SUBST(RELEASE)
AC_SUBST(LIBVER)
AC_SUBST(LIBCCIDE)
AC_SUBST(MY_CFLAGS)
AC_SUBST(TARGET)
AC_SUBST(DESCR)
AC_SUBST(LONG_DESCR)

# Change install default from /usr/local to /usr
AC_PREFIX_PROGRAM(m4)


# Set of available languages.
# ALL_LINGUAS="de fr es ko nl no pl pt sl sv"
# ALL_LINGUAS=""


#  Do compilation tests using `CC' and `CPP' and use extension `.c'
AC_LANG_C

# Checks for programs.
AC_ISC_POSIX
AC_PATH_PROG(ECHO, echo)
AC_PATH_PROG(M4, m4)

# Replace `main' with a function in -lccide:
# AC_CHECK_LIB(ccide, main)

## LIBOBJS

# Checks for header files.
AC_HEADER_STDC
AC_HEADER_TIME
AC_CHECK_HEADERS(libinitl.h malloc.h stdlib.h stdio.h io.h ctype.h unistd.h limits.h string.h assert.h time.h alloca.h libintl.h stddef.h sys/time.h)

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_STRUCT_TM

# Checks for library functions.
AC_FUNC_STRFTIME
AC_FUNC_ALLOCA
AC_FUNC_MALLOC
AC_FUNC_REALLOC

AC_CHECK_FUNCS(strdup memcpy strstr)
AC_CHECK_FUNCS(malloc)

AC_TYPE_SIZE_T
AC_C_INLINE

AC_MSG_CHECKING([whether to turn on debugging in build])
AC_ARG_ENABLE(debug,
[  --enable-debug          turn on debugging [default=no]],
  [case "${enableval}" in
    yes) CFLAGS="${CFLAGS:=} -g" ; AC_MSG_RESULT([yes]) ;;
    no) CFLAGS="${CFLAGS:=-O3}" ; AC_MSG_RESULT([no]) ;;
    *) AC_MSG_RESULT([unknown])
       AC_MSG_ERROR([bad value ${enableval} for --enable-debug]) ;;
  esac],[CFLAGS="${CFLAGS:=-O}" ; AC_MSG_RESULT([no])])

AC_CONFIG_SRCDIR([src/ccidemain.h])
AM_CONFIG_HEADER(src/ccideconfig.h)
AC_CONFIG_FILES([Makefile src/Makefile tests/Makefile src/ccide.pod scripts/Makefile])
AC_OUTPUT( scripts/ccide ccide.spec CYGWIN-PATCHES/setup.hint)
