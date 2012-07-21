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

/* THISIS: if2rpntok.c.d 7/19/2012 */

#include <stdio.h>     
#include <string.h>
#include "if2rpn.h"

// #define UNIT_TEST
#define SIZE 1000 
#define S(C,T) table[C] = T

#ifdef UNIT_TEST 
//#include <curses.h>
TOKEN token;
char *tname[NTOK]={"EMPTY","NUMBER","FUNCTION_TOKEN","SEPARATOR","LEFT_PAREN",
		"RIGHT_PAREN","OPERATOR","EQUAL","PLUS","MINUS",
		"TIMES","DIV"};
char *ttable[]={".", "n", "f", "|", "(", ")", "o", "=", "+", "-", "*", "/"};  /* Tokens */
#endif

TOKEN_TYPE table[256];
TOKEN_TYPE type;
int number;

//CCIDE_INLINE_CODE:

static TOKEN_TYPE Lookup(char c) {
	return table[c]; 
}

static void Setup(){
	int i;

	for(i=0;i<10;i++) {
		S(i+'0',NUMBER);
	}
	S(';',SEPARATOR);
	S('+',PLUS);
	S('-',MINUS);
	S('=',EQUAL);
	S('*',TIMES);
	S('/',DIV);
	S('(',LEFT_PAREN);
	S(')',RIGHT_PAREN);
}

static int onone=1;
static char *ch=NULL,bfr[SIZE+1];

static FILE *in;

static TYPE GetType() {

	//DECISION_TABLE:
	// Y  N | ch==NULL
	// ________________________
	// X  -	| token = SEPARATOR;
	// X  - | return  SEPARATOR;
	// -  X | type = Lookup(*ch);
	//END_TABLE:

	//DECISION_TABLE:
	// Y  -  - | type == NUMBER
	// -  Y  N | type > OPERATOR
	// __________________________
	// X  -	 - | number = atoi(ch);
	// X  -  - | return   NUMBER;
	// -  X  X | token  = type;
	// -  X  - | return   OPERATOR;
	// -  -  X | return   token;
	//END_TABLE:
	
}

#ifndef PSEUDO_INPUT
TYPE GetToken() {
  if(onone) {
	onone=0;
	Setup();
	if( (in = fopen("./if2rpn.txt","r"))==NULL ){
		perror("Opening infix.txt");
		return 1;
  	}
	ch=NULL;
   }

   if(ch == NULL) {
	if(fgets(bfr,SIZE,in) == NULL) 
		return EMPTY;
  	ch = strtok(bfr, " \n");
	return GetType();
   } else {
	  ch = strtok(NULL, " \n");
	  return GetType();
   }

   return EMPTY;
}
#endif

#ifdef UNIT_TEST
int number;
int main() {
	TYPE t;

	do {
		t=GetToken();	
		if(t==NUMBER) {
			printf("%i %s\n",number, tname[t]);
		} else {
			printf("%s %s\n",ttable[token], tname[t]);
		}
	} while( t!=EMPTY);
	
}

#endif
