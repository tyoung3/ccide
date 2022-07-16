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

/* THISIS: fourway.c.d 
**  Decision table program example. 
**
**  Usage: fourway fn1 fn2 fn3 fn4
**
**  Fourway reads the four, named text files (which are assumed to be
**  in sequence) and creates a merged file on stdout.
**
**  To build and test:
**	ccide < fourway.c.d > fourway.c
**      cc ${CFLAGS} -c fourway.c -o fourway.o
**	cc ${LFLAGS} fourway.o -o fourway
**	./fourway f1 f2 f3 f4
** 
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

/*  Number of files to merge: */
#define NWAY 4

#define KeyLow(M,N) ( strcmp(bfr[M],bfr[N]) < 1 )
#define LCL static void
#define BUFSIZE 4096
#define NS  NWAY+1

static FILE *File[NS];
static char *fname[NS];
static int state=0;
static char bfr[NS][BUFSIZE+1];

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

LCL OpenFiles() {
	int i;

	for( i=1;i<NS;i++) {
		File[i] = fopen(fname[i],"r");
		if( File[i] == NULL ) {
			fprintf(stderr,"Cannot open %s.\n", fname[i] );
		} else {
			state =  state ^ 1<<(i-1);
		}
	}
}

LCL ReadFile(int i) {

	assert(i>0);
	if( ( fgets( bfr[i], BUFSIZE, File[i] )  == NULL ) ) {  
		state = state ^ 1<<(i-1);
	}

}

LCL WriteFromFile(int i) {
	assert(i>0);
	printf( "%s", bfr[i] );
	ReadFile(i);
}

