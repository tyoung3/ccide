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

/* ccidelex.l  Decision table lexer rules 				     */

%{

#include <string.h>
#include <stdlib.h>
#include "ccidemain.h"
#include "ccideparse.h"

#define PGMNAME "ccide"
void warning( const char *s );

#define PARSE_ERROR 1

char  *StringIn;       	/* String to parse 			*/
char *StringInPtr;     	/* Current position in StringIn 	*/
char *StringInLimit;	/* End of  StringIn data 		*/
int  nbrcstubs=0;	/* Number of condition stub statements. */

/* Return minimum of two values. */
#ifndef min
#define min(A,B) A<B?A:B
#endif

static int lineno = 1;		/* Source file lineno.  */
void yyerror(const char *s);	/* Parse error string   */

/* Set the beginning of a decision table. 
 */
static void SetTable() {
                lineno++;
		SaveLeadingWhiteSpace(yytext);
		printf("%s",yytext);
}

%}

	/*  %option perf-report
	** %option never-interactive
	*/
%option nounput
/* %option nounput
**  %array default is %pointer 
*/
%option perf-report

%x ACTSTUB
%x ACTIONS
%x CONDS
%x CONDSTUB
%x GENERATED

%%

<CONDSTUB>[\ \t]*NEWGROUP.*\*\/$  {  
	lineno++; 
	BEGIN CONDS;
	return (NEWGROUP); 
	}

<ACTSTUB>[\ \t]*NEWGROUP.*\*\/$  {  
	lineno++; 
	BEGIN ACTIONS;
	return (NEWGROUP); 
	}

<CONDSTUB>[\ \t]*NEWGROUP.*$  {   
	lineno++; 
	BEGIN CONDS;
	return (NEWGROUP); 
	} 

<ACTSTUB>[\ \t]*NEWGROUP.*$  {   
	lineno++; 
	BEGIN ACTIONS;
	return (NEWGROUP); 
	}

<ACTSTUB>[^\n]*\*\/$  { 
		yytext[strlen(yytext)-2] = 0;
		yylval.string = Strdup(yytext);
		lineno++;
		BEGIN ACTIONS;
		return ( PSTUB );  
	}

<ACTSTUB>[^\n]*$  { 
		yytext[strlen(yytext)] = 0;
		yylval.string = Strdup(yytext);
		lineno++;
		BEGIN ACTIONS;
		return ( PSTUB );  
	}; 

<CONDSTUB>[^\n]*\*\/$  { 
		yytext[strlen(yytext)-2] = 0;
		yylval.string = Strdup(yytext);
		lineno++;
		BEGIN CONDS;
		return ( PSTUB );  
	}

<CONDSTUB>[^\n]*$  { 
		yytext[strlen(yytext)] = 0;
		yylval.string = Strdup(yytext);
		lineno++;
		BEGIN CONDS;
		return ( PSTUB );  
	}; 

<CONDS>^[\ \t]*;[_\ \-\t\|]*$  	{
                BEGIN ACTIONS;
                lineno++;
                printf("%s",yytext);
                return( START_ACTIONS );
        };

<CONDS>^[\ \t]*#[_\ \-\t\|]*$  	{
                BEGIN ACTIONS;
                lineno++;
                printf("%s", yytext);
                return( START_ACTIONS );
        };

<CONDS>^[\ \t]*~~[_\ \-\t\|]*$  	{
                BEGIN ACTIONS;
                lineno++;
                printf("%s", yytext);
                return( START_ACTIONS );
        };

<CONDS>^[\ \t]*[\%\'][_\ \-\t\|]*$  	{
                BEGIN ACTIONS;
                lineno++;
                printf("%s",yytext);
                return( START_ACTIONS );
        };

<CONDS>^[\ \t]*\/\/[_\ \-\t\|]*$  {
		BEGIN ACTIONS; 
		lineno++;
		printf("%s",yytext);
		return( START_ACTIONS );
	};

<CONDS>^[\ \t]*\/\*[_\ \-\t\|]*\*\/$  {
		BEGIN ACTIONS; 
		lineno++;
		printf("%s",yytext);
		return( START_ACTIONS );
	};

