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

/* THISIS: elev.c.d twy 5/9/2002 
**
**  ELEV serves no purpose other than as an example of 
**  decision table processing -- including substition and NEWGROUP.
**
**
**  Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com.
*/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#ifdef CCIDE_LIB
#include <ccide.h>
#else
//CCIDE_INLINE_CODE:
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.7.0-0
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
#endif

static int Idle, Moving, AnybodyRiding;
static char c;
static int b;
 
static int AnybodyWaiting( char c ) {
	return 0;
}

void AdvanceClock() {}
void GoToFloor() {}
void Load() {}
void UnLoad(int x) {}
void DefaultRule() {}
void TestInt(int i) {}

void Act(int a, int b) {c=a+b;}
int Q1(int a) {b=a; return 0;}

int main(int argc, char **argv) {
	int a,b,c;
        char *strg[5] = {"a","b","c","d","e"};
        char *stri={"d"};

//DECISION_TABLE:
//    1   2   2   2   2   3   - |NEWGROUP		
//    0   -   2   -   -   4   1 |strcmp(strg[$$],stri) == 0
//    0   -   2   -   - 40000   1 |b == $$
//    Y   Y   Y   -   Y   -   N |Idle
//    -   -   -   N   -   -   Y |Moving
//    N   -   N   -   N   -   - |AnybodyWaiting(c)
//    N   Y   Y   -   Y   -   - |AnybodyRiding
//------------------------------------------------
//    -   X   -   -   -   -   - |GoToFloor();
//    X   -   -   -   -   -   - |AdvanceClock();
//   11  12   8   -   - 12345   - |a=$$;
//    1   1   2   3   2   -   - |Act($$,$$);
//    -   -   X   -   X   -   X |{ int x=2;  
//    -   -   X   -   X   -   X | UnLoad(x); printf("`date` 'abcd'\n"); 
//    -   -   X   -   X   -   X | Load(); }
//    -   -   -   -   -   X   - |assert(1==0); 
//    -   -   -   X   -   -   - |DefaultRule();
//    -   -   -   X   -   -   - |goto $@;
//    1   2   3   -   3   -   3 |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//	7 Rules, 15 conditions, and 19 actions.
//	Table 1 rule order = 1 3 5 7 2 6 4 
 {	unsigned long CCIDE_table1_yes[7]={2185UL,18706UL,18434UL,5184UL,18434UL, 548UL,   2UL};
	unsigned long CCIDE_table1_no[7]= {24576UL,8192UL,8192UL,2048UL,   0UL,   0UL,4096UL};
	ccide_group=1;

CCIDE_TABLE_1:
	switch(CCIDEFindRule(7,
		  (ccide_group == 1)
		| (ccide_group == 2)<<1
		| (ccide_group == 3)<<2
		| (strcmp(strg[0],stri) == 0)<<3
		| (strcmp(strg[2],stri) == 0)<<4
		| (strcmp(strg[4],stri) == 0)<<5
		| (strcmp(strg[1],stri) == 0)<<6
		| (b == 0)<<7
		| (b == 2)<<8
		| (b == 40000)<<9
		| (b == 1)<<10
		| (Idle)<<11
		| (Moving)<<12
		| (AnybodyWaiting(c))<<13
		| (AnybodyRiding)<<14
		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
	case  1:	//	Rule  3 
	    a=8;
	case  2:	//	Rule  5 
	    Act(2,2);
	case  3:	//	Rule  7 
	    { int x=2;
	    UnLoad(x); printf("`date` 'abcd'\n");
	    Load(); }
	    ccide_group = 3;
	    goto CCIDE_TABLE_1;
	case  4:	//	Rule  2 
	    GoToFloor();
	    a=12;
	    Act(1,1);
	    ccide_group = 2;
	    goto CCIDE_TABLE_1;
	case  0:	//	Rule  1 
	    AdvanceClock();
	    a=11;
	    Act(1,1);
	    ccide_group = 1;
	    goto CCIDE_TABLE_1;
	case  6:	//	Rule  4 
	    Act(3,3);
	    DefaultRule();
	    goto CCIDE_TABLE_1 ;
	case  5:	//	Rule  6 
	    a=12345;
	    assert(1==0);
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0  

	return 0;
}