int main(int argc, char **argv) {
	int i;

	assert(NWAY<32);

	if( argc>NWAY ) {
		for( i=1; i<NS; i++ ) {
			fname[i] = argv[i];
		}
	} else {
		exit (0);  
	}

	OpenFiles(); 
        for( i=1; i<NS; i++ ) {
		ReadFile(i); 
        }

//DECISION_TABLE:   1 2 4 8
//  15 15 15 15 15 15 15 |state == $$
//   1  1  1  2  2  3  - |KeyLow($$,4)
//   1  1  -  2  -  -  - |KeyLow($$,3)
//   Y  -  -  -  -  -  - |KeyLow(1,2)
// _____________________________
//   1  2  3  2  3  3  4 |WriteFromFile($$);
//   X  X  X  X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//	7 Rules, 7 conditions, and 5 actions.
//	Table 1 rule order = 1 2 4 3 5 6 7 
 {	unsigned long CCIDE_table1_yes[7]={  83UL,  19UL,  37UL,   3UL,   5UL,   9UL,   1UL};
	ccide_group=1;

CCIDE_TABLE_1:
	switch(CCIDEFindRuleYes(7,
		  (state == 15)
		| (KeyLow(1,4))<<1
		| (KeyLow(2,4))<<2
		| (KeyLow(3,4))<<3
		| (KeyLow(1,3))<<4
		| (KeyLow(2,3))<<5
		| (KeyLow(1,2))<<6
		  ,CCIDE_table1_yes)) {
	case  6:	//	Rule  7 
	    WriteFromFile(4);
	    goto CCIDE_TABLE_1;
	case  3:	//	Rule  3 
	case  4:	//	Rule  5 
	case  5:	//	Rule  6 
	    WriteFromFile(3);
	    goto CCIDE_TABLE_1;
	case  1:	//	Rule  2 
	case  2:	//	Rule  4 
	    WriteFromFile(2);
	    goto CCIDE_TABLE_1;
	case  0:	//	Rule  1 
	    WriteFromFile(1);
	    goto CCIDE_TABLE_1;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0  

//DECISION_TABLE:   1 2 8
//  10 10 11 11 11 |state == $$
//   2  -  1  1  - |KeyLow($$,4)
//   -  -  Y  -  - |KeyLow(1,2)
// _______________________
//   2  4  1  2  4 |WriteFromFile($$); 
//   X  X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_2.
//	5 Rules, 5 conditions, and 4 actions.
//	Table 2 rule order = 3 1 4 2 5 
 {	unsigned long CCIDE_table2_yes[5]={  26UL,   5UL,  10UL,   1UL,   2UL};
	ccide_group=1;

CCIDE_TABLE_2:
	switch(CCIDEFindRuleYes(5,
		  (state == 10)
		| (state == 11)<<1
		| (KeyLow(2,4))<<2
		| (KeyLow(1,4))<<3
		| (KeyLow(1,2))<<4
		  ,CCIDE_table2_yes)) {
	case  0:	//	Rule  3 
	    WriteFromFile(1);
	    goto CCIDE_TABLE_2;
	case  3:	//	Rule  2 
	case  4:	//	Rule  5 
	    WriteFromFile(4);
	    goto CCIDE_TABLE_2;
	case  1:	//	Rule  1 
	case  2:	//	Rule  4 
	    WriteFromFile(2);
	    goto CCIDE_TABLE_2;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.7.0-0  

//DECISION_TABLE:   1 4 8
//   9  9 13 13 13 |state == $$
//   1  -  1  1  - |KeyLow($$,4)
//   -  -  Y  -  - |KeyLow(1,3)
// _______________________
//   1  4  1  3  4 |WriteFromFile($$); 
//   X  X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_3.
//	5 Rules, 4 conditions, and 4 actions.
//	Table 3 rule order = 3 1 4 2 5 
 {	unsigned long CCIDE_table3_yes[5]={  14UL,   5UL,   6UL,   1UL,   2UL};
	ccide_group=1;

CCIDE_TABLE_3:
	switch(CCIDEFindRuleYes(5,
		  (state == 9)
		| (state == 13)<<1
		| (KeyLow(1,4))<<2
		| (KeyLow(1,3))<<3
		  ,CCIDE_table3_yes)) {
	case  2:	//	Rule  4 
	    WriteFromFile(3);
	    goto CCIDE_TABLE_3;
	case  3:	//	Rule  2 
	case  4:	//	Rule  5 
	    WriteFromFile(4);
	    goto CCIDE_TABLE_3;
	case  0:	//	Rule  3 
	case  1:	//	Rule  1 
	    WriteFromFile(1);
	    goto CCIDE_TABLE_3;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_3, by ccide-0.7.0-0  

//DECISION_TABLE:   2 4 8
//   8 10 10 12 12 14 14 14 |state == $$
//   -  2  -  3  -  2  2  - |KeyLow($$,4)
//   -  -  -  -  -  Y  -  - |KeyLow(2,3)
// ______________________________
//   4  2  4  3  4  2  3  4 |WriteFromFile($$); 
//   X  X  X  X  X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_4.
//	8 Rules, 7 conditions, and 4 actions.
//	Table 4 rule order = 6 2 4 7 1 3 5 8 
 {	unsigned long CCIDE_table4_yes[8]={  88UL,  18UL,  36UL,  24UL,   1UL,   2UL,   4UL,   8UL};
	ccide_group=1;

CCIDE_TABLE_4:
	switch(CCIDEFindRuleYes(8,
		  (state == 8)
		| (state == 10)<<1
		| (state == 12)<<2
		| (state == 14)<<3
		| (KeyLow(2,4))<<4
		| (KeyLow(3,4))<<5
		| (KeyLow(2,3))<<6
		  ,CCIDE_table4_yes)) {
	case  2:	//	Rule  4 
	case  3:	//	Rule  7 
	    WriteFromFile(3);
	    goto CCIDE_TABLE_4;
	case  0:	//	Rule  6 
	case  1:	//	Rule  2 
	    WriteFromFile(2);
	    goto CCIDE_TABLE_4;
	case  4:	//	Rule  1 
	case  5:	//	Rule  3 
	case  6:	//	Rule  5 
	case  7:	//	Rule  8 
	    WriteFromFile(4);
	    goto CCIDE_TABLE_4;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_4, by ccide-0.7.0-0  

//DECISION_TABLE:  1 2 4
//   1  2  3  3  4  5  5  6  6  7  7  7 |state == $$
//   -  -  2  -  -  3  -  -  -  2  2  - |KeyLow($$,1)
//   -  -  -  -  -  -  -  Y  -  Y  -  - |KeyLow(2,3)
// ________________________________________________
//   1  2  2  1  3  3  1  2  3  2  3  1 |WriteFromFile($$); 
//   X  X  X  X  X  X  X  X  X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_5.
//	12 Rules, 10 conditions, and 4 actions.
//	Table 5 rule order = 10 3 6 8 11 1 2 4 5 7 9 12 
 {	unsigned long CCIDE_table5_yes[12]={ 704UL, 132UL, 272UL, 544UL, 192UL,   1UL,   2UL,   4UL,   8UL,  16UL,  32UL,  64UL};
	ccide_group=1;

CCIDE_TABLE_5:
	switch(CCIDEFindRuleYes(12,
		  (state == 1)
		| (state == 2)<<1
		| (state == 3)<<2
		| (state == 4)<<3
		| (state == 5)<<4
		| (state == 6)<<5
		| (state == 7)<<6
		| (KeyLow(2,1))<<7
		| (KeyLow(3,1))<<8
		| (KeyLow(2,3))<<9
		  ,CCIDE_table5_yes)) {
	case  2:	//	Rule  6 
	case  4:	//	Rule 11 
	case  8:	//	Rule  5 
	case 10:	//	Rule  9 
	    WriteFromFile(3);
	    goto CCIDE_TABLE_5;
	case  0:	//	Rule 10 
	case  1:	//	Rule  3 
	case  3:	//	Rule  8 
	case  6:	//	Rule  2 
	    WriteFromFile(2);
	    goto CCIDE_TABLE_5;
	case  5:	//	Rule  1 
	case  7:	//	Rule  4 
	case  9:	//	Rule  7 
	case 11:	//	Rule 12 
	    WriteFromFile(1);
	    goto CCIDE_TABLE_5;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_5, by ccide-0.7.0-0  

	assert(state == 0);
	return 0;
}

/* End of fourway.c.d */
