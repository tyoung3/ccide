# ccide tests/Makefile

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
GCJ = gcj
# AM_CFLAGS = -lmcheck
# CFLAGS = 
# AM_CFLAGS =  -g --pedantic -std=c99 -D_POSIX_C_SOURCE=200112L -DSTDC_HEADERS  -DRELEASE=\"${RELEASE}\"
CCIDE = $(top_srcdir)/scripts/ccide
CCIDEW = $(top_srcdir)/src/ccidew$(EXEEXT)
GCJDEPMODE = depmode=gcc3
GCJFLAGS = -g -O2
am__fastdepGCJ_FALSE = #
am__fastdepGCJ_TRUE = 

#Programs built with 'make check'
check_PROGRAMS = if2rpn$(EXEEXT)

if2rpn_SOURCES = if2rpn.h if2rpn.c if2rpnq.c if2rpntok.c

if2rpn.txt:
	cp ${srcdir}/if2rpn.txt .

EXTRA_DIST = if2rpn.txt

DISTCLEANFILES = Makefile

TEST_CASES = 	\
       bin2dec	\
       bonus    \
       ccidetime\
       depeter  \
       elev	\
       ex1	\
       fourway	\
       hcond	\
       huge1	\
       huge2	\
       if2rpn	\
       simple	\
       threeway	\
       hw	\
       tryit	 

#%.r : %.r.in 
#	rm -f $@ $@.tmp
#	srcdir=''; \
#		test -f ./$@.in || srcdir=$(srcdir)/; \
#		$(edit) $${srcdir}$@.in >$@    

%: %.cpp 
	${CXX} -g $(CXXFLAGS) $< -o $@ 

%: %.c 
	${CC} -g $(CFLAGS) $<  -o $@  

%.c: ${srcdir}/%.c.d 
	${CCIDEW} -c 3 -b < ${srcdir}/$<  2>$@.err  > $@ 

%.cpp: %.cpp.d 
	${CCIDE} -c 3  -b < ${srcdir}/$< > $@ 

%.java: %.java.d 
	${CCIDE} -L JAVA -c 3 -b  < ${srcdir}/$< > $@ 

%.bash: %.bash.d 
	${CCIDE} -L BASH -c 3 -b < ${srcdir}/$< > $@ 

%: %.bash
	ln -sf $< $@
	chmod a+x $@ 

%: %.java 
	${GCJ} --main=$@ $(GCJFLAGS) $< -o $@ 

testcases:   $(srcdir)/threeway.X 
	$(top_srcdir)/scripts/check.sh mkright ${TEST_CASES} \
	&& touch $@


if2rpn$(EXEEXT): if2rpn.o  if2rpnq.o if2rpntok.o 
	${CC}  -g  $(CFLAGS) if2rpn.o if2rpnq.o if2rpntok.o  -o if2rpn

testhuge2:	huge2
	. huge2.c.opt; ./huge2 $TOPT  

check:	if2rpn$(EXEEXT)
	$(top_srcdir)/scripts/check.sh  ${TEST_CASES}

check_old:	 testcases
	[ -x $(top_srcdir)/scripts/ccide ] || chmod a+x $(top_srcdir)/scripts/ccide
	$(top_srcdir)/scripts/check.sh 

distclean-local:
	rm -f testcases *~
	rm -f *~ *.scan *.log ${TEST_CASES} *.make.out *.output *.err *.c *.bash *.cpp  testcases hw.java  

