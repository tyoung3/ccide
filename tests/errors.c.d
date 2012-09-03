/*  	ccide - C Language Decision Table Code Generator 
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
*/

/* THISIS: errors.c.d 
	ERRORS.C has no purpose other than verifying ccide code generation.
*/

#include <stdio.h>
#include <stdlib.h>

/*CCIDE_INLINE_CODE:*/
int a1() {}
int a2() {}
int a3() {}

main() {
	int c2=2,c3=2,c4;
	int swvar[3][3]={{2,3,4},{3,4,2},{4,3,0}};


		/* N.B.: abort() is never executed.*/
	/*DECISION_TABLE:				*/
	/*   Y  N  Y N | swvar[c2][c3] == 2		*/
	/*   N  N  N Y | swvar[c3][c4] == 1		*/
        /*______________________________________________*/
	/*   -  -  - - | abort()			*/
	/*   -  -  X - | a1();				*/
	/*   -  X  X - | a2();				*/
        /*END_TABLE:					*/


	/*DECISION_TABLE:				*/
	/*   -  Y  -  N | swvar[c2][c3] == 2		*/
	/*   Y  N  -  N | swvar[c3][c4] == 1		*/
        /*______________________________________________*/
	/*   X  -  X  X | a1();				*/
	/*   X  X  X  - | a2();				*/
        /*END_TABLE:					*/

	/*DECISION_TABLE:				*/
	/*   -  Y  N  N | swvar[c1][c2] == 2		*/
	/*   Y  N  Y  N | swvar[c3][c4] == 1		*/
	/*   Y  N  Y  N | swvar[c1][c2] == 2		*/
        /*______________________________________________*/
	/*   X  -  X  X | a1();				*/
	/*   X  X  X  - | a2();				*/
        /*END_TABLE:					*/		 

	/*DECISION_TABLE:				*/
	/*   -  Y  N  N | swvar[c1][c2] == 2		*/
	/*   Y  N  Y  N | swvar[c3][c4] == 1		*/
	/*   Y  N  Y  N | swvar[c1][c2] == 2		*/
        /*______________________________________________*/
	/*   X  -  X  X | a1();				*/
	/*   X  X  X  - | a2();				*/
	/*   -  X  -  - | a1();				*/
        /*END_TABLE:					*/

	/*DECISION_TABLE:				*/
	/*   -  Y  N  N | swvar[c2][c3] == 2		*/
	/*   Y  N  Y  N | swvar[c3][c4] = 1		*/
        /*______________________________________________*/
	/*   X  -  X  X | a1();				*/
	/*   X  X  X  - | a2();				*/
        /*END_TABLE:	
	return 0;  
}
