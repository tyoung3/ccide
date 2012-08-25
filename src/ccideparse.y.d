/*  	ccide - C Language Decision Table Code Generator 
	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

    	This file is part of ccide, the C Language Decision Table Code Generator.

   	ccide is free software: you can redistribute it and/or modify
   	it under the terms of the GNU General Public License as published by
    	the Free Software Foundation, either version 3 of the License, or
   	(at your option) any later version.

    	ccide is distributed in the hope that it will be useful,
    	but WITHOUT ANY WARRANTY; without even the implied warranty of
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    	GNU General Public License for more details.

    	You should have received a copy of the GNU General Public License
    	along with ccide.  If not, see <http://www.gnu.org/licenses/> or
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

   	ccide is free software: you can redistribute it and/or modify
   	it under the terms of the GNU General Public License as published by
    	the Free Software Foundation, either version 3 of the License, or
   	(at your option) any later version.

    	cide is distributed in the hope that it will be useful,
    	but WITHOUT ANY WARRANTY; without even the implied warranty of
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    	GNU General Public License for more details.

    	You should have received a copy of the GNU General Public License
    	along with cide.  If not, see <http://www.gnu.org/licenses/> or
    	write to the Free Software Foundation, Inc., 51 Franklin St, 
    	Fifth Floor, Boston, MA 02110-1301 USA.
*/

#define PARSE_STRING_SIZE 4096

	/* For gettext: */
#include "ccideconfig.h"
#include <locale.h>
#include "gettext.h"
#define _(string) gettext (string)
#define YYENABLE_NLS 1

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
static char *xstring=xs;    /* For adding a new rule  	*/

int substitute=0;        /* 1 - If substitution in row 	*/
int RC=0;		 /* main() Return Code 		*/

/* static CCIDE_HANDLE handle; */
static int nrules=0;   	 /* Number of rules */
static int nbrrules=0;   /* Number of rules */
static int nconds=0;   	 /* Number of condition statements 	*/

int nactions=0;   	 	/* Number of actions 		*/
int DupeActionIsAnError=1;    	/* 0=allow duplicate actions. 	*/

void yyerror( const char *s);
int yylex( void );
void warning2( char *s, char *t);

#undef  LOGE
#undef  LOGP
#undef  syslog		/* Flawfinder: ignore */
#define syslog fprintf	/* Flawfinder: ignore */
#define LOGE   stderr
#define LOGP   stderr

#define YYDEBUG  1      /* Move 1 to yydebug to debug 	*/ 
#define MAXTOKEN 1024	/* Largest possible token 	*/
#define EOL '\n'	/* End of line			*/
#define EOS '\0'	/* End of string		*/

void fatal(char *s);			/* Fatal error msg string		*/
static int columnsize=3;		/* Decision table spacing		*/
// static int skelsize=1; 		/* Size of skeleton decision table 	*/
static void SetNbrRules(int n);		
static void PrintC(char c);		/* Print a character 				*/
static inline long int max( long int a, long int b);  /* Return max of two values 	*/
static void PrintNum(long int n);	/* Print a number 				*/
static char pGroup[100];
static int logCond=FALSE;

/** Strip trailing whitespace 
 */
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

condition_statement: conds PSTUB 
        {
	    printf(" %s|%s", xstring, $2);
	    if(logCond) {
		nconds+=SetCSTUBscan( nconds, StripTrail($2) );
		logCond = FALSE;
	    }	
	    SetNbrRules(nrules);
	    substitute=0; 
	}
	| conds NEWGROUP {
	    printf(" %s|NEWGROUP\t\t", xstring );
	    if(logCond) {
		if(lang==EX)
			sprintf(pGroup, "%s_group = %s", pPrefixLc, svar1);
		else
			sprintf(pGroup, "%s_group == %s", pPrefixLc, svar1);
		nconds+=SetCSTUBscan( nconds, pGroup );
		logCond = FALSE;
	    }
	    SetNbrRules(nrules);
	    substitute=0; 
	};

