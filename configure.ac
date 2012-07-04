dnl  	ccide - C Language Decision Table Code Generator 
dnl	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
dnl
dnl   	This file is part of ccide, the C Language Decision Table Code Generator.
dnl
dnl   	Ccide is free software: you can redistribute it and/or modify
dnl   	it under the terms of the GNU General Public License as published by
dnl    	the Free Software Foundation, either version 3 of the License, or
dnl   	(at your option) any later version.
dnl
dnl    	Ccide is distributed in the hope that it will be useful,
dnl    	but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl    	GNU General Public License for more details.
dnl
dnl    	You should have received a copy of the GNU General Public License
dnl    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
dnl    	write to the Free Software Foundation, Inc., 51 Franklin St, 
dnl    	Fifth Floor, Boston, MA 02110-1301 USA.


dnl Process this file with autoconf to produce a configure script.
dnl See 'build' script for complete build process.
AC_INIT(ccidemain.c)

# Checks for system type. Definest target_cpu, etc.
AC_CANONICAL_SYSTEM
TARGET=$target_cpu-$target_os

AM_CONFIG_HEADER(ccideconfig.h)
AM_INIT_AUTOMAKE(ccide, 0.5.0)
# For bootstrap system.  See:
#  	http://sources.redhat.com/autobook/autobook/autobook_43.html#SEC43
AM_MAINTAINER_MODE(TRUE)

dnl Do not use 'RELEASE=0'.  Cygwin starts at ...-1.
RELEASE=8

LIBVER=0
LIBCCIDE=libccide
DESCR="C Language Decision Table Code Generator"

LONG_DESCR="Ccide reads a source file of C source code containing\
embedded decision tables from STDIN, analyzes it, and expands the\
tables. All statements not within a decision table are copied unchanged\
to STDOUT, forming a compilable C source module. Erratic side effects\
are avoided by evaluating all condition expressions exactly once and by\
performing all evaluations and actions in the original sequence."

dnl MY_CFLAGS='-g -Wall -Wtraditional -DRELEASE=\"${RELEASE}\"'
MY_CFLAGS='-O3 -Wall -DRELEASE=\"${RELEASE}\"'

AC_SUBST(RELEASE)
AC_SUBST(LIBVER)
AC_SUBST(LIBCCIDE)
dnl ##AC_SUBST(SUBDIRS)
AC_SUBST(MY_CFLAGS)
AC_SUBST(TARGET)
AC_SUBST(DESCR)
AC_SUBST(LONG_DESCR)

# Change install default from /usr/local to /usr
AC_PREFIX_PROGRAM(m4)

# Expand subdirectories
AC_PROG_MAKE_SET

dnl Set of available languages.
# ALL_LINGUAS="de fr es ko nl no pl pt sl sv"
# ALL_LINGUAS=""

dnl Build shared libs only
AC_DISABLE_STATIC

dnl  Do compilation tests using `CC' and `CPP' and use extension `.c'
AC_LANG_C

dnl Checks for programs.
# Hmmm.  Not on Solaris 9.  AC_PROG_CXX
AC_PROG_YACC
AC_PROG_CC
AC_ISC_POSIX
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PATH_PROG(ECHO, echo)
AC_PATH_PROG(M4, m4)

AM_PROG_LEX
AM_PROG_LIBTOOL 

dnl Checks for libraries.
dnl Replace `main' with a function in -lc:
AC_CHECK_LIB(c, main)
dnl Replace `main' with a function in -lccide:
dnl AC_CHECK_LIB(ccide, main)

## LIBOBJS

dnl Checks for header files.
AC_HEADER_STDC
AC_HEADER_TIME
AC_CHECK_HEADERS(malloc.h unistd.h limits.h string.h assert.h time.h alloca.h libintl.h stddef.h sys/time.h)

dnl Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_STRUCT_TM

dnl Checks for library functions.
AC_FUNC_STRFTIME
AC_FUNC_ALLOCA
AC_FUNC_MALLOC
AC_FUNC_REALLOC

AC_CHECK_FUNCS(strdup memcpy strstr)
AC_CHECK_FUNCS(malloc)

AC_PROG_RANLIB
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


AC_OUTPUT(Makefile ccide.spec CYGWIN-PATCHES/setup.hint ccide )