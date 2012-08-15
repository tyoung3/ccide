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

/* THISIS: if2rpn.c.d 7/19/2012 */

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
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.6.4-1
ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com 
The code generated by ccide is covered by the same license as the source  
code(decision table) from which it is derived. If you created the source,  
you are free to do anything you like with the generated code, 
including incorporating it into or linking it with proprietary software.  
*/ 
static int ccide_group=1; 
#ifndef UINT_MAX 
#include "limits.h" 
#endif /* End if not defined UINT_MAX */ 
 
		/* Return rule number */ 
static int CCIDEFindRule(
	int nbrrules,  unsigned long ccide_table, unsigned long yes[], unsigned long no[]){ 
        int r=0; 
        unsigned long nstate; 
 
        nstate = UINT_MAX ^ ccide_table; 
 
        while ( 
		( (yes[r] & nstate) || (no[r]  & ccide_table) ) 
		 && ( ++r < nbrrules )  
	) {}; 
 
        return r; 
} 
 
static int CCIDEFindRuleYes(             /* Return rule number */
	int nbrrules, unsigned long ccide_table, unsigned long yes[]) 
{ 
        int r=0; 
        unsigned long nstate;
 
        nstate = UINT_MAX ^ ccide_table; 
        while ( (yes[r] & nstate) && ( ++r < nbrrules ) ) {}; 
        return r; 
} 
#endif /* End ifndef  __CCIDE_INLINE_C  */
/*END_GENERATED_CODE: */

static inline void MisMatch() {
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
	//   4  6  7  8  9 10 11  - |TOS==$$ 
	// ________________________________________
	//   X  -  -  -  -  -  -  - | Pop();  
	//   -  X  X  X  X  X  X  - | PopToQueue();
	//   -  X  X  X  X  X  X  - | goto $@;
	//   2  -  -  -  -  -  -  9 | return $$;  
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_1.
	//	8 Rules, 7 conditions, and 5 actions.
	 { CCIDE_TABLE_1: switch(TOS) {	
		case 4:		//  Rule  1  
		    Pop();
		    return 2;
		    break;
		case 6:		//  Rule  2  
		case 7:		//  Rule  3  
		case 8:		//  Rule  4  
		case 9:		//  Rule  5  
		case 10:		//  Rule  6  
		case 11:		//  Rule  7  
		    PopToQueue();
		    goto CCIDE_TABLE_1 ;
		 default:		//  Rule  8  
		    return 9;
		    break;
	 }
	}
	//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.4-1  

}

