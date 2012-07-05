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
# DIST_SUBDIRS = lib src tests examples CYGWIN-PATCHES 
SUBDIRS = src 

RH=/usr/src/rpm
EXTRA_SUBDIRS = 
EXTRA_DIST =  $(man_MANS) ccide.spec ccide.spec.in ccidemain.h ccide.h ccideparse.h parse.h ChangeLog CYGWIN-PATCHES/setup.hint.in ccide.in

dist_pkgdata_DATA = 	m4/ccide-C.m4  m4/ccide-CC.m4 m4/ccide-C++.m4  m4/ccide-BASH.m4 m4/ccide-BASIC.m4 	\
			m4/ccide-QB.m4 m4/ccide-VB.m4 m4/ccide-JAVA.m4 m4/ccide-CS.m4   m4/ccide-EX.m4


check:	tests/check.sh all-am 
	[ -x ccide ] || chmod a+x ccide
	cd tests; ./check.sh

~/.rpmmacros:
	echo "%_topdir /usr/src/redhat" > ~/.rpmmacros

#  Build rpm 
rpm:    dist ${PACKAGE}.1 /home/tyoung3/.pgp/secring.skr sources ${RH}/BUILD 
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



html:	/home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig

/home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig: ${PACKAGE}.1 ChangeLog
	man2html ${PACKAGE}.1 > /home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig
	${ECHO} Edit /home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig and drop "'.orig'".
	cp ChangeLog /home/httpd/${PACKAGE}/html/inc
	sudo chown tyoung3.www /home/httpd/${PACKAGE}/html/ChangeLog /home/httpd/${PACKAGE}/html/${PACKAGE}_man.html.orig

${RH}/SOURCES/./ccide-${VERSION}-${RELEASE}.tar.gz:  ${RH}/SOURCES/./ccide-${VERSION}.tar.gz
	sudo ln -sf  $< $@

sources: ${RH}/SOURCES/./ccide-${VERSION}-${RELEASE}.tar.gz ${RH}/SPECS/ccide.spec

${RH}/SPECS/ccide.spec: ccide.spec
	sudo cp ccide.spec ${RH}/SPECS/ccide.spec

${RH}/SOURCES/./${PACKAGE}-${VERSION}.tar.gz:  ${TARBALL} ${RH}/BUILD
	sudo ${LN_S} -f `pwd`/${TARBALL} ${RH}/SOURCES/./${PACKAGE}-${VERSION}.tar.gz

#  Build cygwin stuff:

cygwin:  dist > ${CYGWIN_SOURCE_TARBALL}

CYGWIN_SOURCE_TARB-amALL: ${TARBALL} 
	  GZIP=$(GZIP_ENV) gunzip  <${TARBALL} 	\
	| GZIP2=$(GZIP2_ENV) gzip2 -c >${CYGWIN_SOURCE_TARBALL} 



# This works with GNU tar and gives cleaner package than normal 'make dist'.
#mydist_???:
#        VERSION=$(VERSION); \
#        if test -d "$(srcdir)/.git" && type git > /dev/null 2>&1; then \
#                SNAPSHOT=`cd "$(srcdir)" && git describe --abbrev=4 | cut -b2-`; \
#                test -n "$$SNAPSHOT" && VERSION=$$SNAPSHOT; \
#        fi; \
#        TAR_OPTIONS='--owner=0 --group=0 --numeric-owner --mode=u+rw,go+r-w' \
#                $(MAKE) VERSION="$$VERSION" dist-gzip
