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

#define SIZE 1000 
#define S(C,T) table[C] = T

#ifdef UNIT_TEST 
TOKEN token;
char *tname[NTOK]={"EMPTY","NUMBER","FUNCTION_TOKEN","SEPARATOR","LEFT_PAREN",
		"RIGHT_PAREN","OPERATOR","EQUAL","PLUS","MINUS",
		"TIMES","DIV"};
char *ttable[]={".", "n", "f", "|", "(", ")", "o", "=", "+", "-", "*", "/"};  /* Tokens */
#endif

TOKEN_TYPE table[256];
TOKEN_TYPE type;
int number;

static char *ch=NULL,bfr[SIZE+1];
static FILE *in;

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

static TYPE GetType() {

	//DECISION_TABLE:
	//   Y  N | ch==NULL
	// ________________________
	//   X  - | token = SEPARATOR;
	//   X  - | return  SEPARATOR;
	//   -  X | type = Lookup(*ch);
	//END_TABLE:


	//DECISION_TABLE:
	//   Y  N  N | type == NUMBER
	//   -  Y  N | type > OPERATOR
	// __________________________
	//   X  -  - | number = atoi(ch);
	//   X  -  - | return   NUMBER;
	//   -  X  X | token  = type;
	//   -  X  - | return   OPERATOR;
	//   -  -  X | return   token;
	//END_TABLE:

}

#ifndef PSEUDO_INPUT
TYPE GetToken() {
	static STATE s=2;
	//DECISION_TABLE:
	//   2  3  0  1 | s==$$
	// _____________________
	//   X  -  -  - | Setup();
	//   -  X  -  - | s = (  (in = fopen("./if2rpn.txt","r"))== NULL );
	//   3  -  9  - | s = $$;
	//   -  -  -  X | perror("Opening infix.txt"); return 1;
	//   -  -  X  - | ch=NULL;
	//   X  X  -  X | goto $@;
	//END_TABLE:

    {
	static STATE s2=2;	
	//DECISION_TABLE:
	//   4  2  0  1  -  3  3 | s2==$$
	//   -  -  -  -  -  N  Y | ch==NULL
	// ___________________________
	//   -  X  -  -  -  -  - | s2=(fgets(bfr,SIZE,in) == NULL);
	//   -  -  X  -  -  -  - | ch = strtok(bfr, " \n");
	//   x  -  -  -  -  -  - | ch = strtok(NULL, " \n");
	//   3  -  3  -  -  4  2 | s2 = $$; 
	//   -  -  -  -  -  -  - | ch=NULL;
	//   -  -  -  -  -  X  X | return GetType();
	//   -  -  -  -  -  -  - | return SEPARATOR;
	//   -  -  -  X  X  -  - | return EMPTY;
	//   x  x  x  -  -  -  - | goto $@;
	//END_TABLE:

   }

   // return EMPTY;  // Uncomment to avoid possible compiler error message.
}
#endif

#ifdef UNIT_TEST
int number;
int main() {
	TYPE token=9;
	STATE s=0;

	//DECISION_TABLE:
	//   0  1  1  - | s == $$
	//   -  Y  Y  - | token != EMPTY
	//   -  Y  -  - | token == NUMBER
	// _____________________________
	//   -  X  -  - | printf("%i %s\n",number, tname[t]);
	//   -  -  X  - | printf("%s %s\n",ttable[token], tname[t]);
	//   1  -  -  - | s=$$;
	//   X  X  X  - | token = GetToken();
	//   X  X  X  - | goto $@;
	//END_TABLE:

}

#endif
