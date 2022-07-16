#!/bin/bash

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

# scripts/ccide.d.  Generated from ccide.d.in by configure.  ccide is a wrapper script for ccidew.  

CCIDELANG=C
BINDIR="/usr/bin"
PKGDATADIR=@pkgdatadir@
LANGSX="BASH BASIC C CH CC C++ CS EX JAVA QB VB JS"

CCIDE_DIE

#CCIDE_INLINE_CODE:
CCIDE_INLINECODE()
CCIDE_COMMENT(GENERATED_CODE: )
CCIDE_COMMENT(^^^ Substitution strings are: /:: and @@/%%%)
CCIDE_COMMENT(END_GENERATED_CODE: )

#DECISION_TABLE:
#    Y   Y   Y   Y   Y   Y   Y | -z "$CCIDEW" 
#    Y   -   -   -   -   -   - | -x ../src/ccidew 
#    -   Y   -   -   -   -   - | -x ../src/ccidew.exe 
#    -   -   Y   -   -   -   - | -x ./ccidew.exe 
#    -   -   -   Y   -   -   - | -x ./ccidew   
#    -   -   -   -   Y   -   - | -x $BINDIR/ccidew  
#    -   -   -   -   -   Y   - | -x $BINDIR/ccidew.exe  
#___________________________________________________________
#    X   -   -   -   -   -   - | CCIDEW=`pwd`/../src/ccidew
#    -   X   -   -   -   -   - | CCIDEW=`pwd`/../src/ccidew.exe
#    -   -   X   -   -   -   - | CCIDEW=`pwd`/ccidew.exe
#    -   -   -   X   -   -   - | CCIDEW=`pwd`/ccidew
#    -   -   -   -   X   -   - | CCIDEW=$BINDIR/ccidew
#    -   -   -   -   -   X   - | CCIDEW=$BINDIR/ccidew.exe
#    -   -   -   -   -   -   X | Die Cannot find bin/ccidew
#END_TABLE:
CCIDE_COMMENT(^^^GENERATED_CODE: FOR TABLE_1.%%%)
CCIDE_COMMENT(^^^	7 Rules, 7 conditions, and 7 actions.%%%)
CCIDE_COMMENT(^^^	Table 1 rule order = 1 2 3 4 5 6 7 %%%)
	CCIDE_TABLE_YES(1, 7, 3 5 9 17 33 65 1)


	CCIDE_SWITCH_YES(7,
CCIDE=0
^^^[[ -z "$CCIDEW" ]] %%% && CCIDE=1
^^^[[ -x ../src/ccidew ]]%%% && CCIDE=$((CCIDE+=2)) 
^^^[[ -x ../src/ccidew.exe ]]%%% && CCIDE=$((CCIDE+=4)) 
^^^[[ -x ./ccidew.exe ]]%%% && CCIDE=$((CCIDE+=8)) 
^^^[[ -x ./ccidew ]]%%% && CCIDE=$((CCIDE+=16)) 
^^^[[ -x $BINDIR/ccidew ]]%%% && CCIDE=$((CCIDE+=32)) 
^^^[[ -x $BINDIR/ccidew.exe ]]%%% && CCIDE=$((CCIDE+=64)) 
		  ,1)
	CCIDE_CASE(1,6,7)
	    CCIDE_ACTION(^^^Die Cannot find bin/ccidew%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(1,5,6)
	    CCIDE_ACTION(^^^CCIDEW=$BINDIR/ccidew.exe%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(1,4,5)
	    CCIDE_ACTION(^^^CCIDEW=$BINDIR/ccidew%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(1,3,4)
	    CCIDE_ACTION(^^^CCIDEW=`pwd`/ccidew%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(1,2,3)
	    CCIDE_ACTION(^^^CCIDEW=`pwd`/ccidew.exe%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(1,1,2)
	    CCIDE_ACTION(^^^CCIDEW=`pwd`/../src/ccidew.exe%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(1,0,1)
	    CCIDE_ACTION(^^^CCIDEW=`pwd`/../src/ccidew%%%)
	    CCIDE_BREAK()
	CCIDE_END_SWITCH()
CCIDE_COMMENT(^^^END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0 Sat 16 Jul 2022 10:03:02 AM EDT %%%)


#   Set m4 directory...  	
CWD=`pwd`
[ -f ../m4/ccide-CC.m4 ] && M4DIR=$CWD/../m4
[ -f m4/ccide-CC.m4 ] && M4DIR=$CWD/m4
[ -f /usr/share/ccide/ccide-CC.m4 ] && M4DIR=/usr/share/ccide
[ -z $CCIDE_M4DIR ] || M4DIR=$CCIDE_M4DIR;   # CCIDE_M4DIR overrides if specified:

while [[ $# > 0 ]]; do
	#DECISION_TABLE:
	#    Y   -   -   -   - | "$1" == "-L"
	#    -   Y   -   -   - | "$1" == "-m4"
	#    -   -   Y   -   - | "$1" == "--help"
	#    -   -   -   Y   - | ("$1" == "-V") || ("$1" == "--version")
	#________________________________________________________
	#    X   -   -   -   - | CCIDELANG=`echo $2|tr [:lower:] [:upper:]`; shift
	#    -   X   -   -   - | CCIDE_M4="yes"
	#    -   -   X   -   - | $CCIDEW --help
	#    -   -   X   -   - | exit 0
	#    -   -   -   X   - | echo "	ccide-0.7.0-0"
	#    -   -   -   X   - | WC="$WC -V"
	#    -   -   -   -   X | WC="$WC $1"
	#END_TABLE:
	CCIDE_COMMENT(^^^GENERATED_CODE: FOR TABLE_2.%%%)
	CCIDE_COMMENT(^^^	5 Rules, 4 conditions, and 7 actions.%%%)
	CCIDE_COMMENT(^^^	Table 2 rule order = 1 2 3 4 5 %%%)
		CCIDE_TABLE_YES(2, 5, 1 2 4 8 0)


		CCIDE_SWITCH_YES(5,
	CCIDE=0
	^^^[[ "$1" == "-L" ]] %%% && CCIDE=1
	^^^[[ "$1" == "-m4" ]]%%% && CCIDE=$((CCIDE+=2)) 
	^^^[[ "$1" == "--help" ]]%%% && CCIDE=$((CCIDE+=4)) 
	^^^[[ ("$1" == "-V") || ("$1" == "--version") ]]%%% && CCIDE=$((CCIDE+=8)) 
			  ,2)
		CCIDE_CASE(2,4,5)
		    CCIDE_ACTION(^^^WC="$WC $1"%%%)
		    CCIDE_BREAK()
		CCIDE_CASE(2,3,4)
		    CCIDE_ACTION(^^^echo "	ccide-0.7.0-0"%%%)
		    CCIDE_ACTION(^^^WC="$WC -V"%%%)
		    CCIDE_BREAK()
		CCIDE_CASE(2,2,3)
		    CCIDE_ACTION(^^^$CCIDEW --help%%%)
		    CCIDE_ACTION(^^^exit 0%%%)
		    CCIDE_BREAK()
		CCIDE_CASE(2,1,2)
		    CCIDE_ACTION(^^^CCIDE_M4="yes"%%%)
		    CCIDE_BREAK()
		CCIDE_CASE(2,0,1)
		    CCIDE_ACTION(^^^CCIDELANG=`echo $2|tr [:lower:] [:upper:]`; shift%%%)
		    CCIDE_BREAK()
		CCIDE_END_SWITCH()
	CCIDE_COMMENT(^^^END_GENERATED_CODE: FOR TABLE_2, by ccide-0.7.0-0 Sat 16 Jul 2022 10:03:02 AM EDT %%%)
	shift
done

#DECISION_TABLE:
#    Y   -   -   - | "$CCIDE_M4" == "yes"
#    -   Y   -   - | "$CCIDELANG" == "C" 
#    -   -   Y   - | "$CCIDELANG" == "?"
#    -   -   -   Y | "$CCIDELANG" == "CH"
#________________________________________________________
#    X   -   -   - | $CCIDEW -m4 $WC
#    -   X   -   X | $CCIDEW $WC
#    -   -   X   - | echo "Ccide supported languages are: $LANGSX"
#    X   X   -   X | exit $?
#    -   -   X   - | exit 2
#END_TABLE:
CCIDE_COMMENT(^^^GENERATED_CODE: FOR TABLE_3.%%%)
CCIDE_COMMENT(^^^	4 Rules, 4 conditions, and 5 actions.%%%)
CCIDE_COMMENT(^^^	Table 3 rule order = 1 2 3 4 %%%)
	CCIDE_TABLE_YES(3, 4, 1 2 4 8)


	CCIDE_SWITCH_YES(4,
CCIDE=0
^^^[[ "$CCIDE_M4" == "yes" ]] %%% && CCIDE=1
^^^[[ "$CCIDELANG" == "C" ]]%%% && CCIDE=$((CCIDE+=2)) 
^^^[[ "$CCIDELANG" == "?" ]]%%% && CCIDE=$((CCIDE+=4)) 
^^^[[ "$CCIDELANG" == "CH" ]]%%% && CCIDE=$((CCIDE+=8)) 
		  ,3)
	CCIDE_CASE(3,2,3)
	    CCIDE_ACTION(^^^echo "Ccide supported languages are: $LANGSX"%%%)
	    CCIDE_ACTION(^^^exit 2%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(3,1,2)
	    CCIDE_ACTION(^^^$CCIDEW $WC%%%)
	    CCIDE_ACTION(^^^exit $?%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(3,3,4)
	    CCIDE_ACTION(^^^$CCIDEW $WC%%%)
	    CCIDE_ACTION(^^^exit $?%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(3,0,1)
	    CCIDE_ACTION(^^^$CCIDEW -m4 $WC%%%)
	    CCIDE_ACTION(^^^exit $?%%%)
	    CCIDE_BREAK()
	CCIDE_END_SWITCH()
CCIDE_COMMENT(^^^END_GENERATED_CODE: FOR TABLE_3, by ccide-0.7.0-0 Sat 16 Jul 2022 10:03:02 AM EDT %%%)


[ -f $M4DIR/ccide-${CCIDELANG}.m4 ] || Die Cannot find $M4DIR/ccide-${CCIDELANG}.m4

#DECISION_TABLE:
#    Y   -   N | "$CCIDELANG" == "BASH"
#    -   Y   - | "$CCIDELANG" == "EX"
#__________________________________________
#    X   -   - | DELIM="-d '[[' ']]'" 
#    -   X   X | $CCIDEW            -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"
#    X   -   - | $CCIDEW -m4 $DELIM -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"
#END_TABLE:
CCIDE_COMMENT(^^^GENERATED_CODE: FOR TABLE_4.%%%)
CCIDE_COMMENT(^^^	3 Rules, 2 conditions, and 3 actions.%%%)
CCIDE_COMMENT(^^^	Table 4 rule order = 1 3 2 %%%)
	CCIDE_TABLE_YES(4, 3, 1 0 2)
CCIDE_TABLE_NO(4, 3 , 0 1 0)


	CCIDE_SWITCH(3,^^^
CCIDE=0
^^^[[ "$CCIDELANG" == "BASH" ]] %%% && CCIDE=1
^^^[[ "$CCIDELANG" == "EX" ]]%%% && CCIDE=$((CCIDE+=2)) 
		  %%%,4)
	CCIDE_CASE(4,0,1)
	    CCIDE_ACTION(^^^DELIM="-d '[[' ']]'"%%%)
	    CCIDE_ACTION(^^^$CCIDEW -m4 $DELIM -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(4,1,3)
	    CCIDE_ACTION(^^^$CCIDEW            -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"%%%)
	    CCIDE_BREAK()
	CCIDE_CASE(4,2,2)
	    CCIDE_ACTION(^^^$CCIDEW            -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"%%%)
	    CCIDE_BREAK()
	CCIDE_END_SWITCH()
CCIDE_COMMENT(^^^END_GENERATED_CODE: FOR TABLE_4, by ccide-0.7.0-0 Sat 16 Jul 2022 10:03:02 AM EDT %%%)

 
exit $?
