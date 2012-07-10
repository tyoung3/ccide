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

/* hcond.in */

#include <stdlib.h>
#include <stdio.h>

int Doit() {}
int DontDoit() {}
//CCIDE_INLINE_CODE:
main(){
	int S,T,U,V,B,C,D,E;

	/* 32 conditions and 32 actions. */
//DECISION_TABLE:
// 1 2 3 4 5 6 7 8  | S==$$
// 1 2 3 4 5 6 7 8  | T==$$
// 1 2 3 4 5 6 7 8  | U==$$
// 1 2 3 4 5 6 7 8  | V==$$
//-----------------
// - - - - - x - -  | Doit(); 
// - - - x - - - -  | DontDoit(); 
// 2 1 0 9 8 2 3 -  | B=$$;
// 1 2 3 4 5 6 7 8  | C=$$;
// 1 2 3 4 5 6 7 8  | D=$$;
// 1 2 3 4 5 6 7 8  | E=$$;
//END_TABLE:

	exit(0);
}
	/* End program */
