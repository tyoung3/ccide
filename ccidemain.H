/* ccidemain.H 
**
**  Copyright (c) 2002, Thomas W. Young, The CCIDE Project.
**  47 Mitchell Street
**  Stamford, CT 06902
**  All rights reserved.
**
**       ccide@twyoung.com
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

