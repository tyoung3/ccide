## Process this file with automake to produce Makefile.in

# ccide Makefile.am 

#         ccide - C Language Decision Table Code Generator                  #
# Copyright (C) 2002-2004 Thomas W. Young, e-mail:  ccide@twyoung.com       #
# This program is free software; you can redistribute it and/or modify      #
# it under the terms of the GNU General Public License as published by      #
# the Free Software Foundation.                                             #
#                                                                           #
# This program is distributed in the hope that it will be useful,           #
# but WITHOUT ANY WARRANTY; without even the implied warranty of            #
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             #
# GNU General Public License for more details.                              #
#                                                                           #
# You should have received a copy of the GNU General Public License         #
# along with this program; if not, write to the Free Software               #
# Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                 #
# ----------------------------------------------- end of legal stuff ------ #
 

## Notes:
##    A cygwin source tarball is the same as the normal tarball, except
##    for the -RELEASE.bz2 suffix. 

AUTOMAKE_OPTIONS = dejagnu
RUNTESTDEFAULTFLAGS = --tool ccide CCIDE=`pwd`/ccide --outdir /tmp --srcdir ./tests

## noinst_DATA = ${PACKAGE}.sum ${PACKAGE}.log
man_MANS = ccide.1
##SUBDIRS=tests

CONFIG_LINKS = INSTALL install-sh missing mkinstalldirs config.guess config.sub 

DEBUG =   
AM_CFLAGS=@MY_CFLAGS@
ELEV=elev
#  (fails) RH=~/rpms
RH=/usr/src/rpm
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
dist_pkgdata_DATA = 	ccide-C.m4  ccide-CC.m4 ccide-C++.m4  ccide-BASH.m4 ccide-BASIC.m4 	\
			ccide-QB.m4 ccide-VB.m4 ccide-JAVA.m4 ccide-CS.m4   ccide-EX.m4
 
dejatest     = ./tests/ccide.test

deja_sources = ./tests/config/unix.exp ${dejatest}/threeway.in   \
${dejatest}/fourway.in   ${dejatest}/ccidetime.exp ${dejatest}/elev.right \
${dejatest}/hcond.exp    ${dejatest}/huge2.right   ${dejatest}/simple.in  \
${dejatest}/ccidetime.in ${dejatest}/expand.sed    ${dejatest}/hcond.in    \
${dejatest}/huge.exp     ${dejatest}/simple.right  ${dejatest}/ccidetime.right\
${dejatest}/fourway.exp  ${dejatest}/hcond.right   ${dejatest}/huge.in  \
${dejatest}/bin2dec.exp  ${dejatest}/bin2dec.right ${dejatest}/bin2dec.in  \
${dejatest}/threeway.exp ${dejatest}/elev.exp      ${dejatest}/fourway.in\
${dejatest}/huge2.exp    ${dejatest}/huge.right    ${dejatest}/threeway.in\
${dejatest}/elev.in      ${dejatest}/fourway.right ${dejatest}/huge2.in\
${dejatest}/simple.exp   ${dejatest}/threeway.right                     

ccidew_SOURCES = ccideparse.y ccidelex.l ccidemain.c cciderunx.c ccideinline.c ccidemain.h  ccide.pod  ccide.h
EXTRA_SUBDIRS = 
deja_lib = ./lib/ccide.exp
EXTRA_DIST =  ${deja_sources} ${deja_lib} $(man_MANS) ccide.spec ccidemain.h ccide.h ccideparse.h parse.h ChangeLog CYGWIN-PATCHES/setup.hint.in ccide.in

#Bison Flags  ( -y added by autoconf )
AM_YFLAGS = -d -l -v

## SUFFIXES = .y .l $(OBJEXT) .c .d .h

##$(OBJEXT):	$*.o   @LIBCCIDE@.@LIBVER@
##	${LINK} $(LDFLAGS) $(AM_CFLAGS) $*.$(OBJEXT) -o $*

