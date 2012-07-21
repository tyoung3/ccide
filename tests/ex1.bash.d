#!/bin/bash

# ex1.bash.ccide.d:  test input for 'ccide -L BASH < ex1.bash.ccide.d'

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

# THISIS: ex1.bash.d 

Copyright() { 
	cat << EOF
        ccide - C Language Decision Table Code Generator 
        Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

        This file is part of ccide, the C Language Decision Table Code Generator.

        Ccide is free software: you can redistribute it and/or modify
        it under the terms of the GNU General Public License as published by
        the Free Software Foundation, either version 3 of the License, or
        (at your option) any later version.

        Ccide is distributed in the hope that it will be useful,
        but WITHOUT ANY WARRANTY; without even the implied warranty of
        MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
        GNU General Public License for more details.

        You should have received a copy of the GNU General Public License
        along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
        write to the Free Software Foundation, Inc., 51 Franklin St, 
        Fifth Floor, Boston, MA 02110-1301 USA.
EOF
}

LANG=BASH
N=$#
NBR=0

#CCIDE_INLINE_CODE:

T1="1"

while [[ $N > 0 ]]; do

        NBR=$(($NBR+1))
        P=$NBR

	#DECISION_TABLE:
	#  Y - - N | "${!P}" == "BASH"
	#  - Y - - | "${!P}" == "bash"
	#  - - Y N | "${!P}" == "C"
	#  1 3 1 - | "$T1"   == "/::"
	# ________ | ______________
	#  1 2 3 4 | T1=/::; echo -n "Rule=/:: N=$P T1=$T1 P=$P "
	#  X X - - | echo "Got ${!P}!"
	#  - - X - | echo "Got C!"
	#  - - - X | echo "None of the above"
	#END_TABLE:

	N=$(( $N-1 ))
	
done
