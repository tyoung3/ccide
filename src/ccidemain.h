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

/* ccidemain.h */ 

#ifndef _CCIDEMAIN__H
#define _CCIDEMAIN__H

// For Mingw Changes to ccideconfig.h ??? hacked up so will compile.
// Remove defines for rpl_malloc...
#ifndef HAVE_STRING_H
#define HAVE_STRING_H 1
#endif
/* Define to 1 if you have the `malloc' function. */
#ifndef HAVE_MALLOC
#define HAVE_MALLOC 1
#endif

/* Define to 1 if you have the <malloc.h> header file. */
#ifndef HAVE_MALLOC_H
#define HAVE_MALLOC_H 1
#endif

#include <stdlib.h>
#include "ccide.h"

#ifdef HAVE_ASSERT_H
#include <assert.h>
#else 
#undef assert
#define assert(N)
#endif 

#ifndef HAVE_FILENO
#undef fileno
#define fileno(X) 4
#endif


	/* ********************  Capacities *********************/
#define CCIDE_NCOND   32
#define CCIDE_NACTION 2048
#define CCIDE_NRULE   256

	/* ccide -s 263 | ccide dies otherwise */
#define MAX_SKELSIZE  248

	/* ********************  Shared defines *********************/

#define TRUE 1
#define FALSE 0

#define MAXPREFIX 30

#ifdef __uint32_t
typedef __uint32_t CCIDE_CONDVAR;
#else
typedef unsigned long int CCIDE_CONDVAR;
#endif

typedef void (*CCIDE_FUNCTION)(int); /* Function pointer type */
typedef int CCIDE_HANDLE;

#define BFRSIZE 4096
extern char bfr[BFRSIZE];

#define DISPLAY(M)				\
	if(yydebug) 				\
		fprintf(stderr,(const char*)"%s\n",#M)  /* Flawfinder: ignore */

/* Flawfinder: ignore */
#define ERROR3(F,A,B) sprintf(bfr,(const char*)F,A,B); 	\
	yyerror(bfr); 				\
        printf((const char*) "%s%sERROR: %s %s\n",	/* Flawfinder: ignore */	\
		lws, pComment, bfr, pEcomment);	\
	RC=1;

#define WARN3(F,A,B) sprintf(bfr,(const char*)F,A,B); 	\
	warning(bfr); 				\
        printf((const char*) "%s%sWARNING: %s %s\n",		\
		lws, pComment, bfr, pEcomment);	

	/* ********************  Macros *********************/

#define STRCAT(D,S) strncat(D,S, sizeof(D)-strlen(D)-strlen(S))

#ifdef HAVE_VALUES_H
 /* Returns a random integer, R, where 0<=R<=N */
#define Random(N) ( (int) ( ( (1.0 + N ) * rand() ) / ( 1.0 + RAND_MAX ) ) ) 

        /* Returns a random integer, R, where N<=R<=M */
#define Random2(N,M)  ( N + Random(M-N) )
#endif

extern int RC;

/* ccideinline.c */
void GenInLineCode();
int GenSkeleton(char *skelsize);

/* ********************  Shared Variables and Functions  *********************/

enum{ C, ASM, BASH, CC, VB, QB, BASIC, JAVA, CS, EX};
extern int lang;
extern char *slang;

void yyerror(const char *s);
void Usage();
void ShowCopyright();

/* ccideparsy.y */
extern int nbrcstubs;
extern int DupeActionIsAnError;

/* ccidemain.c */
extern char pPrefix[];
extern char pPrefixLc[];
extern char *svar1, *svar2, *qt1, *qt2;
extern int lsvar1, lsvar2,lqt1,lqt2;
extern char *lws;          /*  Leading White Space */
extern int nbrtables;
extern int ccide_newgroup;
extern int noinline;	   /* 1=do not generate inline code */
extern int m4out;	   /* 1=Generate M4 code instead of C code */
extern int donotgenerate;  /* 1=do not generate any code */
extern int notimestamp;    /* 1=do not generate timestamp 		*/
extern int uselocaltime;   /* 1=local time instead of UTC in timestamp 	*/
extern int checkequal;     /* 0=bypasss checking for '=' in cond stub. 	*/
extern int changequote;	   /* 1=issue m4 changequote macro 		*/
extern char bufs[4096];
extern char *M4Comment;	   /* // for C++ code, else CCIDE_COMMENT() 	*/
extern char *pComment;     /*  for C, // for C++, ... 			*/
extern char *pEcomment;    /*  for C, // for C++, ... 			*/

	/* Global Functions */
void ClearTable(void);
char *Strdup(const char *s);
char *ExpVar2(char *s);
void SetYes(int nrule, int ncond);
void SetNo(int nrule, int ncond);
void SetCSTUB(int ncond, char *cstub);
int SetCSTUBscan(int ncond, char *cstub);
int SetNumber(int nconds, int nrule, int n);
void SetAct(int nrule, int naction);
int SetANumber(int nactions, int nrule, int n);
void UnSetNumbers(void);
void SetASTUB(int n, char *stub);
int SetASTUBscan(int n, char *stub);
void SetASTUBhere(int nactions, char *c1);
void SetASTUB2(int nactions, char *c1, char *c2);
void SetASTUBn(int nactions, int nrules);
/*  obs. void SetCSTUB2(int ncond, char *c1, char *c2); */
void CcideCheckRules(int ndrop);
/* obs. int NoBitOn(int nrule, int n); */
void GenConds(int nconds, int nrules, int notable);
char *GetTimeStamp(void);
void Generate(int nconds, int nactions, int nrules);

void SaveLeadingWhiteSpace(char *s);
#endif