<CONDS>^[\ \t]*--\ [_\ \-\t\|]*$  {
		BEGIN ACTIONS; 
		lineno++;
		printf("%s",yytext);
		return( START_ACTIONS );
	};


<ACTIONS>^[\ \t]*;END_TABLE:.*$	     {
                BEGIN INITIAL;
                lineno++;
                printf("%s\n",yytext);
                return( TEND );
        };

<ACTIONS>^[\ \t]*~~END_TABLE:.*$	     {
                BEGIN INITIAL;
                lineno++;
                printf("%s\n",yytext);
                return( TEND );
        };

<ACTIONS>^[\ \t]*#END_TABLE:.*$	     {
                BEGIN INITIAL;
                lineno++;
                printf("%s\n",yytext);
                return( TEND );
        };

<ACTIONS>^[\ \t]*[\%\']END_TABLE:.*$	     {
                BEGIN INITIAL;
                lineno++;
                printf("%s\n",yytext);
                return( TEND );
        };

<ACTIONS>^[\ \t]*\/\/END_TABLE:.*$   { 
		BEGIN INITIAL; 
		lineno++;
		printf("%s\n",yytext);
		return( TEND );
	};

<ACTIONS>^[\ \t]*\/\*END_TABLE:.*\*\/*$   { 
		BEGIN INITIAL; 
		lineno++;
		printf("%s\n",yytext);
		return( TEND );
	};

<ACTIONS>^[\ \t]*--END_TABLE:.*$   { 
		BEGIN INITIAL; 
		lineno++;
		printf("%s\n",yytext);
		return( TEND );
	};

<GENERATED>^[\ \t]*#END_GENERATED_CODE:[^\n]*\n     {
                BEGIN INITIAL;
                lineno++;
        };

<GENERATED>^[\ \t]*~~END_GENERATED_CODE:[^\n]*\n     {
                BEGIN INITIAL;
                lineno++;
        };

<GENERATED>^[\ \t]*;END_GENERATED_CODE:[^\n]*\n     {
                BEGIN INITIAL;
                lineno++;
        };

<GENERATED>^[\ \t]*\/\/END_GENERATED_CODE:[^\n]*\n  { 
		BEGIN INITIAL; 
		lineno++;
	};

<GENERATED>^[\ \t]*\/\*END_GENERATED_CODE:[^\n]*\*\/\n  { 
		BEGIN INITIAL; 
		lineno++;
	};

<GENERATED>^[\ \t]*--END_GENERATED_CODE:[^\n]*\n  { 
		BEGIN INITIAL; 
		lineno++;
	};

<GENERATED>[^\n]*\n   { 
		lineno++;
	};

<CONDS,ACTIONS>--\      |
<CONDS,ACTIONS>\/\/     |
<CONDS,ACTIONS>\/\*     |
<CONDS,ACTIONS>\/#	|
<CONDS,ACTIONS>~~	{printf("%s%c%c ",lws,yytext[0],yytext[1]);};

<CONDS,ACTIONS>[#\;\%\']   {printf("%s%s ",lws,yytext);};

<CONDS>N\t |
<CONDS>N  {	return(NO); 	};

<CONDS>Y\t |
<CONDS>Y  {	return(YES); 	};

<CONDS>\|\t*   { 	BEGIN CONDSTUB; 
		nbrcstubs++;
	};

<ACTIONS>\|\t*	{ BEGIN ACTSTUB; }

<ACTIONS>X\t	|
<ACTIONS>X	{ return(ACT); }

<CONDS,ACTIONS>[0-9]\t				|
<CONDS,ACTIONS>[0-9]\  				|
<CONDS,ACTIONS>[0-9][0-9]\t			|
<CONDS,ACTIONS>[0-9][0-9]\ 			|
<CONDS,ACTIONS>[0-9][0-9][0-9]\ 		|	
<CONDS,ACTIONS>[0-9][0-9][0-9]\t 		|
<CONDS,ACTIONS>[0-9][0-9][0-9][0-9]\  		|
<CONDS,ACTIONS>[0-9][0-9][0-9][0-9]\t  		|
<CONDS,ACTIONS>[0-9][0-9][0-9][0-9][0-9]\ 	|
<CONDS,ACTIONS>[0-9][0-9][0-9][0-9][0-9]\t  	{
		yylval.ival = atol(yytext);
		return NUMBER;
	}

<CONDS,ACTIONS>\t- |
<CONDS,ACTIONS>-  { return(DONT_CARE); 	};


^[\ \t]*;CCIDE_INLINE_CODE:.*\n    {
        printf("%s",yytext);
        GenInLineCode(yytext);
        };

^[\ \t]*~~CCIDE_INLINE_CODE:.*\n    {
        printf("%s",yytext);
        GenInLineCode(yytext);
	};

^[\ \t]*#CCIDE_INLINE_CODE:.*\n    {
        printf("%s",yytext);
        GenInLineCode(yytext);
        };

^[\ \t]*\/\/CCIDE_INLINE_CODE:.*\n {  
        printf("%s",yytext);
	GenInLineCode(yytext); 
	};

^[\ \t]*\/\*CCIDE_INLINE_CODE:.*\*\/\n {  
        printf("%s",yytext);
	GenInLineCode(yytext); 
	};

^[\ \t]*[\%\']CCIDE_INLINE_CODE:.*\n {  
        printf("%s",yytext);
	GenInLineCode(yytext); 
	};

^[\ \t]*--CCIDE_INLINE_CODE:.*\n {  
        printf("%s",yytext);
	GenInLineCode(yytext); 
	};

^[\ \t]*;DECISION_TABLE:.*\n	{
                BEGIN CONDS;
		SetTable();
                return( TSTART );
        };

^[\ \t]*~~DECISION_TABLE:.*\n	{
                BEGIN CONDS;
		SetTable();
                return( TSTART );
        };

^[\ \t]*#DECISION_TABLE:.*\n	{
                BEGIN CONDS;
		SetTable();
                return( TSTART );
        };

^[\ \t]*[\%\']DECISION_TABLE:.*\n	{
                BEGIN CONDS;
                SetTable();
                return( TSTART );
        };


^[\ \t]*\/\*DECISION_TABLE:.*\*\/\n { 
		BEGIN CONDS; 
                SetTable();
                return( TSTART );
	};

^[\ \t]*\/\/DECISION_TABLE:.*\n { 
		BEGIN CONDS; 
                SetTable();
                return( TSTART );
	};

^[\ \t]*--DECISION_TABLE:.*\n { 
		BEGIN CONDS; 
                SetTable();
                return( TSTART );
	};

^[\ \t]*;GENERATED_CODE:.*\n			|
^[\ \t]*#GENERATED_CODE:.*\n			|
^[\ \t]*~~GENERATED_CODE:.*\n			|  
^[\ \t]*[\%\']GENERATED_CODE:.*\n		|
^[\ \t]*\/\*GENERATED_CODE:.*\*\/\n 		| 
^[\ \t]*--GENERATED_CODE:.*\*\/\n 		| 
^[\ \t]*\/\/GENERATED_CODE:.*\n { 
		BEGIN GENERATED; 
		lineno++;
	};

<CONDS,ACTIONS,CONDSTUB,ACTSTUB>[\ \t]	{;} 


<INITIAL>.*\n {  
	lineno++;
	printf( "%s", yytext); 
	};

%%

/* Issue parse error message.
 */
void yyerror(const char *s) {
	static int count=0;

        fprintf(stderr, 
		"%s: Error in line %d: %s near '%s'. Start State=%d\n",
		PGMNAME, lineno, s, yytext, yy_start);

	if( count++ > 9 ) {
		printf("%s Reached maximum error count.  Generation abandoned.\n",
			pComment);
		fprintf(stderr,"Reached maximum error count.  Generation abandoned.\n");
		exit ( PARSE_ERROR );
	}
}

/* Issue parse warning message.
 */
void warning( const char *s ) {
        fprintf(stderr,"%s: WARNING at line %i: %s\n", PGMNAME, lineno, s);
}

/* Allow buffer switch.
 */
int yywrap() {
        return(1);
}

/*  End of ccidelex.l */