action_statement:  
	actions NEWGROUP {
	    printf(" %s|NEWGROUP", xstring);
	    if(usegoto) {
		ccide_newgroup=1;
		SetASTUBn( nactions, nrules );
		SetNbrRules(nrules);
		nactions += (substitute+1);
		substitute=0;
	    } else {
		printf("\n");
		ERROR1(_("NEWGROUP not supported for GOTOless languages."));
	    }
	}
	|
	actions PSTUB {
		/* printf(" %s|%s%s", xstring, $2,pEcomment); */
		printf(" %s|%s", xstring, $2);
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
		ERROR3(_("%i exceeds the maximum number of rules  %i."), 
			 nbrrules, CCIDE_NRULE);
		nbrrules = CCIDE_NRULE;
	  }
	  if(nactions > CCIDE_NACTION) {
		ERROR3(_("%i exceeds the maximum number of actions %i."), 
			 nactions, CCIDE_NACTION);
		nactions = CCIDE_NACTION;
	  }
	  if(nconds > CCIDE_NCOND) {
		ERROR3(_("%i exceeds the maximum number of conditions %i."), 
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

/*-------------------------------------------------------------------
**  WARNING
*/
void warning2( char *s, char *t)
{
    if(quiet) return;
    syslog( LOGP, "%s: %s", progname, s) ;

    if (t)
	syslog( LOGP, " %s", t) ;

    syslog( LOGP, " near line %d\n", lineno) ;
}

	/* ?? Move this to ...?.h  */
#ifndef UINT_MAX
#include <limits.h>
#endif /* End if not defined UINT_MAX */

/** Check number of rules equal to number in the first D/T statement.
 */ 
static void SetNbrRules(int n) {

	DISPLAY(SetNbrRules);
	if( nbrrules == 0 ) {
		nbrrules=n;
	} else {
		if( nbrrules != n ) {
			/* yyerror( "Inconsistent number of rules."); */
			ERROR3(_("%i rules, instead of %i."), 
				n, nbrrules);
		}
	}

	nrules=0;
	DISPLAY(End SetNbrRules);
}

	/** Set Prefix for D/T output.
        */
static void SetPrefix(char *s) {
	char *s1, *s2;
	const char *const_1={_("Prefix longer than space allows.")};

	if(strlen(s) > MAXPREFIX) {
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
			fprintf(stderr,_("Prefix contains invalid characters."));
			return;
		}
	}

	strcpy(pPrefix,s);
	s1 = s2 = Strdup(s);
	
	while(*s1) {	
		*s1 = tolower(*s1);
		s1++;
	}
	strcpy(pPrefixLc,s1);
	free(s2);
}

	/* Set Column size */
static void SetColumn(char *s) {
	
	columnsize=atoi(s);
	if(columnsize > 4)
		columnsize = 4;
}

/** Ensure delimiters are orthogonal. 
 */ 
int DelimitCheck(char *s1, char *s2) {
	if( strcmp(s1,s2) == 0 ) {
		fprintf(stderr,_("CCIDE/FATAL: Delimiter %s cannot equal a QUOTE=(%s,%s) or a SUBSTITUTION=(%s,%s) \n"),
			s1,qt1,qt2,svar1,svar2); 
		return 1;
	}
	return 0;
}

	/* Check delimiters 
	 */
static int DelimitEq(char *s1, char *s2) {

	if( (s1==NULL) || (s2==NULL) ) {
		fprintf(stderr,_("NULL Delimiter\n")); 
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

	/* Set stub substition strings. 
         */
static void SetDelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	svar1=s1; 
	lsvar1=strlen(s1);
	lsvar2=strlen(s2);
	svar2=s2;
}

	/* Set m4 delimiters 
	 */
static void SetQdelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	qt1=s1; 
	lqt1=strlen(s1);
	lqt2=strlen(s2);
	qt2=s2;
	changequote=1;
}


static char *AddPfx(char *s1, char *s2) {
	char *s;

	s=malloc (strlen(s1) + strlen(s2) + 1);
	strcpy(s,s1);
	strcat(s,s2);
	return s;
}	
	/* Set computer language 
         */
static void SetLang(char *s) {
	int onone=1;

    if(onone) {     /* Disallow multiple language settings */
    onone=0;
        //DECISION_TABLE:
        //   N  -  -    -   -  -  Y  -  -  -  - - | strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0
        //   N  -  -    -   -  -  -  -  -  -  - - | strcmp(s,"CC")==0    || strcmp(s,"cc")==0 
        //   N  -  Y    -   -  -  -  -  -  -  - - | strcmp(s,"BASH")==0  || strcmp(s,"bash")==0
        //   N  -  -    Y   -  -  -  -  -  -  - - | strcmp(s,"QB")==0    || strcmp(s,"qb")==0
        //   N  -  -    -   -  -  -  -  -  Y  - - | strcmp(s,"cs")==0    || strcmp(s,"CS")==0 || strcmp(s,"C#")==0 
        //   N  -  -    -   -  -  -  -  Y  -  - - | strcmp(s,"JAVA")==0  || strcmp(s,"java")==0
        //   N  -  -    -   Y  -  -  -  -  -  - - | strcmp(s,"VB")==0    || strcmp(s,"vb")==0
        //   N  -  -    -   -  Y  -  -  -  -  - - | (strcmp(s,"EX")==0)  || (strcmp(s,"ex")==0)
        //   N  -  -    -   -  -  -  Y  -  -  - - | strcmp(s,"C")==0     || strcmp(s,"c")==0
        //   N  -  -    -   -  -  -  -  -  -  Y - | strcmp(s,"C++")==0   || strcmp(s,"c++")==0 
        //   N  -  -    -   -  -  -  -  -  -  - Y | strcmp(s,"JS")==0    || strcmp(s,"js")==0 || strcmp(s,"JAVASCRIPT")==0   
        //  __________________________________________________________________________________________
        //   -  X  -    -   -  -  -  -  -  -  - - | printf(_("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n"), s); Usage();exit(1);
        //   -  -  X    -   -  -  -  -  -  -  - - | lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");usegoto=0;
        //   -  -  -    X   -  -  -  -  -  -  - - | lang=QB; 
        //   -  -  -    -   X  -  -  -  -  -  - - | lang=VB; 
        //   -  -  -    -   -  X  -  -  -  -  - - | lang=EX;	 // euphoria 
        //   -  -  -    -   -  -  X  -  -  -  - - | lang=BASIC; 
        //   -  -  -    -   -  -  -  -  X  -  - - | lang=JAVA; 
        //   -  -  -    -   -  -  -  -  -  X  - - | lang=CS;  
        //   -  -  -    -   -  -  -  -  -  -  - X | lang=JS;  
	//   -  -  X    -   -  -  -  -  X  -  - X | usegoto=0; // For GOTOless languages
        //   -  -  -    -   -  -  -  -  -  -  - - | lang=CC;  
        //   X  -  -    -   -  X  -  -  X  X  - - | SetQdelimit("`","\'");     
        //   X  -  X    X   X  X  X  -  X  -  - - | m4out=1;   pComment=AddPfx(pPrefix,"_COMMENT(");   pEcomment=")";
        //END_TABLE:

    }  /* End if onone */
}

/** Print a character,  adjusting for column width.
 */
static void PrintC(char c) {
	//DECISION_TABLE:
	//   1  3  4  5  6  -  - - | columnsize==$$
	//   ____________________________________
	//   X  -  -  -  -  -  - - | printf("%c",c);
	//   -  -  -  -  -  X  - - | printf(" %c",c);
	//   -  X  -  -  -  -  - - | printf("  %c",c);
	//   -  -  X  -  -  -  - - | printf("   %c",c);
	//   -  -  -  X  -  -  - - | printf("    %c",c);
	//   -  -  -  -  X  -  - - | printf("     %c",c);
	//END_TABLE:

}

/** Compute maximum of two values.
 */
static inline long int max( long int a, long int b) {

	if( b > a) 
		return b;
	return a;
}

/** Print number adjusting for column width.
 */
static void PrintNum(long n) {

	//DECISION_TABLE:
	//   2  3  4  5  -  -  -  -  -  - - | columnsize==$$
	//   Y  -  -  -  Y  N  N  N  N  - - | n<10
	//   -  Y  -  -  N  Y  N  N  N  - - | n<100
	//   -  -  Y  -  -  -  Y  N  N  - - | n<1000
	//   -  -  -  Y  -  -  -  Y  N  - - | n<10000
	//   ______________________________________
	//   2  3  4  5  2  3  4  5  6  - - | printf("%$$li", n);
	//END_TABLE:     

}

/* Define condition for D/T. */
#define Argis(P) strcmp( #P, argv[narg]) == 0 

/** ccide main entry point. 
 */
int main( int argc, char **argv) {
	int narg=1;
	char *s1, *tdomain, *tdir;
	int ls1;

        assert( UINT_MAX == 4294967295UL);
	lws = Strdup("");

/* ENABLE_NLS is set (or not) in ccideconfig.h by configure. */
#ifdef  ENABLE_NLS
   	setlocale (LC_ALL, "");
	if(  (tdir=bindtextdomain (PACKAGE, LOCALEDIR)) == NULL) {
		perror(_("Binding gettext"));    
	};
	if(  (tdomain=textdomain (PACKAGE)) == NULL) {
		perror(_("Getting textdomain"));  
	}
#endif

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
		fprintf(stderr, _("Parameter %i is too long.\n"), narg);
		exit(1);
	}

  	//DECISION_TABLE:
  	//   -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  - - | Argis(-a)||Argis(--actiondupes)
  	//   Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | Argis(-b)||Argis(--blanktime)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  - - | Argis(-c)||Argis(--columnsize)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  - - | Argis(-d)||Argis(--delimiter)
  	//   -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  -  -  - - | Argis(-e)||Argis(--equalok)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y - | Argis(-g)||Argis(--gotoless)
  	//   -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | Argis(-l)||Argis(--localtime)
  	//   -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  - - | Argis(-L)||Argis(--language) 
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  - - | Argis(-m4)||Argis(--m4output)
  	//   -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | Argis(-n)||Argis(--noinlinecode)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  - - | Argis(-p)||Argis(--prefix)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  - - | Argis(-q)||Argis(--quote)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - Y | Argis(-k)||Argis(--quiet)
  	//   -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | Argis(-s)||Argis(--skeleton)
  	//   -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  - - | Argis(-t)||Argis(--trace)
  	//   -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  - - | Argis(-u)||Argis(--undo)
  	//   -  -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  - - | Argis(-V)||Argis(--version)
  	//   -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  -  - - | Argis(-x)||Argis(--extrarule)
  	//  ________________________________________________________________
  	//   X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | notimestamp=1;
  	//   -  X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | uselocaltime=1;
  	//   -  -  X  -  -  X  -  -  -  -  -  -  -  -  -  -  -  - - | noinline=1;
  	//   -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  -  - - | if(GenSkeleton(argv[narg+1])) narg++;
  	//   -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  - - | yydebug=1;
  	//   -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  - - | donotgenerate=1;
  	//   -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  - - | ShowCopyright(); 
  	//   -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  - - | Usage();
  	//   -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  - - | checkequal=0;     // Do Not check for '='.
  	//   -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  - - | strcat(xstring, "- ");
  	//   -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  - - | DupeActionIsAnError=0;
  	//   -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  - - | SetLang(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  - - | SetColumn(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  - - | m4out=1; pComment=AddPfx(pPrefix,"_COMMENT()");  ;pEcomment="";
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  - - | SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  - - | SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  - - | SetPrefix(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X - | usegoto=0;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - X | quiet=1;
  	//   -  -  -  X  -  -  X  X  -  -  -  -  -  -  -  -  -  - - | exit(0); 
  	//END_TABLE:  	


	narg++;
    }

	assert(NO>YES); assert(DONT_CARE>YES);
	ctbl[NO-YES]='N'; ctbl[YES-YES]='Y'; 
	ctbl[ACT-YES]='X'; ctbl[DONT_CARE-YES] ='-';
	yyparse();
	return RC;
}

/*--)}------------------------------------------------------------*/
