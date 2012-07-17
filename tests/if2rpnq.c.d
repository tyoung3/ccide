/*  IF2RPNQ.C    
*/

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
static int Prec(TYPE a, TYPE b) {
	STATE rc;
	rc = ptbl[a]>ptbl[b];
	return rc;
}

/***********************GLOBAL FUNCTIONS******************/
STATE GetPrecedence() {
	return Prec(token,TOS);
}

#ifdef PSEUDO_INPUT
TYPE GetToken(){
	//DECISION_TABLE:
	// 1 2 3 4 5 6 7 8  9 10 11 |instate==$$
	// _____________________________________
	// 2 3 4 5 6 7 8 9 10 11 12 |instate=$$;
	// x - - - - - - -  -  -  - |SETN(17);	
	// - x - - - - - -  -  -  - |SETO(TIMES);
	// - - x - - - - -  -  -  - |token=LEFT_PAREN; SET(LEFT_PAREN);
	// - - - x - - - -  -  -  - |SETN(5);	
	// - - - - x - - -  -  -  - |SETO(PLUS);
	// - - - - - x - -  -  -  - |SETN(13);	
	// - - - - - - x -  -  -  - |token=RIGHT_PAREN;SET(RIGHT_PAREN);
	// - - - - - - - x  -  -  - |SETO(MINUS);
	// - - - - - - - -  x  -  - |SETN(41);	
	// - - - - - - - -  -  x  - |SETO(EQUAL);
	// - - - - - - - -  -  -  x |SET(EMPTY);
	//END_TABLE:
}
#endif

void PushToken() {

	//DECISION_TABLE:
	// N -  |SP<SSIZE
	//________________________
	// x -	|fprintf(stderr,"Stack space exceeded\n");
	// x -	|exit(2);
	// - x  |SP++;
	// - x  |TOS=token; 
	//END_TABLE:
	
}

void OutputNumber() {

	//DECISION_TABLE:
	// Y |1
	//________________________
	// x |printf("%i ", number);
	//END_TABLE:
	
}

void OutputToken(){  
	
	//DECISION_TABLE:
	// 1  |$$==1
	//________________________
	// X  |printf("%s ",token);
	//END_TABLE:
}

void Pop(){ 
	
	//DECISION_TABLE:
	// Y -  |SP<1
	//________________________
	// x -	|fprintf(stderr,"");
	// x -	|exit(1);
	// - x  |SP--;
	//END_TABLE:
}

void PopToQueue() {
	
	printf("%s ",ttable[TOS]);
	Pop();
}


/* End of IF2RNQ.C */
