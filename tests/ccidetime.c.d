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
/* THISIS: ccidetime */

#include <stdlib.h>

unsigned long count=0;
unsigned long max=1000;

//CCIDE_INLINE_CODE:

int main(int argc, char **argv) {

	if( argc>1 ) max = atol(argv[1]);

//DECISION_TABLE:
// N -		| count>max
//-----------------
// x -		| count++;
// 1 -		| NEWGROUP;
//END_TABLE:

	return 0;
}

#if 0
[tyoung3@baja ccide]$ time ./ccidetime 10000000

real    0m2.932s
user    0m1.420s
sys     0m0.020s

[tyoung3@baja ccide]$ ric
"main"
"add_f"
"Starting yyparse"
10000000/2.932

3410641

#endif 
