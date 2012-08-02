
AC_PREREQ(2.59)
AC_INIT([ccide],[0.6.2],[ccide@twyoung.com])
TARGET=$target_cpu-$target_os
AM_MAINTAINER_MODE(TRUE)
AC_CANONICAL_TARGET([])
AM_INIT_AUTOMAKE([ccide], [0.6.2])

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

CFLAGS='-O3  -g --pedantic -std=c99 -D_POSIX_C_SOURCE=200112L -DSTDC_HEADERS -Werror  -DRELEASE=\"${RELEASE}\"'


###########CONFIG.H######################
AC_PROG_INSTALL
AC_PROG_CC
AC_PROG_MAKE_SET
AC_PROG_YACC
AM_PROG_LEX

AC_PROG_LN_S
AC_PROG_RANLIB

AC_PROG_CXX


###########CONFIG.H######################
AC_SUBST(RELEASE)
AC_SUBST(LIBVER)
AC_SUBST(LIBCCIDE)
AC_SUBST(TARGET)
AC_SUBST(DESCR)
AC_SUBST(LONG_DESCR)

AC_PREFIX_PROGRAM(m4)
AC_LANG([C])
AC_ISC_POSIX
AC_PATH_PROG(ECHO, echo)
AC_PATH_PROG(M4, m4)
AC_HEADER_STDC
AC_HEADER_TIME
AC_STRUCT_TM

AC_TYPE_SIZE_T
AC_C_INLINE


AC_CONFIG_FILES([autogen.sh], [chmod +x autogen.sh])

AC_CHECK_HEADERS([assert.h], [], [],
   [[#ifdef HAVE_ASSERT_H
     # include <assert.h>
     #endif
   ]])

# Autoscan 
AC_CHECK_HEADERS([libintl.h]) 
AC_CHECK_HEADERS([limits.h]) 
AC_CHECK_HEADERS([malloc.h]) 
AC_CHECK_HEADERS([stddef.h]) 
AC_CHECK_HEADERS([sys/time.h]) 
AC_C_CONST 
AC_FUNC_REALLOC 


#  ############PRESERVE THESE############################
AC_CONFIG_SRCDIR([src/ccidemain.h])
AC_CONFIG_HEADERS([src/ccideconfig.h])
AC_CONFIG_FILES([Makefile scripts/Makefile src/Makefile tests/Makefile src/ccide.pod])
AC_CONFIG_FILES([ccide.spec CYGWIN-PATCHES/setup.hint])
AC_OUTPUT
