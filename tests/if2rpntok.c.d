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