.c$(OBJEXT):	$*.c
	${COMPILE}   -c $*.c -o $*$(OBJEXT)

.c.flaws:
	flawfinder -c -C $*.c $*.flaws > $*.flaws

flaws:  ccideinline.flaws ccidemain.flaws ccideparse.flaws ccidelex.flaws

man: 	${PACKAGE}.1

html:	/home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig

/home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig: ${PACKAGE}.1 ChangeLog
	man2html ${PACKAGE}.1 > /home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig
	${ECHO} Edit /home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig and drop "'.orig'".
	cp ChangeLog /home/httpd/${PACKAGE}/html/inc
	sudo chown tyoung3.www /home/httpd/${PACKAGE}/html/ChangeLog /home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig

${RH}/SOURCES/./ccide-${VERSION}-${RELEASE}.tar.gz:  ${RH}/SOURCES/./ccide-${VERSION}.tar.gz
	sudo ln -sf  $< $@

sources: ${RH}/SOURCES/./ccide-${VERSION}-${RELEASE}.tar.gz ${RH}/SPECS/ccide.spec

${RH}/SPECS/ccide.spec: 
	sudo cp `pwd`/ccide.spec ${RH}/SPECS/ccide.spec

${RH}/SOURCES/./${PACKAGE}-${VERSION}.tar.gz:  ${TARBALL} ${RH}/BUILD
	sudo ${LN_S} -f `pwd`/${TARBALL} ${RH}/SOURCES/./${PACKAGE}-${VERSION}.tar.gz

#  Build cygwin stuff:

cygwin:  dist > ${CYGWIN_SOURCE_TARBALL}

CYGWIN_SOURCE_TARBALL: ${TARBALL} 
	  GZIP=$(GZIP_ENV) gunzip  <${TARBALL} 	\
	| GZIP2=$(GZIP2_ENV) gzip2 -c >${CYGWIN_SOURCE_TARBALL} 

#  Build rpm 
rpm:    dist ${PACKAGE}.1 /home/tyoung3/.pgp/secring.skr sources ${RH}/BUILD 
#	PGPRING=/home/tyoung3/.pgp/secring.skr
#	GPGPPATH=/home/tyoung3/.pgp/
	GPGPPATH=/home/tyoung3/.gnupg/
	sudo /usr/bin/rpmbuild  -ba --sign ${RH}/SPECS/${PACKAGE}.spec

install_rpm: rpm
#	RPMDIR=/mnt/u1/up2date
	RPMDIR=/home/ftp/pub/linux
	cp /usr/src/redhat/RPMS/i386/${PACKAGE}-${VERSION}.i386.rpm $RPMDIR/${PACKAGE}/
	cp /usr/src/redhat/SRPMS/${PACKAGE}-${VERSION}.src.rpm $RPMDIR/${PACKAGE}

${RH}/BUILD:   ~/.rpmmacros
	mkdir -p --verbose ${RH}/{BUILD,RPMS,SOURCES,SPECS,SRPMS}
	mkdir -p --verbose ${RH}/RPMS/{athlon,i386,i486,i586,i686,noarch}

~/.rpmmacros:
	echo "%_topdir /usr/src/redhat" > ~/.rpmmacros

${PACKAGE}.1:	${PACKAGE}.pod
	/usr/bin/pod2man --section=1				\
			--release="${PACKAGE}-${VERSION}"	\
			--center="DecisionTableProcessor(${PACKAGE}) Man Page"	 \
		  ${PACKAGE}.pod > ${PACKAGE}.1

##lib_LIBRARIES = ${LIBCCIDE}.a
##${LIBCCIDE}_a_sources = cciderunx.c

##${LIBCCIDE}.${LIBVER}: ${RUNX}.o 
##	${LINK} -shared -O3 -Wall -Wl,-soname,${LIBCCIDE}.${LIBVER} -o${LIBCCIDE}.${LIBVER} ${RUNX}.o -lc 

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
