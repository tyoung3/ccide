#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# ? PACKAGE_URL

AC_PREREQ(2.59)
AC_INIT([ccide],[0.6.4],[ccide@twyoung.com])
AC_CONFIG_SRCDIR([src/ccidemain.h])
AC_CONFIG_HEADERS([src/ccideconfig.h])

TARGET=$target_cpu-$target_os
AM_MAINTAINER_MODE(TRUE)
AC_CANONICAL_TARGET([])
AM_INIT_AUTOMAKE([ccide], [0.6.4])

RELEASE=1	
LIBVER=0
LIBCCIDE=libccide
DESCR="C Language Decision Table Code Generator"

LONG_DESCR="Ccide reads a source code file containing\
embedded decision tables from STDIN, analyzes and expands each of the\
tables. All statements not within a decision table are copied unchanged\
to STDOUT, generating a compilable C source module. Erratic side effects\
are avoided by evaluating all condition expressions exactly once and by\
performing evaluations and actions in the original sequence."

# Conformance checks:
#you need to add an explicit invocation of ‘AC_GNU_SOURCE’ in the configure.ac file - after ‘AC_PROG_CC’ but before ‘AM_GNU_GETTEXT’, most #likely very close to the ‘AC_PROG_CC’ invocation. This is necessary because of ordering restrictions imposed by GNU autoconf. 
#  Localization 
AC_GNU_SOURCE
AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.17])
# AM_INTL_SUBDIR([intl])

# Checks for programs.
AC_PROG_CXX
AC_PROG_YACC
AC_PROG_CC
AC_PROG_CPP
AC_PROG_LEX
AC_PROG_AWK
AC_PROG_INSTALL
AC_PROG_LN_S
AC_PROG_MAKE_SET
AC_PROG_RANLIB

# Checks for libraries.

# Checks for header files.
AC_FUNC_ALLOCA
AC_HEADER_STDC
AC_CHECK_HEADERS([libintl.h limits.h malloc.h stddef.h stdlib.h string.h sys/time.h unistd.h])

# additional header checks
AC_HEADER_TIME

AC_CHECK_HEADERS([assert.h], [], [],
   [[#ifdef HAVE_ASSERT_H
     # include <assert.h>
     #endif
   ]])

# Checks for library functions.
AC_FUNC_MALLOC
AC_FUNC_REALLOC 
AC_FUNC_STRFTIME 
AC_CHECK_FUNCS([strstr]) 
#  ----------------------------
AC_FUNC_ALLOCA

# Checks for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_C_INLINE
AC_TYPE_SIZE_T
AC_STRUCT_TM

# Check for gcc built-in function(s):
AC_REPLACE_FUNCS([__builtin_popcount strdup] )
# ?? AC_USE_SYSTEM_EXTENSIONS   AC_CHECK_DECLS 
#########################################


###########CONFIG.H######################
AC_SUBST(RELEASE)
AC_SUBST(LIBVER)
AC_SUBST(LIBCCIDE)
AC_SUBST(TARGET)
AC_SUBST(DESCR)
AC_SUBST(LONG_DESCR)

AC_PREFIX_PROGRAM(m4)
AC_LANG([C])

# Uncomment POSIX for mingw ??
# AC_ISC_POSIX

AC_PATH_PROG(ECHO, echo)
AC_PATH_PROG(M4, m4)

# Req'd for builds: disp_pkg.mk  extra_dist.mk:  Built by scripts/check.sh mkam


#  ############Generation############################
AC_CONFIG_FILES([autogen.sh ], [chmod +x autogen.sh]) 
AC_CONFIG_FILES([scripts/check.sh], [chmod +x scripts/check.sh]) 

AC_CONFIG_FILES([Makefile
		 ccide.spec 
		 disp_pkg.mk  
		 extra_dist.mk
		 CYGWIN-PATCHES/setup.hint
                 scripts/Makefile
		 po/Makefile.in
		 po/Makefile
                 src/Makefile
                 src/ccide.pod
                 tests/Makefile])
AC_OUTPUT
