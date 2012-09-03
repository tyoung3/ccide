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
# AM_CFLAGS =  -g --pedantic -std=c99 -D_POSIX_C_SOURCE=200112L -DSTDC_HEADERS  -DRELEASE=\"${RELEASE}\"
CCIDE = $(top_srcdir)/scripts/ccide
CCIDEW = $(top_srcdir)/src/ccidew$(EXEEXT)
GCJDEPMODE = depmode=gcc3
GCJFLAGS = -g -O2
am__fastdepGCJ_FALSE = #
am__fastdepGCJ_TRUE = 

all: dosunixset

if2rpn.txt:
	cp ${srcdir}/if2rpn.txt ./

EXTRA_DIST = if2rpn.txt

DISTCLEANFILES = Makefile 

TEST_CASES = 	\
        bin2dec	\
        bonus    \
        ccidetime\
        depeter  \
        elev	\
	errors  \
        ex1	\
	ex2	\
        ex4	\
        fourway	\
        hcond	\
	help	\
        huge1	\
        huge2	\
        hw	\
        if2rpn	\
	quadrants3 \
        simple	\
        skel	\
        threeway\
        tryit	\
	t5	\
	t6	\
	undo	\
	version    

%: %.cpp 
	${CXX} -g $(CXXFLAGS) $< -o $@ 

%: %.c 
	${CC} -g $(CFLAGS) $<  -o $@  

%.c: ${srcdir}/%.c.d 
	${CCIDEW}  	 -b ${OPT} < ${srcdir}/$<  2>$@.err  > $@ 

%.cpp: %.cpp.d 
	${CCIDE} -L C++  -b ${OPT} < ${srcdir}/$< > $@ 

%.qb: %.qb.d 
	${CCIDE} -L QB -b ${OPT} < ${srcdir}/$< > $@ 

%.bas: %.bas.d 
	${CCIDE} -L BASIC -b ${OPT} < ${srcdir}/$< > $@ 

%.vb: %.vb.d 
	${CCIDE} -L VB -b ${OPT} < ${srcdir}/$< > $@ 

%.java: %.java.d 
	${CCIDE} -L JAVA -b ${OPT} < ${srcdir}/$< > $@ 

%.bash: %.bash.d 
	${CCIDE}   -L BASH -b ${OPT} < ${srcdir}/$< > $@ 

%.bbl: %.bbl.d 
	${CCIDE} -a -m4  -b ${OPT}  < ${srcdir}/$< > $@ 

%.ex: %.ex.d 
	${CCIDE} -L EX -b ${OPT}  < ${srcdir}/$< > $@ 

%: %.bash
	ln -sf $< $@
	chmod a+x $@ 

%: %.vb
	(echo  "#!/bin/bash"; echo "echo stub for $@")   > $@
	chmod a+x $@

# echo   Add commands to compile VB here.  

%: %.java 
	${GCJ} --main=$@ $(GCJFLAGS) $< -o $@ 

testcases:   $(srcdir)/threeway.X 
	$(top_srcdir)/scripts/check.sh mkright ${TEST_CASES} \
	&& touch $@

if2rpn$(EXEEXT): if2rpn.o  if2rpnq.o if2rpntok.o 
	${CC}  -g  $(CFLAGS) if2rpn.o if2rpnq.o if2rpntok.o  -o if2rpn

testhuge2:	huge2
	. huge2.c.opt; ./huge2 $TOPT  

check_help:
	$(top_srcdir)/scripts/ccide --help 2>&1 > /tmp/help.X
	diff help.X /tmp/help.X							

dosunixset: 
if MINGW
	unix2dos * && touch $@ && unix2dos ../m4/*.m4 && touch $@
else
	touch $@
endif

check_cases:  
	$(top_srcdir)/scripts/check.sh  ${TEST_CASES}

check:	dosunixset check_cases

distclean-local: 
	rm -f dosunixset

clean-local:
	rm -f testcases *~ dosunixset *.o ex2.qb t6.ex 
	rm -f *~ *.scan *.log ${TEST_CASES} *.make.out *.output *.err *.c *.bash *.cpp  testcases *.java  *.vb 

