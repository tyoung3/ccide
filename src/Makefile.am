#  	ccide - C Language Decision Table Code Generator 
#	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

#    	This file is part of ccide, the C Language Decision Table Code Generator.

#   	Ccide is free software: you can redistribute it and/or modify
#   	it under the terms of the GNU General Public License as published by
#    	the Free Software Foundation, either version 3 of the License, or
#   	(at your option) any later version.

#    	Ccide is distributed in the hope that it will be useful,
#    	but WITHOUT ANY WARRANTY; without even the implied warranty of
#    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    	GNU General Public License for more details.

#    	You should have received a copy of the GNU General Public License
#    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
#    	write to the Free Software Foundation, Inc., 51 Franklin St, 
#    	Fifth Floor, Boston, MA 02110-1301 USA.
# ----------------------------------------------- end of legal stuff ---------------------- #


## Process this file with automake to produce Makefile.in

## Notes:
##    A cygwin source tarball is the same as the normal tarball, except
##    for the -RELEASE.bz2 suffix. 

AUTOMAKE_OPTIONS=
RUNTESTDEFAULTFLAGS = --tool ccide CCIDE=`pwd`/ccide --outdir /tmp --srcdir ./tests

man_MANS = ccide.1

CONFIG_LINKS = INSTALL install-sh missing mkinstalldirs config.guess config.sub 

DEBUG =   
AM_CFLAGS=@MY_CFLAGS@
ELEV=elev
CCIDE=${PACKAGE}
PARSE=${PACKAGE}parse
MAIN=${PACKAGE}main
RUNX=${PACKAGE}runx
INLINE=${PACKAGE}inline
PRIST=/home/tyoung3/ftp/pub/linux/${PACKAGE}
CCIDE_DIR=$(distdir)
TARBALL= $(distdir).tar.gz
CYGWIN_TARBALL= $(distdir).tar.bz2
CYGWIN_SOURCE_TARBALL= $(distdir)-src.tar.bz2

##automake standard names:
bin_PROGRAMS = ccidew
bin_SCRIPTS = ccide
 
ccidew_SOURCES = ccideparse.y ccidelex.l ccidemain.c cciderunx.c ccideinline.c ccidemain.h  ccide.pod  ccide.h

#Bison Flags  ( -y added by autoconf )
AM_YFLAGS = -d -l -v

.c$(OBJEXT):	$*.c
	${COMPILE}   -c $*.c -o $*$(OBJEXT)

.c.flaws:
	flawfinder -c -C $*.c $*.flaws > $*.flaws

flaws:  ccideinline.flaws ccidemain.flaws ccideparse.flaws ccidelex.flaws

man: 	${PACKAGE}.1


${PACKAGE}.1:	${PACKAGE}.pod
	/usr/bin/pod2man --section=1				\
			--release="${PACKAGE}-${VERSION}"	\
			--center="DecisionTableProcessor(${PACKAGE}) Man Page"	 \
		  ${PACKAGE}.pod > ${PACKAGE}.1


${MAIN}$(OBJEXT):  ${MAIN}.h ${MAIN}.c ${PARSE}.h ${RUNX}.o config.h

${PARSE}.h:  ${PARSE}.c 
	
${PARSE}.c: $(PARSE).y
	$(YACC) $(AM_YFLAGS) $(PARSE).y
	mv y.tab.c $(PARSE).c;
	mv y.tab.h $(PARSE).h

${CCIDE}lex.c: ${PARSE}.h ${MAIN}.h ${CCIDE}lex.l 
	$(LEX) -i -o${CCIDE}lex.c ${CCIDE}lex.l

${CCIDE}lex.o: ${PARSE}.h ${MAIN}.h ${CCIDE}lex.c ${CCIDE}.h 

installcheck-local:
	echo `ccide -V` 
