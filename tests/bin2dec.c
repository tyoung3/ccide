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
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.7.0-0
ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com 
The code generated by ccide is covered by the same license as the source  
code(decision table) from which it is derived. If you created the source,  
you are free to do anything you like with the generated code, 
including incorporating it into or linking it with proprietary software.  
*/ 
static int ccide_group=1; 
#ifndef UINT_MAX 
#include "limits.h" 
#endif /* End if not defined UINT_MAX */ 
 
		/* Return rule number */ 
static int CCIDEFindRule(
	int nbrrules,  unsigned long ccide_table, unsigned long yes[], unsigned long no[]){ 
        int r=0; 
        unsigned long nstate; 
 
        nstate = UINT_MAX ^ ccide_table; 
 
        while ( 
		( (yes[r] & nstate) || (no[r]  & ccide_table) ) 
		 && ( ++r < nbrrules )  
	) {}; 
 
        return r; 
} 
 
static int CCIDEFindRuleYes(             /* Return rule number */
	int nbrrules, unsigned long ccide_table, unsigned long yes[]) 
{ 
        int r=0; 
        unsigned long nstate;
 
        nstate = UINT_MAX ^ ccide_table; 
        while ( (yes[r] & nstate) && ( ++r < nbrrules ) ) {}; 
        return r; 
} 
#endif /* End ifndef  __CCIDE_INLINE_C  */
/*END_GENERATED_CODE: */

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
//   Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y  -  Y | binc[0] == '1'
//   Y  Y  -  -  Y  Y  -  -  Y  Y  -  -  Y  Y  -  -  Y  Y  -  -  Y  Y  -  -  Y  Y  -  -  Y  Y  - | binc[1] == '1'
//   Y  Y  Y  Y  -  -  -  -  Y  Y  Y  Y  -  -  -  -  Y  Y  Y  Y  -  -  -  -  Y  Y  Y  Y  -  -  - | binc[2] == '1'
//   Y  Y  Y  Y  Y  Y  Y  Y  -  -  -  -  -  -  -  -  Y  Y  Y  Y  Y  Y  Y  Y  -  -  -  -  -  -  - | binc[3] == '1'
//   Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | binc[4] == '1'
// _______________________________________________________________________________
//   X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X  -  X | dec += 16;
//   X  X  -  -  X  X  -  -  X  X  -  -  X  X  -  -  X  X  -  -  X  X  -  -  X  X  -  -  X  X  - | dec += 8;
//   X  X  X  X  -  -  -  -  X  X  X  X  -  -  -  -  X  X  X  X  -  -  -  -  X  X  X  X  -  -  - | dec += 4;
//   X  X  X  X  X  X  X  X  -  -  -  -  -  -  -  -  X  X  X  X  X  X  X  X  -  -  -  -  -  -  - | dec += 2; 
//   X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | dec += 1; 
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//	31 Rules, 5 conditions, and 5 actions.
//	Table 1 rule order = 1 17 9 5 3 2 25 21 13 19 11 7 18 10 6 4 29 27 23 15 26 22 14 20 12 8 31 30 28 24 16 
 {	unsigned long CCIDE_table1_yes[31]={  31UL,  15UL,  23UL,  27UL,  29UL,  30UL,   7UL,  11UL,  19UL,  13UL,  21UL,  25UL,  14UL,  22UL,  26UL,  28UL,   3UL,   5UL,   9UL,  17UL,   6UL,  10UL,  18UL,  12UL,  20UL,  24UL,   1UL,   2UL,   4UL,   8UL,  16UL};


	switch(CCIDEFindRuleYes(31,
		  (binc[0] == '1')
		| (binc[1] == '1')<<1
		| (binc[2] == '1')<<2
		| (binc[3] == '1')<<3
		| (binc[4] == '1')<<4
		  ,CCIDE_table1_yes)) {
	case  0:	//	Rule  1 
	    dec += 16;
	case  5:	//	Rule  2 
	    dec += 8;
	    goto CCIDE_case1_15;
	case  4:	//	Rule  3 
	    dec += 16;
	CCIDE_case1_15: case 15:	//	Rule  4 
	    dec += 4;
	    goto CCIDE_case1_25;
	case  3:	//	Rule  5 
	    dec += 16;
	case 14:	//	Rule  6 
	    dec += 8;
	    goto CCIDE_case1_25;
	case 11:	//	Rule  7 
	    dec += 16;
	CCIDE_case1_25: case 25:	//	Rule  8 
	    dec += 2;
	    goto CCIDE_case1_30;
	case  2:	//	Rule  9 
	    dec += 16;
	case 13:	//	Rule 10 
	    dec += 8;
	    goto CCIDE_case1_24;
	case 10:	//	Rule 11 
	    dec += 16;
	CCIDE_case1_24: case 24:	//	Rule 12 
	    dec += 4;
	    goto CCIDE_case1_30;
	case  8:	//	Rule 13 
	    dec += 16;
	case 22:	//	Rule 14 
	    dec += 8;
	    goto CCIDE_case1_30;
	case 19:	//	Rule 15 
	    dec += 16;
	CCIDE_case1_30: case 30:	//	Rule 16 
	    dec += 1;
	    break;
	case  1:	//	Rule 17 
	    dec += 16;
	case 12:	//	Rule 18 
	    dec += 8;
	    goto CCIDE_case1_23;
	case  9:	//	Rule 19 
	    dec += 16;
	CCIDE_case1_23: case 23:	//	Rule 20 
	    dec += 4;
	    goto CCIDE_case1_29;
	case  7:	//	Rule 21 
	    dec += 16;
	case 21:	//	Rule 22 
	    dec += 8;
	    goto CCIDE_case1_29;
	case 18:	//	Rule 23 
	    dec += 16;
	CCIDE_case1_29: case 29:	//	Rule 24 
	    dec += 2;
	    break;
	case  6:	//	Rule 25 
	    dec += 16;
	case 20:	//	Rule 26 
	    dec += 8;
	    goto CCIDE_case1_28;
	case 17:	//	Rule 27 
	    dec += 16;
	CCIDE_case1_28: case 28:	//	Rule 28 
	    dec += 4;
	    break;
	case 16:	//	Rule 29 
	    dec += 16;
	case 27:	//	Rule 30 
	    dec += 8;
	    break;
	case 26:	//	Rule 31 
	    dec += 16;
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0  
	printf("%s > %li\n", binc, dec);

	return 0;
}


/* End of bin2dec.in */
