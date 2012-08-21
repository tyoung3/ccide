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
#GENERATED_CODE:
#
#ccide-BASH.m4
#Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
#  The code generated by ccide is covered by the same license as the source  
#  code(decision table) from which it is derived. If you created the source,  
#  you are free to do anything you like with the generated code, 
#  including incorporating it into or linking it with proprietary software.  
#
function CcideFindRule() {             # Return rule number
	CCIDE=0; nstate=$(( 4294967295 ^ ${2} ))
        while [[ $CCIDE -lt ${1} ]] 						\
		&& (    [[ $((${CCIDE_YES[$CCIDE]} & $nstate)) -ne 0 ]] 	\
		     || [[ $((${CCIDE_NO[$CCIDE]}  & ${2})) -ne 0 ]] ); do	\
 	               CCIDE=$(($CCIDE+1))
        done
}
#
function CcideFindRuleYes() {             # Return rule number
	CCIDE=0; nstate=$(( 4294967295 ^ ${2} ))
        while [[ $CCIDE -lt ${1} ]] 						\
		&& [[ $((${CCIDE_YES[$CCIDE]} & $nstate)) -ne 0 ]]; do		\
               CCIDE=$(($CCIDE+1))
        done
}
#
#END_GENERATED_CODE:
#GENERATED_CODE: 
# Substitution strings are: /:: and @@/
#END_GENERATED_CODE: 

T1="1"

while [[ $N > 0 ]]; do

        NBR=$(($NBR+1))
        P=$NBR

	#DECISION_TABLE:
	#   Y  -  -  N | "${!P}" == "BASH"
	#   -  Y  -  N | "${!P}" == "bash"
	#   -  -  Y  N | "${!P}" == "C"
	#   1  3  1  - | "$T1"   == "/::"
	# ____________________________
	#   1  2  3  4 | T1=/::; echo -n "Rule=/:: N=$P T1=$T1 P=$P "
	#   X  X  -  - | echo "Got ${!P}!"
	#   -  -  X  - | echo "Got C!"
	#   -  -  -  X | echo "None of the above"
	#END_TABLE:
	#GENERATED_CODE: FOR TABLE_1.
	#	4 Rules, 5 conditions, and 7 actions.
	#	Table 1 rule order = 4 1 2 3 
		CCIDE_YES=(0 9 18 12)
	CCIDE_NO=(7 0 0 0)


		
	CCIDE=0
	[[ "${!P}" == "BASH" ]]  && CCIDE=1
	[[ "${!P}" == "bash" ]] && CCIDE=$((CCIDE+=2)) 
	[[ "${!P}" == "C" ]] && CCIDE=$((CCIDE+=4)) 
	[[ "$T1"   == "1" ]] && CCIDE=$((CCIDE+=8)) 
	[[ "$T1"   == "3" ]] && CCIDE=$((CCIDE+=16)) 
			  
	CcideFindRule 4 $CCIDE;	case $CCIDE in
		(0) #	Rule 4
		    T1=4; echo -n "Rule=4 N=$P T1=$T1 P=$P ";
		    echo "None of the above";
		    ;;
		(3) #	Rule 3
		    T1=3; echo -n "Rule=3 N=$P T1=$T1 P=$P ";
		    echo "Got C!";
		    ;;
		(2) #	Rule 2
		    T1=2; echo -n "Rule=2 N=$P T1=$T1 P=$P ";
		    echo "Got ${!P}!";
		    ;;
		(1) #	Rule 1
		    T1=1; echo -n "Rule=1 N=$P T1=$T1 P=$P ";
		    echo "Got ${!P}!";
		    ;;
		esac
	#END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.5-1  

	N=$(( $N-1 ))
	
done
