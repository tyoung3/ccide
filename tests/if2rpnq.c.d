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

/* THISIS: if2rpnq.c.d 7/19/2012 */

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "if2rpn.h"

#define SET(S)    return (S);
#define SETN(N)   number=(N); 	SET(NUMBER); 
#define SETO(T)   token=(T);  	SET(OPERATOR);
 
/***********************GLOBAL VARIABLES******************/
TYPE stack[SSIZE+1];
int SP=0,number;		/* Stack Pointer */
TYPE token=SEPARATOR;

	 //      0                        5                       10
char *ttable[]={".", "n", "f", "|", "(", ")", "o", "=", "+", "-", "*", "/"};  /* Tokens */
/***********************LOCAL VARIABLES******************/
static int instate=1; 
static int ptbl[NTOK]={0,1,2,3,4,4,6,7,8,8,10,10};          /* Precedence table */

/***********************LOCAL FUNCTIONS*******************/

//CCIDE_INLINE_CODE:

/***********************GLOBAL FUNCTIONS******************/
int GetPrecedence() {
	return ptbl[token]>ptbl[TOS];
}

#ifdef PSEUDO_INPUT
TYPE GetToken(){
	//DECISION_TABLE:
	//   1  2  3  4  5  6  7  8  9 10 11 |instate==$$
	// _____________________________________
	//   X  -  -  -  -  -  -  -  -  -  - |SETN(17);	
	//   -  X  -  -  -  -  -  -  -  -  - |SETO(TIMES);
	//   -  -  X  -  -  -  -  -  -  -  - |token=LEFT_PAREN; SET(LEFT_PAREN);
	//   -  -  -  X  -  -  -  -  -  -  - |SETN(5);	
	//   -  -  -  -  X  -  -  -  -  -  - |SETO(PLUS);
	//   -  -  -  -  -  X  -  -  -  -  - |SETN(13);	
	//   -  -  -  -  -  -  X  -  -  -  - |token=RIGHT_PAREN;SET(RIGHT_PAREN);
	//   -  -  -  -  -  -  -  X  -  -  - |SETO(MINUS);
	//   -  -  -  -  -  -  -  -  X  -  - |SETN(41);	
	//   -  -  -  -  -  -  -  -  -  X  - |SETO(EQUAL);
	//   -  -  -  -  -  -  -  -  -  -  X |SET(EMPTY);
	//END_TABLE:

	
	instate++;
}
#endif


void PushToken() {

	//DECISION_TABLE:
	//   N  - |SP<SSIZE
	//________________________
	//   X  - |fprintf(stderr,"Stack space exceeded\n");
	//   X  - |exit(2);
	//   -  X |SP++;
	//   -  X |TOS=token; 
	//END_TABLE:

	
}

void OutputNumber() {

	//DECISION_TABLE:
	//   Y |1
	//________________________
	//   X |printf("%i ", number);
	//END_TABLE:

	
}

void OutputToken(){  
	
	//DECISION_TABLE:
	//   1 |$$==1
	//________________________
	//   X |printf("%s ",token);
	//END_TABLE:

}

void Pop(){ 
	
	//DECISION_TABLE:
	//   Y  N |SP<1
	//________________________
	//   X  - |fprintf(stderr,"");
	//   X  - |exit(1);
	//   -  X |SP--;
	//END_TABLE:

}

void PopToQueue() {
	
	printf("%s ",ttable[TOS]);
	Pop();
}


/* End of IF2RNQ.C */
