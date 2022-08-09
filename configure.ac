#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

# ? PACKAGE_URL

AC_PREREQ([2.71])
AC_INIT([ccide],[0.7.0],[ccide@twyoung.com])
AC_CONFIG_SRCDIR([src/ccidemain.h])
AC_CONFIG_HEADERS([src/ccideconfig.h])

HOST=$host_cpu-$host_os
AM_MAINTAINER_MODE(TRUE)
AC_CANONICAL_HOST([])
AM_INIT_AUTOMAKE([ccide], [0.7.0])

RELEASE=0	
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
#you need to add an explicit invocation of ‘AC_USE_SYSTEM_EXTENSIONS’ in the configure.ac file - after ‘AC_PROG_CC’ but before ‘AM_GNU_GETTEXT’, most #likely very close to the ‘AC_PROG_CC’ invocation. This is necessary because of ordering restrictions imposed by GNU autoconf. 
#  Localization 
AC_USE_SYSTEM_EXTENSIONS
AM_GNU_GETTEXT([external])
AM_GNU_GETTEXT_VERSION([0.17])
# AM_INTL_SUBDIR([intl])
AM_ICONV

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
m4_warn([obsolete],
[The preprocessor macro `STDC_HEADERS' is obsolete.
  Except in unusual embedded environments, you can safely include all
  ISO C90 headers unconditionally.])dnl
# Autoupdate added the next two lines to ensure that your configure
# script's behavior did not change.  They are probably safe to remove.
AC_CHECK_INCLUDES_DEFAULT
AC_PROG_EGREP
 
AC_HEADER_STDBOOL
AC_CHECK_HEADERS([libintl.h limits.h malloc.h stddef.h stdlib.h string.h sys/time.h unistd.h])
AC_CHECK_HEADERS([locale.h]) 

# additional header checks
m4_warn([obsolete],
[Update your code to rely only on HAVE_SYS_TIME_H,
then remove this warning and the obsolete code below it.
All current systems provide time.h; it need not be checked for.
Not all systems provide sys/time.h, but those that do, all allow
you to include it and time.h simultaneously.])dnl
AC_CHECK_HEADERS_ONCE([sys/time.h])
# Obsolete code to be removed.
if test $ac_cv_header_sys_time_h = yes; then
  AC_DEFINE([TIME_WITH_SYS_TIME],[1],[Define to 1 if you can safely include both <sys/time.h>
	     and <time.h>.  This macro is obsolete.])
fi
# End of obsolete code.


AC_CHECK_HEADERS([assert.h], [], [],
   [[#ifdef HAVE_ASSERT_H
     # include <assert.h>
     #endif
   ]])

# Checks for library functions.
AC_CHECK_FUNCS([setlocale])
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
AC_SUBST(HOST)
AC_SUBST(DESCR)
AC_SUBST(LONG_DESCR)

AC_PREFIX_PROGRAM(m4)
AC_LANG([C])

# Uncomment POSIX for mingw ??
# AC_SEARCH_LIBS([strerror],[cposix])

AC_PATH_PROG(ECHO, echo)
AC_PATH_PROG(M4, m4)

# Req'd for builds: disp_pkg.mk  extra_dist.mk:  Built by scripts/check.sh mkam

# Conditions for makefiles:

case $host_os in
  *linux*)
        AC_SUBST([CHOST],[LINUX])
        ;;
   *mingw*)
        AC_SUBST([CHOST],[MINGW])
        ;;
    *)
        AC_SUBST([CHOST],[QQ])
        ;;
esac

AM_CONDITIONAL([MINGW], [test $CHOST = MINGW] )
AM_CONDITIONAL(DEBUG, test "$enable_debug" = yes)

#AM_CONDITIONAL([CCIDE_USENLS],[test ${USE_NLS} = yes] )
#AC_SUBST([CCIDE_USENLS])

AC_ARG_ENABLE([debug],
     [  --enable-debug    Turn on debugging],
     [case "${enableval}" in
       yes) debug=true ;;
       no)  debug=false ;;
       *) AC_MSG_ERROR([bad value ${enableval} for --enable-debug]) ;;
     esac],[debug=false])
     AM_CONDITIONAL([DEBUG], [test x$debug = xtrue])

#  ############Generation############################
AC_CONFIG_FILES([autogen.sh ], [chmod +x autogen.sh]) 
AC_CONFIG_FILES([scripts/check.sh], [chmod +x scripts/check.sh]) 
AC_CONFIG_FILES([scripts/ccide.d], [chmod +x scripts/ccide.d]) 

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