//            Until the token at the top of the stack is a left parenthesis, pop operators off the stack onto the output queue. 
// If no left parentheses are encountered, either the separator was misplaced or parentheses were mismatched.
// TOS: 0-EMPTY, 4-LEFT_PAREN, 6-OPERATOR
static STATE FindLeft() {

	//DECISION_TABLE:    /* Check Stack */
	//   0  4  6 |TOS==$$  
	// _______________
	//   -  -  X | PopToQueue();
	//   -  -  X | goto $@;
	//   9  2  - | return $$; 
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_2.
	//	3 Rules, 3 conditions, and 4 actions.
	 { CCIDE_TABLE_2: switch(TOS) {	
		case 4:		//  Rule  2  
		    return 2;
		    break;
		case 0:		//  Rule  1  
		    return 9;
		    break;
		case 6:		//  Rule  3  
		    PopToQueue();
		    goto CCIDE_TABLE_2 ;
	 }
	}
	//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.6.4-1  

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
	//   9  -  0  0  0  0  0  1  1  1  1  1 | s==$$
	//   -  -  7  8  9 10 11  7  8  9 10 11 | TOS==$$
	//  ____________________________________________________
	//   -  -  X  X  X  X  X  -  -  -  -  - | PopToQueue(); 
	//   X  -  X  X  X  X  X  -  -  -  -  - | s=GetPrecedence(); 
	//   X  -  X  X  X  X  X  -  -  -  -  - | goto $@; 
	//   -  2  -  -  -  -  -  2  2  2  2  2 | return $$;
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_3.
	//	12 Rules, 8 conditions, and 4 actions.
	//	Table 3 rule order = 3 4 5 6 7 8 9 10 11 12 1 2 
	 {	unsigned long CCIDE_table3_yes[12]={  10UL,  18UL,  34UL,  66UL, 130UL,  12UL,  20UL,  36UL,  68UL, 132UL,   1UL,   0UL};

	CCIDE_TABLE_3:
		switch(CCIDEFindRuleYes(12,
			  (s==9)
			| (s==0)<<1
			| (s==1)<<2
			| (TOS==7)<<3
			| (TOS==8)<<4
			| (TOS==9)<<5
			| (TOS==10)<<6
			| (TOS==11)<<7
			  ,CCIDE_table3_yes)) {
		case  5:	//	Rule  8 
		case  6:	//	Rule  9 
		case  7:	//	Rule 10 
		case  8:	//	Rule 11 
		case  9:	//	Rule 12 
		case 11:	//	Rule  2 
		    return 2;
		    break;
		case  0:	//	Rule  3 
		case  1:	//	Rule  4 
		case  2:	//	Rule  5 
		case  3:	//	Rule  6 
		case  4:	//	Rule  7 
		    PopToQueue();
		case 10:	//	Rule  1 
		    s=GetPrecedence();
		    goto CCIDE_TABLE_3 ;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_3, by ccide-0.6.4-1  

}

// 1-number, 2-function token, 3-function argument separator (e.g. a comma) 9=no more tokens // 4=LEFT_PAREN, 5=RIGHT_PAREN, 6=OPERATOR

static void ParseInput() {   
	STATE s=0;
	TOKEN_TYPE token;

	//DECISION_TABLE:    Test dropping empty rules.
	//   -  0  2  -  2  2  2  2  2  - | s==$$
	//   -  -  1  -  2  3  4  5  6  - | token==$$   
	// _____________________________
	//   -  -  -  -  -  -  -  -  -  - |s=FindLeft();
	//   -  -  -  -  -  -  -  X  -  - |s=DoRightParen();
	//   -  -  -  -  -  -  -  -  X  - |s=DoOperator();
	//   -  -  -  -  X  -  X  -  X  - |PushToken();
	//   -  -  X  -  -  -  -  -  -  - |OutputNumber();
	//   -  2  -  -  -  -  -  -  -  - |s=$$;
	//   -  X  X  -  X  -  X  X  X  - |token=GetToken();
	//   -  X  X  -  X  -  X  X  X  - |goto $@;
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_4.
	//WARNING: Dropping rule 10 in table 4. 
	//WARNING: Dropping rule 4 in table 4. 
	//WARNING: Dropping rule 1 in table 4. 
	//	7 Rules, 8 conditions, and 8 actions.
	//	Table 4 rule order = 3 5 6 7 8 9 2 
	 {	unsigned long CCIDE_table4_yes[7]={   6UL,  10UL,  18UL,  34UL,  66UL, 130UL,   1UL};

	CCIDE_TABLE_4:
		switch(CCIDEFindRuleYes(7,
			  (s==0)
			| (s==2)<<1
			| (token==1)<<2
			| (token==2)<<3
			| (token==3)<<4
			| (token==4)<<5
			| (token==5)<<6
			| (token==6)<<7
			  ,CCIDE_table4_yes)) {
		case  6:	//	Rule  2 
		    s=2;
		    token=GetToken();
		    goto CCIDE_TABLE_4 ;
		case  0:	//	Rule  3 
		    OutputNumber();
		    token=GetToken();
		    goto CCIDE_TABLE_4 ;
		case  5:	//	Rule  9 
		    s=DoOperator();
		case  1:	//	Rule  5 
		case  3:	//	Rule  7 
		    PushToken();
		    token=GetToken();
		    goto CCIDE_TABLE_4 ;
		case  4:	//	Rule  8 
		    s=DoRightParen();
		    token=GetToken();
		    goto CCIDE_TABLE_4 ;
		case  2:	//	Rule  6 
		    break;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_4, by ccide-0.6.4-1  


			// 0=EMPTY, 1=LEFT_PAREN, 2=RIGHT_PAREN

	    //DECISION_TABLE:    	/* No more input tokens */
	    //   1  2  5  7  8  9 10 11  - | TOS==$$    
	    // _____________________|____________
	    //   X  X  X  X  X  X  X  X  X | // Test comment
	    //   X  -  X  -  -  -  -  -  - | MisMatch();        
	    //   -  X  -  X  X  X  X  X  - | PopToQueue();
	    //   X  X  X  X  X  X  X  X  - | goto $@;  
	    //   -  -  -  -  -  -  -  -  X | printf("\n");
	    //END_TABLE:
	    //GENERATED_CODE: FOR TABLE_5.
	    //	9 Rules, 8 conditions, and 5 actions.
	     { CCIDE_TABLE_5: switch(TOS) {	
	    	case 2:		//  Rule  2  
	    	case 7:		//  Rule  4  
	    	case 8:		//  Rule  5  
	    	case 9:		//  Rule  6  
	    	case 10:		//  Rule  7  
	    	case 11:		//  Rule  8  
	    	    // Test comment
	    	    PopToQueue();
	    	    goto CCIDE_TABLE_5 ;
	    	case 1:		//  Rule  1  
	    	case 5:		//  Rule  3  
	    	    // Test comment
	    	    MisMatch();
	    	    goto CCIDE_TABLE_5 ;
	    	 default:		//  Rule  9  
	    	    // Test comment
	    	    printf("\n");
	    	    break;
	     }
	    }
	    //END_GENERATED_CODE: FOR TABLE_5, by ccide-0.6.4-1  

}

int main(int argc, char **argv) {

	TOS=EMPTY; 
	//DECISION_TABLE:
	//   -  Y | token==SEPARATOR
	// _______|_________________
	//   -  X | token=EMPTY; ParseInput();
	//   -  X | goto $@;
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_6.
	//WARNING: Dropping rule 1 in table 6. 
	//	1 Rules, 1 conditions, and 2 actions.

	CCIDE_TABLE_6:	if( (token==SEPARATOR) )  {
	   token=EMPTY; ParseInput();
	   goto CCIDE_TABLE_6 ;
	}
	//END_GENERATED_CODE: FOR TABLE_6, by ccide-0.6.4-1  

	return 0;

}
