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


/** file ccide.y decision table Yacc Parser */

%{    /* {(  

**   Decision table compiler  twy 5/9/2002
*/

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


#define twy
#define PARSE_STRING_SIZE 4096

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>
#include "ccidemain.h"

	/* Maximum argument string length. */
#define MAXARG 40

static char ctbl[10];
static char xs[81];
static char *xstring=xs;    /* For adding a new rule  */

int substitute=0;       /* 1 - If substitution in row */
int RC=0;		/* main() Return Code */

/* static CCIDE_HANDLE handle; */
static int nrules=0;   /* Number of rules */
static int nbrrules=0;   /* Number of rules */
static int nconds=0;   /* Number of condition statements */

int nactions=0;   /* Number of actions */
int DupeActionIsAnError=1;    /* 0=allow duplicate actions. */

void yyerror( const char *s);
int yylex( void );
void warning2( char *s, char *t);

#undef  LOGE
#undef  LOGP
#undef  syslog		/* Flawfinder: ignore */
#define syslog fprintf	/* Flawfinder: ignore */
#define LOGE   stderr
#define LOGP   stderr

#define YYDEBUG  1     /* Move 1 to yydebug to debug */ 
#define MAXTOKEN 1024

/* #include "cmbt.h"   data declarations, function prototypes */

#define EOL '\n'
#define EOS '\0'

void fatal(char *s);
static int columnsize=3;
// static int skelsize=1; 		/* Size of skeleton decision table */
static void SetNbrRules(int n);
static void PrintC(char c);
static inline long int max( long int a, long int b);
static void PrintNum(long int n);
static char pGroup[100];
static int logCond=FALSE;

char *StripTrail(char *s) {
	int l;
	char *s1;

	l = strlen(s);
	s1=s+l-1;
	while(l-- && ( 
			(*s1 == ' ')  
			     ||
			(*s1 == '\t')  
		   )
	     ) { 
		*s1-- = 0; 
	}
	return s;
}

%}

%union {		/* stack object type	*/
    long int  ival;	/* integer value	*/
    char    *string;	/* A STRING:  "....."  */
    char    *sym;	/* A STRING:  "....."  */
}


  /*  Symbol table identifier classes */

	/* This must be first */
%left   <ival>   YES
%left   <ival>   NO DONT_CARE ACT
%left   <ival>   NUMBER 
%left   <string> PSTUB 

%type	<ival> 	 act cond

%token  TEND NEWGROUP START_ACTIONS TSTART
/*  %token  PARSE_ERROR  */

%expect 0 /* shift/reduce conflicts */
%start DECISION_TABLE  /* Primary Rule to be satisfied */

/* Define before use */

%%

cond:  	  YES {
		SetYes( nrules, nconds );
		assert(substitute == 0);
		logCond = TRUE;
		$$=YES;
	} 
	| NO    {
		assert(substitute == 0);
		SetNo( nrules, nconds );
		logCond = TRUE;
		$$=NO;
	}
	| DONT_CARE {$$=DONT_CARE;}
	;

conds:    /* Null */ 
	| conds cond   {  
		assert( $2 >= YES );
		PrintC(ctbl[$2-YES]);
		nrules++; 
	} 
	| conds NUMBER {  
		substitute = SetNumber(nconds, nrules, $2);
		PrintNum( (long) $2);
		logCond = TRUE;
		nrules++; 
	};

act:  ACT {
		/* printf(" "); */
		SetAct( nrules, nactions );
		$$ = ACT; 
	} 
	| DONT_CARE {$$ = DONT_CARE;} 
	;

actions:   /* Null */ 
	| actions act    { 
		assert( $2 >= YES );
		PrintC(  ctbl[$2 - YES]);
		nrules++; 
	}
	| actions NUMBER { 
		substitute = SetANumber(nactions, nrules, $2);
		PrintNum( (long) $2); 
		nrules++; 
	}
	;

