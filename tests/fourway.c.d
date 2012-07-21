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
//   x  x  x  x  x  x  x |NEWGROUP 
//END_TABLE:

//DECISION_TABLE:   1 2 8
// 10 10 11 11 11 |state == $$
//  2  -  1  1  - |KeyLow($$,4)
//  -  -  Y  -  - |KeyLow(1,2)
// _______________________
//  2  4  1  2  4 |WriteFromFile($$); 
//  x  x  x  x  x |NEWGROUP
//END_TABLE:

//DECISION_TABLE:   1 4 8
// 9 9 13 13 13 |state == $$
// 1 -  1  1  - |KeyLow($$,4)
// - -  Y  -  - |KeyLow(1,3)
// _______________________
// 1 4  1  3  4 |WriteFromFile($$); 
// x x  x  x  x |NEWGROUP
//END_TABLE:

//DECISION_TABLE:   2 4 8
// 8 10 10 12 12 14 14 14 |state == $$
// -  2  -  3  -  2  2  - |KeyLow($$,4)
// -  -  -  -  -  Y  -  - |KeyLow(2,3)
// ______________________________
// 4  2  4  3  4  2  3  4 |WriteFromFile($$); 
// x  x  x  x  x  x  x  x |NEWGROUP
//END_TABLE:

//DECISION_TABLE:  1 2 4
// 1 2 3 3 4 5 5 6 6 7 7 7 |state == $$
// - - 2 - - 3 - - - 2 2 - |KeyLow($$,1)
// - - - - - - - Y - Y - - |KeyLow(2,3)
// ________________________________________________
// 1 2 2 1 3 3 1 2 3 2 3 1 |WriteFromFile($$); 
// x x x x x x x x x x x x |NEWGROUP
//END_TABLE:

	assert(state == 0);
	return 0;
}

/* End of fourway.c.d */
