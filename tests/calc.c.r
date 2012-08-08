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

/* THISIS: calc.c.d 7/19/2012 */

#include <stdlib.h>
#include <stdio.h>

typedef int REG;   	/* Register */
REG d, x, y;    	/* d=display */
typedef int BOOL;

char L[10][10]={"na","ENTER","TIMES","EQUAL","CLEAR","CLEAN_ENT","PLUS","STOP"};
typedef enum {clear=1,enter,times,equal,clear_ent,plus,stop} INPUTVAL; 
INPUTVAL INPUT;

#define CLEAR 		INPUT==clear
#define CLEAR_ENT 	INPUT==clear_ent
#define ENTER 		INPUT==enter
#define PLUS 		INPUT==plus
#define EQUAL 		INPUT==equal
#define STOP 		INPUT==stop
#define TIMES 		INPUT==times

//CCIDE_INLINE_CODE:
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.6.2-7
ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com 
The code generated by ccide is covered by the same license as the source  
code(decision table) from which it is derived. If you created the source,  
you are free to do anything you like with the generated code, 
including incorporating it into or linking it with proprietary software.  
*/ 
static int ccide_group=1; 
#ifndef UINT_MAX 
#include "limits.h" 
#endif  
 
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

static void ShowD() {
	static REG lastd=-98762029;

	if( d  != lastd ) {
		lastd=d;
		printf("D=%6.3i\n", d);
	}
}

#define SET(X) { INPUT=X;}
static void SetD(int n) {
	d=n; // ShowD();
        SET(enter);
}


static int state=0;
static void GetInput() {   /* Simulate user input */    /* 3 + 5 * 7 =  [38] */
	
	//DECISION_TABLE:
	//   0  1  2  3  4  5  6  7 | state==$$
	//_____________________________
	//   1  2  3  4  5  6  7  7 | state=$$;
	//   X  -  -  -  -  -  -  - | SET(clear)
	//   -  X  -  -  -  -  -  - | SetD(3);
	//   -  -  X  -  -  -  -  - | SET(plus)
	//   -  -  -  X  -  -  -  - | SetD(5);
	//   -  -  -  -  X  -  -  - | SET(times)
	//   -  -  -  -  -  X  -  - | SetD(7);
	//   -  -  -  -  -  -  X  - | SET(equal)
	//   -  -  -  -  -  -  -  X | SET(stop)
	//END_TABLE: 
	//GENERATED_CODE: FOR TABLE_1.
	//	8 Rules, 8 conditions, and 15 actions.
	 { CCIDE_TABLE_1: switch(state) {	
		case 7:		//  Rule  8  
		    state=7;
		    SET(stop)
		    break;
		case 6:		//  Rule  7  
		    state=7;
		    SET(equal)
		    break;
		case 5:		//  Rule  6  
		    state=6;
		    SetD(7);
		    break;
		case 4:		//  Rule  5  
		    state=5;
		    SET(times)
		    break;
		case 3:		//  Rule  4  
		    state=4;
		    SetD(5);
		    break;
		case 2:		//  Rule  3  
		    state=3;
		    SET(plus)
		    break;
		case 1:		//  Rule  2  
		    state=2;
		    SetD(3);
		    break;
		case 0:		//  Rule  1  
		    state=1;
		    SET(clear)
		    break;
	 }
	}
	//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.2-7  


}

static int mstate=1;

