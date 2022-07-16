package main

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

/* THISIS: simple.go.d */

import "fmt"

/*CCIDE_INLINE_CODE:*/
func a1() int {return 1} 
func a2() int {return 2} 
func a3() int {return 3}  

func main()  {
	c2:=2;c3:=2;c4:=0 
	var swvar[3][3] int
	//={{2,3,4},{3,4,2},{4,3,0}} int 

		/* N.B.: abort() is never executed.*/
	/*DECISION_TABLE:				*/
        /*  2 3 4 | swvar[c2][c3] == $$			*/
        /*  - - - | abort()				*/
        /*  _____ | _______             		*/
        /*  - - - | abort()				*/
        /*  - - X | a1();				*/
        /*  1 2 3 | printf("Rule: %i\n", $$ );		*/
        /*  - X X | a2();				*/
        /*  X X - |NEWGROUP  	Must be last row	*/
        /*END_TABLE:					*/

	//DECISION_TABLE:
	//yny|c4
	//-ny|c2
	//ny-|c3
	//---|--
	//--x|a3();
	//x-x|a1();
	//xx-|a2();
	//END_TABLE:
	  
}
