/*  Convert infix to RPN: A Decision table version of Dijkstra's Shunting-yard_algorithm:  

		http://en.wikipedia.org/wiki/Shunting-yard_algorithm

    While there are tokens to be read:

        Read a token.
        If the token is a number, then add it to the output queue.
        If the token is a function token, then push it onto the stack.
        If the token is a function argument separator (e.g., a comma):

            Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue. If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.

        If the token is an operator, o1, then:

            while there is an operator token, o2, at the top of the stack, and

                    either o1 is left-associative and its precedence is less than or equal to that of o2,
                    or o1 has precedence less than that of o2,

                pop o2 off the stack, onto the output queue;

            push o1 onto the stack.

        If the token is a left parenthesis, then push it onto the stack.
        If the token is a right parenthesis:

            Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue.
            Pop the left parenthesis from the stack, but not onto the output queue.
            If the token at the top of the stack is a function token, pop it onto the output queue.
            If the stack runs out without finding a left parenthesis, then there are mismatched parentheses.

    When there are no more tokens to read:

        While there are still operator tokens in the stack:

            If the operator token on the top of the stack is a parenthesis, then there are mismatched parentheses.
            Pop the operator onto the output queue.

    Exit.
*/

#include <stdlib.h>
#include <stdio.h>
#include "if2rpn.h"

//CCIDE_INLINE_CODE:


static void MisMatch() {
	fprintf(stderr,"Mismatched parens.\n");
}

/*
        If the token is a right parenthesis:
            Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue.
            Pop the left parenthesis from the stack, but not onto the output queue.
            If the token at the top of the stack is a function token, pop it onto the output queue.
            If the stack runs out without finding a left parenthesis, then there are mismatched parentheses.
*/
// TOS: 0-EMPTY, 4-LEFT_PAREN, 6-OPERATOR, 7-FUNCTION_TOKEN
static STATE DoRightParen() {

	//DECISION_TABLE:		
	// - 4 6 7 8 9 10 11 |TOS==$$ 
	// ________________________________________
	// - x - - -  -  - - | Pop();  
	// - - x x x x  x  x | PopToQueue();
	// - - x x x x  x  x | goto $@;
	// 9 2 - - - -  -  - | return $$;  
	//END_TABLE:
}

//            Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue. 
// If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.
// TOS: 0-EMPTY, 4-LEFT_PAREN, 6-OPERATOR
static STATE FindLeft() {

	//DECISION_TABLE:    /* Check Stack */
	// 0 4 6 |TOS==$$  
	// _______________
	// - - x | goto $@;
	// 9 2 - | return $$; 
	//END_TABLE:
}

/*        If the token is an operator, o1, then:
            while there is an operator token, o2, at the top of the stack, and
                    either o1 is left-associative and its precedence is less than or equal to that of o2,
                    or o1 has precedence less than that of o2,
                pop o2 off the stack, onto the output queue;
           { In main table: push o1 onto the stack.}
*/ 

static STATE DoOperator() {
	STATE s=9;

	//DECISION_TABLE:
	//  9   -  0  0  0  0  0  1  1  1  1  1 | s==$$
	//  -   -  7  8  9 10 11  7  8  9 10 11 | TOS==$$
	//  ____________________________________________________
	//  -   -  x  x  x  x  x  -  -  -  -  - | PopToQueue(); 
	//  x   -  x  x  x  x  x  -  -  -  -  - | s=GetPrecedence(); 
	//  x   -  x  x  x  x  x  -  -  -  -  - | goto $@; 
	//  -   2  -  -  -  -  -  2  2  2  2  2 | return $$;
	//END_TABLE:
}

// 1-number, 2-function token, 3-function argument separator (e.g. a comma) 9=no more tokens // 4=LEFT_PAREN, 5=RIGHT_PAREN, 6=OPERATOR

static void ParseInput() {
	STATE s=0;
	TOKEN_TYPE t;

	//DECISION_TABLE:
	// 0 2 2 2 2 2 2 - | s==$$
	// - 1 2 3 4 5 6 - | t==$$   
	// _____________________________
	// - - - x - - - - |s=FindLeft();
	// - - - - - x - - |s=DoRightParen();
	// - - - - - - x - |s=DoOperator();
	// - - x - x - x - |PushToken();
	// - x - - - - - - |OutputNumber();
	// 2 - - - - - - - |s=$$;
	// x x x x x x x - |t=GetToken();
	// x x x x x x x - |goto $@;
	//END_TABLE:

			// 0=EMPTY, 1=LEFT_PAREN, 2=RIGHT_PAREN

	    //DECISION_TABLE:    	/* No more input tokens */
	    // - 1 2 5 7 8 9 10 11 |TOS==$$    
	    // ____________________|____________
	    // - x - x - - -  -  - | MisMatch();        
	    // - - x - x x x  x  x | PopToQueue();
	    // - x x x x x x  x  x | goto $@;  
	    // x - - - - - -  -  - | printf("\n");
	    //END_TABLE:
}

int main(int argc, char **argv) {

	TOS=EMPTY;     
	while(  token==SEPARATOR) {
		token=EMPTY;
		ParseInput();
	}
	return 0;

}
