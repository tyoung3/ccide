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

/*  THISIS: bin2dec  

**  Test ccide

**  Usage: bin2dec BIN

 
 Use binary number "bbbbb"  to set conditions. 
 Use decision table to decode and print decimal number. 
 verify w/dec2bin function.

**
**  Copyright (c) 2002-2004,2010,2012 Thomas W. Young, The CCIDE Project, e-mail ccide@twyoung.com
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#define LCL static void
#define BUFSIZE 4096
#define NBIT 2

//CCIDE_INLINE_CODE:

#define MAXBINC 32

int main(int argc, char **argv) {
	char *binc;
	long dec;

	if( argc>1 ) {
		binc = argv[1]; 
	} else {
		binc = "10101";
//		fprintf(stderr,"Usage: bin2dec BINARY_NUMBER");
//		exit(1);
	}
	dec = 0;
//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
//DECISION_TABLE:
// Y - Y - Y - Y - Y - Y - Y - Y - Y - Y - Y - Y - Y - Y - Y - Y  | binc[0] == '1'
// Y Y - - Y Y - - Y Y - - Y Y - - Y Y - - Y Y - - Y Y - - Y Y -  | binc[1] == '1'
// Y Y Y Y - - - - Y Y Y Y - - - - Y Y Y Y - - - - Y Y Y Y - - -  | binc[2] == '1'
// Y Y Y Y Y Y Y Y - - - - - - - - Y Y Y Y Y Y Y Y - - - - - - -  | binc[3] == '1'
// Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y - - - - - - - - - - - - - - -  | binc[4] == '1'
// _______________________________________________________________________________
// X - X - X - X - X - X - X - X - X - X - X - X - X - X - X - X  | dec += 16;
// X X - - X X - - X X - - X X - - X X - - X X - - X X - - X X -  | dec += 8;
// X X X X - - - - X X X X - - - - X X X X - - - - X X X X - - -  | dec += 4;
// X X X X X X X X - - - - - - - - X X X X X X X X - - - - - - -  | dec += 2; 
// X X X X X X X X X X X X X X X X - - - - - - - - - - - - - - -  | dec += 1; 
//END_TABLE:
	printf("%s > %li\n", binc, dec);

	return 0;
}


/* End of bin2dec.in */
