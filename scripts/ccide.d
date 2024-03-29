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

#DECISION_TABLE:
#    Y   Y   Y   Y   Y   Y   Y   | -z "$CCIDEW" 
#    Y   -   -   -   -   -   -   | -x ../src/ccidew 
#    -   Y   -   -   -   -   -   | -x ../src/ccidew.exe 
#    -   -   Y   -   -   -   -   | -x ./ccidew.exe 
#    -   -   -   Y   -   -   -   | -x ./ccidew   
#    -   -   -   -   Y   -   -   | -x $BINDIR/ccidew  
#    -   -   -   -   -   Y   -   | -x $BINDIR/ccidew.exe  
#___________________________________________________________
#    X   -   -   -   -   -   -   | CCIDEW=`pwd`/../src/ccidew
#    -   X   -   -   -   -   -   | CCIDEW=`pwd`/../src/ccidew.exe
#    -   -   X   -   -   -   -   | CCIDEW=`pwd`/ccidew.exe
#    -   -   -   X   -   -   -   | CCIDEW=`pwd`/ccidew
#    -   -   -   -   X   -   -   | CCIDEW=$BINDIR/ccidew
#    -   -   -   -   -   X   -   | CCIDEW=$BINDIR/ccidew.exe
#    -   -   -   -   -   -   X   | Die Cannot find bin/ccidew
#END_TABLE:


#   Set m4 directory...  	
CWD=`pwd`
[ -f ../m4/ccide-CC.m4 ] && M4DIR=$CWD/../m4
[ -f m4/ccide-CC.m4 ] && M4DIR=$CWD/m4
[ -f /usr/share/ccide/ccide-CC.m4 ] && M4DIR=/usr/share/ccide
[ -z $CCIDE_M4DIR ] || M4DIR=$CCIDE_M4DIR;   # CCIDE_M4DIR overrides if specified:

while [[ $# > 0 ]]; do
	#DECISION_TABLE:
	# Y  -  -  -  -  | "$1" == "-L"
	# -  Y  -  -  -  | "$1" == "-m4"
	# -  -  Y  -  -  | "$1" == "--help"
	# -  -  -  Y  -  | ("$1" == "-V") || ("$1" == "--version")
	#________________________________________________________
	# X  -  -  -  -  | CCIDELANG=`echo $2|tr [:lower:] [:upper:]`; shift
	# -  X  -  -  -  | CCIDE_M4="yes"
	# -  -  X  -  -  | $CCIDEW --help
	# -  -  X  -  -  | exit 0
	# -  -  -  X  -  | echo "	ccide-0.7.0-0"
	# -  -  -  X  -  | WC="$WC -V"
	# -  -  -  -  X  | WC="$WC $1"
	#END_TABLE:
	shift
done

#DECISION_TABLE:
#  Y  -  -  -    | "$CCIDE_M4" == "yes"
#  -  Y  -  -    | "$CCIDELANG" == "C" 
#  -  -  Y  -    | "$CCIDELANG" == "?"
#  -  -  -  Y    | "$CCIDELANG" == "CH"
#________________________________________________________
#  X  -  -  -    | $CCIDEW -m4 $WC
#  -  X  -  X    | $CCIDEW $WC
#  -  -  X  -    | echo "Ccide supported languages are: $LANGSX"
#  X  X  -  X    | exit $?
#  -  -  X  -    | exit 2
#END_TABLE:


[ -f $M4DIR/ccide-${CCIDELANG}.m4 ] || Die Cannot find $M4DIR/ccide-${CCIDELANG}.m4

#DECISION_TABLE:
#  Y  -  N  | "$CCIDELANG" == "BASH"
#  -  Y  -  | "$CCIDELANG" == "EX"
#__________________________________________
#  X  -  -  | DELIM="-d '[[' ']]'" 
#  -  X  X  | $CCIDEW            -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"
#  X  -  -  | $CCIDEW -m4 $DELIM -L $CCIDELANG $WC | /usr/bin/m4 -P "$M4DIR/ccide-$CCIDELANG.m4" "-"
#END_TABLE:

 
exit $?
