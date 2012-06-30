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

#include "ccide.h"
#include <stdlib.h>

#ifndef HAVE_ASSERT_H
#define assert(N)
#else 
#include <assert.h>
#endif 

	/* ********************  Capacities *********************/
#define CCIDE_NCOND   32
#define CCIDE_NACTION 32
#define CCIDE_NRULE   32
#define CCIDE_NTABLE  100

	/* ********************  Shared defines *********************/
typedef unsigned int CCIDE_CONDVAR;
typedef void (*CCIDE_FUNCTION)(int); /* Function pointer type */
typedef int CCIDE_HANDLE;

#define BFRSIZE 4096
char bfr[4096];

/* Flawfinder: ignore */
#define ERROR3(F,A,B) sprintf(bfr,(const char*)F,A,B); yyerror(bfr); \
        printf((const char*)"//ERROR: %s\n",bfr);   /* Flawfinder: ignore */


	/* ********************  Macros *********************/

#ifdef HAVE_VALUES_H
 /* Returns a random integer, R, where 0<=R<=N */
#define Random(N) ( (int) ( ( (1.0 + N ) * rand() ) / ( 1.0 + RAND_MAX ) ) ) 

        /* Returns a random integer, R, where N<=R<=M */
#define Random2(N,M)  ( N + Random(M-N) )
#endif


extern int RC;

void GenInLineCode();

/* ********************  Shared Variables and Functions  *********************/
void yyerror(const char *s);

