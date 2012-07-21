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
//  7 7 7 7 |state == $$
//  Y Y - - |KeyLow(1,2)
//  Y - - - |KeyLow(1,3)
//  - - N - |KeyLow(2,3)
//  -------  -----------
//  1 3 3 2 |WriteFromFile($$);
//  1 3 3 2 |ReadFile($$);  
//  x x x x |NEWGROUP
//END_TABLE:

//DECISION_TABLE:
// - - Y - - - - - - |KeyLow(1,2)
// - - - - - Y - - - |KeyLow(1,3)
// - - - - - - - Y - |KeyLow(2,3)
// 1 2 3 3 4 5 5 6 6 |state == $$
//-------------------------------------
// 1 2 1 2 3 1 3 2 3 |WriteFromFile($$);
// 1 2 1 2 3 1 3 2 3 |ReadFile($$);
// x x x x x x x x x |NEWGROUP
//END_TABLE:

	assert(state == 0);
	return 0;
}

/* End of threeway.in */