static void inline table2() {
//DECISION_TABLE:	
//   Y  -  -  - |CLEAR
//   -  Y  -  - |ENTER
//   -  -  Y  - |PLUS
//__________________________________________________________________________ 
//   X  X  X  X |//printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
//   -  -  X  - |y=x; x=d;  // Display changed in GetInput function
//   X  -  -  - |SetD(0);	 
//   X  -  -  - |ShowD();
//   X  X  X  - |GetInput();
//   X  X  -  - |goto $@;		
//END_TABLE: 
//GENERATED_CODE: FOR TABLE_2.
//	4 Rules, 3 conditions, and 6 actions.
//	Table 2 rule order = 1 2 3 4 
 {	unsigned long CCIDE_table2_yes[4]={   1UL,   2UL,   4UL,   0UL};

CCIDE_TABLE_2:
	switch(CCIDEFindRuleYes(4,
		  (CLEAR)
		| (ENTER)<<1
		| (PLUS)<<2
		  ,CCIDE_table2_yes)) {
	case  0:	//	Rule  1 
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    SetD(0);
	    ShowD();
	    GetInput();
	    goto CCIDE_TABLE_2 ;
	case  1:	//	Rule  2 
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    GetInput();
	    goto CCIDE_TABLE_2 ;
	case  2:	//	Rule  3 
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    y=x; x=d;  // Display changed in GetInput function
	    GetInput();
	    break;
	case  3:	//	Rule  4 
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.6.2-7  

}

static void inline table3() {
//DECISION_TABLE:	
//   1  2  3  - |INPUT==$$
//__________________________________________________________________________ 
//   X  X  X  X |//printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
//   -  X  -  - |y=x; x=d;  // Display changed in GetInput function
//   -  -  X  - |x+=d; 
//   -  -  X  - |x*=d; 
//   -  -  X  - |d=x;
//   -  -  X  - |SetD(x);	 
//   -  -  X  - |ShowD();
//   X  X  X  - |GetInput();
//   X  -  X  - |goto $@;
//   -  4  -  9 |mstate=$$;	
//END_TABLE: 
//GENERATED_CODE: FOR TABLE_3.
//	4 Rules, 3 conditions, and 11 actions.
 { CCIDE_TABLE_3: switch(INPUT) {	
	case 2:		//  Rule  2  
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    y=x; x=d;  // Display changed in GetInput function
	    GetInput();
	    mstate=4;
	    break;
	case 3:		//  Rule  3  
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    x+=d;
	    x*=d;
	    d=x;
	    SetD(x);
	    ShowD();
	    GetInput();
	    goto CCIDE_TABLE_3 ;
	case 1:		//  Rule  1  
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    GetInput();
	    goto CCIDE_TABLE_3 ;
	 default:		//  Rule  4  
	    //printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
	    mstate=9;
	    break;
 }
}
//END_GENERATED_CODE: FOR TABLE_3, by ccide-0.6.2-7  

}

int main(int argc, char **argv) {     
//DECISION_TABLE:
//   1  5  4  5  - |mstate==$$
//   -  Y  -  -  - |EQUAL
//   -  -  -  -  Y |STOP
//__________________________________________________________________________ 
//   X  X  X  X  X |//printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
//   -  -  -  -  - |y=x; x=d;  // Display changed in GetInput function
//   X  -  -  -  - |x=0;	 
//   X  -  -  -  - |y=0;
//   -  X  -  -  - |x*=d; 
//   -  X  -  -  - |x+=y;y=0;
//   -  X  -  -  - |d=x;
//   X  X  -  -  -SetD(  X); 
//   X  X  -  -  - |ShowD();//ERROR: 11 rules, instead of 5. 

//   X  X  X  X  - |GetInput();
//   2  2  -  -  - |table$$();
//   3  3  -  -  - |table$$();
//   -  -  5  -  - |mstate=$$;
//   X  X  X  X  - |goto $@;	

//END_TABLE: 
//GENERATED_CODE: FOR TABLE_4.
//	5 Rules, 5 conditions, and 13 actions.
//	Table 4 rule order = 2 1 4 3 5 
 {	unsigned long CCIDE_table4_yes[5]={  10UL,   1UL,   2UL,   4UL,  16UL};

CCIDE_TABLE_4:
	switch(CCIDEFindRuleYes(5,
		  (mstate==1)
		| (mstate==5)<<1
		| (mstate==4)<<2
		| (EQUAL)<<3
		| (STOP)<<4
		  ,CCIDE_table4_yes)) {
	case  3:	//	Rule  3 
	    //printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
	    GetInput();
	    mstate=5;
	    goto CCIDE_TABLE_4 ;
	case  0:	//	Rule  2 
	    //printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
	    x*=d;
	    x+=y;y=0;
	    d=x;
	    ShowD();
	    GetInput();
	    table2();
	    table3();
	    goto CCIDE_TABLE_4 ;
	case  1:	//	Rule  1 
	    //printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
	    x=0;
	    y=0;
	    ShowD();
	    GetInput();
	    table2();
	    table3();
	    goto CCIDE_TABLE_4 ;
	case  2:	//	Rule  4 
	    //printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
	    GetInput();
	    goto CCIDE_TABLE_4 ;
	case  4:	//	Rule  5 
	    //printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_4, by ccide-0.6.2-7  

 

	return 0;
}
