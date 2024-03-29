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

/*  THISIS: threeway.c.d 
** 	Decision table program example. 
**
**  Usage: threeway fn1 fn2 fn3
**
**  Threeway reads the three, named text files (which are assumed to be
**  in sequence) and creates a merged file on stdout.  /dev/null may be
**  used as a filename. 
**
**  To build and test:
**	ccide < threeway.in > threeway.c
**	make threeway
**	./threeway f1 f2 f3
** 
**  Covered by GNU Public License, GPL.   See file COPYING
**  for copy requirements.
**
**  
**  Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
**
**  TODO:
**	Sequence check all input files.
*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>

#define KeyLow(M,N) ( strcmp(bfr[M],bfr[N]) < 1 )
#define LCL static void
#define BUFSIZE 4096
#define NS 4

static FILE *File[NS];
static char *fname[NS];
static int state=0;
static char bfr[NS][BUFSIZE+1];

/* To avoid linkedit clashes, only one module in a program should 
** contain the CCIDE_INLINE_CODE statement. 
** The following statement will cause ccide to generate rule lookup code, 
** unless ccide is invoked with the '-n' option. 
**/
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
	/* ccide should ignore this extra //CCIDE_INLINE_CODE: statement.*/
//CCIDE_INLINE_CODE:

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

LCL WriteFromFile(int i) {
	assert(i>0);
	printf( "%s", bfr[i] );
}

LCL ReadFile(int i) {

	assert(i>0);
	if( ( fgets( bfr[i], BUFSIZE, File[i] )  == NULL ) ) {  
		state = state ^ 1<<(i-1);
	}

}

int main(int argc, char **argv) {

	assert( UINT_MAX == 4294967295UL);
	if( argc>3 ) {
		fname[1] = argv[1];
		fname[2] = argv[2];
		fname[3] = argv[3];
	} else {
		exit(0);
		fprintf(stderr,"Usage: ccide fn1 fn2 fn3");
		exit(1);
	}

	OpenFiles(); ReadFile(1); ReadFile(2); ReadFile(3); 

//DECISION_TABLE:
//   7  7  7  7 |state == $$
//   Y  Y  -  - |KeyLow(1,2)
//   Y  -  -  - |KeyLow(1,3)
//   -  -  N  - |KeyLow(2,3)
//  -------  -----------
//   1  3  3  2 |WriteFromFile($$);
//   1  3  3  2 |ReadFile($$);  
//   X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//	4 Rules, 4 conditions, and 7 actions.
//	Table 1 rule order = 1 2 3 4 
 {	unsigned long CCIDE_table1_yes[4]={   7UL,   3UL,   1UL,   1UL};
	unsigned long CCIDE_table1_no[4]= {   0UL,   0UL,   8UL,   0UL};
	ccide_group=1;

CCIDE_TABLE_1:
	switch(CCIDEFindRule(4,
		  (state == 7)
		| (KeyLow(1,2))<<1
		| (KeyLow(1,3))<<2
		| (KeyLow(2,3))<<3
		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
	case  3:	//	Rule  4 
	    WriteFromFile(2);
	    ReadFile(2);
	    goto CCIDE_TABLE_1;
	case  1:	//	Rule  2 
	case  2:	//	Rule  3 
	    WriteFromFile(3);
	    ReadFile(3);
	    goto CCIDE_TABLE_1;
	case  0:	//	Rule  1 
	    WriteFromFile(1);
	    ReadFile(1);
	    goto CCIDE_TABLE_1;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0  

//DECISION_TABLE:
//   -  -  Y  -  -  -  -  -  - |KeyLow(1,2)
//   -  -  -  -  -  Y  -  -  - |KeyLow(1,3)
//   -  -  -  -  -  -  -  Y  - |KeyLow(2,3)
//   1  2  3  3  4  5  5  6  6 |state == $$
//-------------------------------------
//   1  2  1  2  3  1  3  2  3 |WriteFromFile($$);
//   1  2  1  2  3  1  3  2  3 |ReadFile($$);
//   X  X  X  X  X  X  X  X  X |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_2.
//	9 Rules, 9 conditions, and 7 actions.
//	Table 2 rule order = 3 6 8 1 2 4 5 7 9 
 {	unsigned long CCIDE_table2_yes[9]={  33UL, 130UL, 260UL,   8UL,  16UL,  32UL,  64UL, 128UL, 256UL};
	ccide_group=1;

CCIDE_TABLE_2:
	switch(CCIDEFindRuleYes(9,
		  (KeyLow(1,2))
		| (KeyLow(1,3))<<1
		| (KeyLow(2,3))<<2
		| (state == 1)<<3
		| (state == 2)<<4
		| (state == 3)<<5
		| (state == 4)<<6
		| (state == 5)<<7
		| (state == 6)<<8
		  ,CCIDE_table2_yes)) {
	case  6:	//	Rule  5 
	case  7:	//	Rule  7 
	case  8:	//	Rule  9 
	    WriteFromFile(3);
	    ReadFile(3);
	    goto CCIDE_TABLE_2;
	case  2:	//	Rule  8 
	case  4:	//	Rule  2 
	case  5:	//	Rule  4 
	    WriteFromFile(2);
	    ReadFile(2);
	    goto CCIDE_TABLE_2;
	case  0:	//	Rule  3 
	case  1:	//	Rule  6 
	case  3:	//	Rule  1 
	    WriteFromFile(1);
	    ReadFile(1);
	    goto CCIDE_TABLE_2;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.7.0-0  

	assert(state == 0);
	return 0;
}

/* End of threeway.in */