condition_statement: conds PSTUB {
		printf(" %s|%s%s", xstring, $2, pEcomment);
	    if(logCond) {
		nconds+=SetCSTUBscan( nconds, StripTrail($2) );
		logCond = FALSE;
	    }	
	    SetNbrRules(nrules);
	    substitute=0; 
	}
	| conds NEWGROUP {
		printf(" %s|NEWGROUP\t\t%s", xstring, pEcomment);
	    if(logCond) {
		if(lang==EX)
			sprintf(pGroup, "%s_group = $$", pPrefixLc);
		else
			sprintf(pGroup, "%s_group == $$", pPrefixLc);
		nconds+=SetCSTUBscan( nconds, pGroup );
		logCond = FALSE;
	    }
	    SetNbrRules(nrules);
	    substitute=0; 
	};

action_statement:  
	actions NEWGROUP {
		ccide_newgroup=1;
		printf(" %s|NEWGROUP\t\t%s", xstring,  pEcomment);
		SetASTUBn( nactions, nrules );
		SetNbrRules(nrules);
		nactions += (substitute+1);
		substitute=0;
	}
	|
	actions PSTUB {
		printf(" %s|%s%s", xstring, $2,pEcomment);
		nactions += SetASTUBscan( nactions, ExpVar2(StripTrail($2)) );
		substitute=0;
		SetNbrRules(nrules);
	};

condition_statements:  /* nothing */
	| condition_statements condition_statement
	;

action_statements:  /* nothing */
	| action_statements action_statement
	;

start:	TSTART {
	UnSetNumbers();
	};

end:	TEND {
	  if(nbrrules > CCIDE_NRULE) {
		/* yyerror( "Excessive number of rules.");  */
		ERROR3("%i exceeds the maximum number of rules  %i.", 
			 nbrrules, CCIDE_NRULE);
		nbrrules = CCIDE_NRULE;
	  }
	  if(nactions > CCIDE_NACTION) {
		/* yyerror( "Excessive number of actions.");  */
		ERROR3("%i exceeds the maximum number of actions %i.", 
			 nactions, CCIDE_NACTION);
		nactions = CCIDE_NACTION;
	  }
	  if(nconds > CCIDE_NCOND) {
		/* yyerror( "Excessive number of conditions.");  */
		ERROR3("%i exceeds the maximum number of conditions %i.", 
			 nconds, CCIDE_NCOND);
		nconds = CCIDE_NCOND;
	  }
	  Generate(nconds, nactions, nbrrules );
	  nbrcstubs = nbrrules = nactions = nconds=0;
	  ClearTable();
	  nbrtables++;
	};

DECISION_TABLE:  /* Nothing */
	| DECISION_TABLE start condition_statements START_ACTIONS action_statements end
	;
%%

/*  ---------------   */

char *progname ;
int lineno = 0 ;

/*  ---------------   */

/*
** #ifndef  twy
** int yylex( void ) {
**        int c;
** 
**     c = lex();
**     return c;
** }
** #endif
*/
/*  ---------------   */

/*-------------------------------------------------------------------
**  WARNING
*/
void warning2( char *s, char *t)
{
    syslog( LOGP, "%s: %s", progname, s) ;

    if (t)
	syslog( LOGP, " %s", t) ;

    syslog( LOGP, " near line %d\n", lineno) ;
}

	/* ?? Move this to ...?.h  */
#ifndef UINT_MAX
#include <limits.h>
#endif

static void SetNbrRules(int n) {

	DISPLAY(SetNbrRules);
	if( nbrrules == 0 ) {
		nbrrules=n;
	} else {
		if( nbrrules != n ) {
			/* yyerror( "Inconsistent number of rules."); */
			ERROR3("%i rules, instead of %i.", 
				n, nbrrules);
		}
	}

	nrules=0;
	DISPLAY(End SetNbrRules);
}

	/* Set Prefix */
static void SetPrefix(char *s) {
	char *s1;
	const char *const_1={"Prefix longer than 30 bytes."};
	if(strlen(s) > 30) {
		fprintf(stderr,const_1);
		return;
	}

	s1 = s;
	
	while(*s1) {
		if(  
			 ( (*s1 >= '0') && (*s1 <= '9') )
					||
			 ( (*s1 >= 'a') && (*s1 <= 'z') )
					||
			 ( (*s1 >= 'A') && (*s1 <= 'Z') )
					||
			 	   (*s1 == '_')
		  ) { 
			s1++;
		} else {
			fprintf(stderr,"Prefix contains illegal characters bytes.");
			return;
		}
	}

	pPrefix = s;
	pPrefixLc = s1 = Strdup(s);
	
	while(*s1) {	
		*s1 = tolower(*s1);
		s1++;
	}
}

	/* Set Column size */
