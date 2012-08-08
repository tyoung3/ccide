# ccide scripts/Makefile

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

edit = sed \
		-e 's|@bindir[@]|$(bindir)|g' \
		-e 's|@pkgdatadir[@]|$(pkgdatadir)|g' \
		-e 's|@PACKAGE[@]|$(PACKAGE)|g' \
		-e 's|@ECHO[@]|$(ECHO)|g' \
		-e 's|@VERSION[@]|$(VERSION)|g' \
		-e 's|@RELEASE[@]|$(RELEASE)|g' \
		-e 's|@M4[@]|$(M4)|g' \
		-e 's|@prefix[@]|$(prefix)|g'

all:  ccide check.sh

# See http://www.gnu.org/software/autoconf/manual/autoconf-2.67/html_node/Installation-Directory-Variables.html#Installation-Directory-Variables
# for explanation.
ccide: ccide.in Makefile 
	rm -f $@ $@.tmp
	srcdir=''; \
		test -f ./$@.in || srcdir=$(srcdir)/; \
		$(edit) $${srcdir}$@.in >$@.tmp     
	chmod +x $@.tmp
	chmod a-w $@.tmp
	mv $@.tmp $@

install: all

installcheck: all
	echo Verify ccide/ccidew version.

install-strip:  all

uninstall:

distdir:

#distclean: clean 
#	rm ccide

distclean-local:
	rm Makefile  ccide

clean-local:
	rm -f *~ 

.PHONY: check distdir distclean test 