static void SetColumn(char *s) {
	
	columnsize=atoi(s);
	if(columnsize > 4)
		columnsize = 4;
}


int DelimitCheck(char *s1, char *s2) {
	if( strcmp(s1,s2) == 0 ) {
		fprintf(stderr,"CCIDE/FATAL: Delimiter %s cannot equal a QUOTE=(%s,%s) or a SUBSTITUTION=(%s,%s) \n",
			s1,qt1,qt2,svar1,svar2); 
		return 1;
	}
	return 0;
}

	/* Check delimiters */
static int DelimitEq(char *s1, char *s2) {

	if( (s1==NULL) || (s2==NULL) ) {
		fprintf(stderr,"NULL Delimiter\n"); 
		return 1;
	}

	if (
		DelimitCheck(s1,s2)
		|| DelimitCheck(s1,svar1)
		|| DelimitCheck(s2,svar2)
		|| DelimitCheck(s1,qt1)
		|| DelimitCheck(s2,qt2)
	)
 		return 1;

	return 0;
}

	/* Set stub substition strings. */
static void SetDelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	svar1=s1; 
	lsvar1=strlen(s1);
	lsvar2=strlen(s2);
	svar2=s2;
}

	/* Set m4 delimiters */
static void SetQdelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	qt1=s1; 
	lqt1=strlen(s1);
	lqt2=strlen(s2);
	qt2=s2;
	changequote=1;
}


	/* Set computer language */
static void SetLang(char *s) {

        //DECISION_TABLE:
        //   N  -  -  -  -  -  -  -  Y  -  -  - | strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0
        //   N  -  -  -  -  -  -  -  -  -  -  - | strcmp(s,"CC")==0    || strcmp(s,"cc")==0
        //   N  -  -  -  -  -  -  -  -  -  -  - | strcmp(s,"C++")==0   || strcmp(s,"c++")==0
        //   N  -  Y  -  -  -  -  -  -  -  -  - | strcmp(s,"BASH")==0
        //   N  -  -  Y  -  -  -  -  -  -  -  - | strcmp(s,"bash")==0
        //   N  -  -  -  Y  -  -  -  -  -  -  - | strcmp(s,"QB")==0
        //   N  -  -  -  -  Y  -  -  -  -  -  - | strcmp(s,"qb")==0
        //   N  -  -  -  -  -  -  -  -  -  -  Y | strcmp(s,"cs")==0   || strcmp(s,"CS")==0 || strcmp(s,"C#")==0 
        //   N  -  -  -  -  -  -  -  -  -  Y  - | strcmp(s,"JAVA")==0 || strcmp(s,"java")==0
        //   N  -  -  -  -  -  Y  -  -  -  -  - | strcmp(s,"VB")==0   || strcmp(s,"vb")==0
        //   N  -  -  -  -  -  -  Y  -  -  -  - | (strcmp(s,"EX")==0) || (strcmp(s,"ex")==0)
        //   N  -  -  -  -  -  -  -  -  Y  -  - | strcmp(s,"C")==0     || strcmp(s,"c")==0
        //  _______________________ |_________________________ ___________________
        //   -  X  -  -  -  -  -  -  -  -  -  - | printf("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n", s); Usage();
        //   -  -  X  X  -  -  -  -  -  -  -  - | lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");
        //   -  -  -  -  X  X  -  -  -  -  -  - | lang=QB; 
        //   -  -  -  -  -  -  X  -  -  -  -  - | lang=VB; 
        //   -  -  -  -  -  -  -  X  -  -  -  - | lang=EX;	 // euphoria 
        //   -  -  -  -  -  -  -  -  X  -  -  - | lang=BASIC; 
        //   -  -  -  -  -  -  -  -  -  -  X  - | lang=JAVA; 
        //   -  -  -  -  -  -  -  -  -  -  -  X | lang=CS;  
        //   X  -  -  -  -  -  -  X  -  -  X  X | SetQdelimit("`","\'");     
        //   X  -  X  X  X  X  X  X  X  -  X  - | m4out=1; pComment="CCIDE_COMMENT(";pEcomment=")";
        //END_TABLE:
        //GENERATED_CODE: FOR TABLE_1.
        //	12 Rules, 12 conditions, and 10 actions.
        //	Table 1 rule order = 1 9 3 4 5 6 12 11 7 8 10 2 
         {	unsigned long CCIDE_table1_yes[12]={   0UL,   1UL,   8UL,  16UL,  32UL,  64UL, 128UL, 256UL, 512UL,1024UL,2048UL,   0UL};
        	unsigned long CCIDE_table1_no[12]= {4095UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL};


        	switch(CCIDEFindRule(12,
        		  (strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0)
        		| (strcmp(s,"CC")==0    || strcmp(s,"cc")==0)<<1
        		| (strcmp(s,"C++")==0   || strcmp(s,"c++")==0)<<2
        		| (strcmp(s,"BASH")==0)<<3
        		| (strcmp(s,"bash")==0)<<4
        		| (strcmp(s,"QB")==0)<<5
        		| (strcmp(s,"qb")==0)<<6
        		| (strcmp(s,"cs")==0   || strcmp(s,"CS")==0 || strcmp(s,"C#")==0)<<7
        		| (strcmp(s,"JAVA")==0 || strcmp(s,"java")==0)<<8
        		| (strcmp(s,"VB")==0   || strcmp(s,"vb")==0)<<9
        		| ((strcmp(s,"EX")==0) || (strcmp(s,"ex")==0))<<10
        		| (strcmp(s,"C")==0     || strcmp(s,"c")==0)<<11
        		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
        	case  7:	//	Rule 11 
        	    lang=JAVA;
        	    goto CCIDE_case1_0;
        	case  9:	//	Rule  8 
        	    lang=EX;	 // euphoria
        	CCIDE_case1_0: case  0:	//	Rule  1 
        	    SetQdelimit("`","\'");
        	    m4out=1; pComment="CCIDE_COMMENT(";pEcomment=")";
        	    break;
        	case  1:	//	Rule  9 
        	    lang=BASIC;
        	    m4out=1; pComment="CCIDE_COMMENT(";pEcomment=")";
        	    break;
        	case  8:	//	Rule  7 
        	    lang=VB;
        	    m4out=1; pComment="CCIDE_COMMENT(";pEcomment=")";
        	    break;
        	case  4:	//	Rule  5 
        	case  5:	//	Rule  6 
        	    lang=QB;
        	    m4out=1; pComment="CCIDE_COMMENT(";pEcomment=")";
        	    break;
        	case  2:	//	Rule  3 
        	case  3:	//	Rule  4 
        	    lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");
        	    m4out=1; pComment="CCIDE_COMMENT(";pEcomment=")";
        	    break;
        	case  6:	//	Rule 12 
        	    lang=CS;
        	    SetQdelimit("`","\'");
        	    break;
        	case 11:	//	Rule  2 
        	    printf("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n", s); Usage();
        	    break;
        	case 10:	//	Rule 10 
        	    break;
        	} // End Switch
        }
        //END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.2-7 Thu Aug  2 15:00:34 2012 


}

static void PrintC(char c) {
	//DECISION_TABLE:
	//   1  3  4  5  6  - | columnsize==$$
	// ------------ | --------------
	//   X  -  -  -  -  - | printf("%c",c);
	//   -  -  -  -  -  X | printf(" %c",c);
	//   -  X  -  -  -  - | printf("  %c",c);
	//   -  -  X  -  -  - | printf("   %c",c);
	//   -  -  -  X  -  - | printf("    %c",c);
	//   -  -  -  -  X  - | printf("     %c",c);
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_2.
	//	6 Rules, 5 conditions, and 6 actions.
	 { CCIDE_TABLE_2: switch(columnsize) {	
		case 6:		//  Rule  5  
		    printf("     %c",c);
		    break;
		case 5:		//  Rule  4  
		    printf("    %c",c);
		    break;
		case 4:		//  Rule  3  
		    printf("   %c",c);
		    break;
		case 3:		//  Rule  2  
		    printf("  %c",c);
		    break;
		case 1:		//  Rule  1  
		    printf("%c",c);
		    break;
		 default:		//  Rule  6  
		    printf(" %c",c);
		    break;
	 }
	}
	//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.6.2-7 Thu Aug  2 15:00:34 2012 




}

static inline long int max( long int a, long int b) {

	if( b > a) 
		return b;
	return a;
}

static void PrintNum(long n) {

	//DECISION_TABLE:
	//   2  3  4  5  -  -  -  -  - | columnsize==$$
	//   Y  -  -  -  Y  N  N  N  N | n<10
	//   -  Y  -  -  N  Y  N  N  N | n<100
	//   -  -  Y  -  -  -  Y  N  N | n<1000
	//   -  -  -  Y  -  -  -  Y  N | n<10000
	// -------------------| ------
	//   2  3  4  5  2  3  4  5  6 | printf("%$$li", n);
	//END_TABLE:     
	//GENERATED_CODE: FOR TABLE_3.
	//	9 Rules, 8 conditions, and 5 actions.
	//	Table 3 rule order = 8 9 7 1 2 5 6 3 4 
	 {	unsigned long CCIDE_table3_yes[9]={ 128UL,   0UL,  64UL,  17UL,  34UL,  16UL,  32UL,  68UL, 136UL};
		unsigned long CCIDE_table3_no[9]= { 112UL, 240UL,  48UL,   0UL,   0UL,  32UL,  16UL,   0UL,   0UL};


		switch(CCIDEFindRule(9,
			  (columnsize==2)
			| (columnsize==3)<<1
			| (columnsize==4)<<2
			| (columnsize==5)<<3
			| (n<10)<<4
			| (n<100)<<5
			| (n<1000)<<6
			| (n<10000)<<7
			  ,CCIDE_table3_yes, CCIDE_table3_no)) {
		case  1:	//	Rule  9 
		    printf("%6li", n);
		    break;
		case  0:	//	Rule  8 
		case  8:	//	Rule  4 
		    printf("%5li", n);
		    break;
		case  2:	//	Rule  7 
		case  7:	//	Rule  3 
		    printf("%4li", n);
		    break;
		case  4:	//	Rule  2 
		case  6:	//	Rule  6 
		    printf("%3li", n);
		    break;
		case  3:	//	Rule  1 
		case  5:	//	Rule  5 
		    printf("%2li", n);
		    break;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_3, by ccide-0.6.2-7 Thu Aug  2 15:00:34 2012 




}

#define Argis(P) strcmp( #P, argv[narg]) == 0 

int main( int argc, char **argv) {
	int narg=1;
	char *s1;
	int ls1;

        assert( UINT_MAX == 4294967295UL);
	lws = Strdup("");

    while( argc>narg ) { 
	s1=argv[narg]; ls1=0;
	while(*s1 && ( ls1 < MAXARG ) ) {
		s1++; ls1++;
		if( *s1 == '|') {
			*s1 = '.';
		}
	}

	if( ls1 >= MAXARG) {
		argv[narg+MAXARG] = 0;
		fprintf(stderr, "Parameter %i is too long.\n", narg);
		exit(1);
	}

  	//DECISION_TABLE:
  	//   -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  - | Argis(-a)
  	//   Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-b)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  - | Argis(-c)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  - | Argis(-d)
  	//   -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-l)
  	//   -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  - | Argis(-L)
  	//   -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  -  - | Argis(-e)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  - | Argis(-m4)
  	//   -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-n)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y | Argis(-p)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  - | Argis(-q)
  	//   -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-s)
  	//   -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-t)
  	//   -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  - | Argis(-u)
  	//   -  -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  - | Argis(-V)
  	//   -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  - | Argis(-x)
  	//  _________________________________ | _________
  	//   X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | notimestamp=1;
  	//   -  X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | uselocaltime=1;
  	//   -  -  X  -  -  X  -  -  -  -  -  -  -  -  -  -  - | noinline=1;
  	//   -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  - | if(GenSkeleton(argv[narg+1])) narg++;
  	//   -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  - | yydebug=1;
  	//   -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  - | donotgenerate=1;
  	//   -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  - | ShowCopyright(); 
  	//   -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  - | Usage();
  	//   -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  - | checkequal=0;     // Do Not check for '='.
  	//   -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  - | strcat(xstring, "- ");
  	//   -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  - | DupeActionIsAnError=0;
  	//   -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  - | SetLang(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  - | SetColumn(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  - | m4out=1; pComment="CCIDE_COMMENT()";pEcomment="";
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  - | SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  - | SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X | SetPrefix(argv[narg+1]); narg++;
  	//   -  -  -  X  -  -  X  X  -  -  -  -  -  -  -  -  - | exit(0); 
  	//END_TABLE:  	
  	//GENERATED_CODE: FOR TABLE_4.
  	//	17 Rules, 16 conditions, and 18 actions.
  	//	Table 4 rule order = 11 1 13 15 2 12 9 14 3 17 16 4 5 6 7 10 8 
  	 {	unsigned long CCIDE_table4_yes[17]={   1UL,   2UL,   4UL,   8UL,  16UL,  32UL,  64UL, 128UL, 256UL, 512UL,1024UL,2048UL,4096UL,8192UL,16384UL,32768UL,   0UL};


  		switch(CCIDEFindRuleYes(17,
  			  (Argis(-a))
  			| (Argis(-b))<<1
  			| (Argis(-c))<<2
  			| (Argis(-d))<<3
  			| (Argis(-l))<<4
  			| (Argis(-L))<<5
  			| (Argis(-e))<<6
  			| (Argis(-m4))<<7
  			| (Argis(-n))<<8
  			| (Argis(-p))<<9
  			| (Argis(-q))<<10
  			| (Argis(-s))<<11
  			| (Argis(-t))<<12
  			| (Argis(-u))<<13
  			| (Argis(-V))<<14
  			| (Argis(-x))<<15
  			  ,CCIDE_table4_yes)) {
  		case 16:	//	Rule  8 
  		    Usage();
  		    exit(0);
  		    break;
  		case 14:	//	Rule  7 
  		    ShowCopyright();
  		    exit(0);
  		    break;
  		case 11:	//	Rule  4 
  		    if(GenSkeleton(argv[narg+1])) narg++;
  		    exit(0);
  		    break;
  		case  9:	//	Rule 17 
  		    SetPrefix(argv[narg+1]); narg++;
  		    break;
  		case 10:	//	Rule 16 
  		    SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  		    break;
  		case  3:	//	Rule 15 
  		    SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  		    break;
  		case  7:	//	Rule 14 
  		    m4out=1; pComment="CCIDE_COMMENT()";pEcomment="";
  		    break;
  		case  2:	//	Rule 13 
  		    SetColumn(argv[narg+1]); narg++;
  		    break;
  		case  5:	//	Rule 12 
  		    SetLang(argv[narg+1]); narg++;
  		    break;
  		case  0:	//	Rule 11 
  		    DupeActionIsAnError=0;
  		    break;
  		case 15:	//	Rule 10 
  		    strcat(xstring, "- ");
  		    break;
  		case  6:	//	Rule  9 
  		    checkequal=0;     // Do Not check for '='.
  		    break;
  		case 13:	//	Rule  6 
  		    noinline=1;
  		    donotgenerate=1;
  		    break;
  		case 12:	//	Rule  5 
  		    yydebug=1;
  		    break;
  		case  8:	//	Rule  3 
  		    noinline=1;
  		    break;
  		case  4:	//	Rule  2 
  		    uselocaltime=1;
  		    break;
  		case  1:	//	Rule  1 
  		    notimestamp=1;
  		    break;
  		} // End Switch
  	}
  	//END_GENERATED_CODE: FOR TABLE_4, by ccide-0.6.2-7 Thu Aug  2 15:00:34 2012 




	narg++;
    }

	assert(NO>YES); assert(DONT_CARE>YES);
	ctbl[NO-YES]='N'; ctbl[YES-YES]='Y'; 
	ctbl[ACT-YES]='X'; ctbl[DONT_CARE-YES] ='-';
	yyparse();
	return RC;
}

/*--)}------------------------------------------------------------*/
