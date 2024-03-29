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

/* THISIS: simple.c.d */

#include <stdlib.h>
#include <stdio.h>

/*CCIDE_INLINE_CODE:*/
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
int a1() {}
int a2() {}
int a3() {}
main() {
	int c2=2,c3=2,c4;
	int swvar[3][3]={{2,3,4},{3,4,2},{4,3,0}};


		/* N.B.: abort() is never executed.*/
	/*DECISION_TABLE:				*/
	/*   2  3  4 | swvar[c2][c3] == $$			*/
	/*   -  -  - | abort()				*/
        /*  _____ | _______             		*/
	/*   -  -  - | abort()				*/
	/*   -  -  X | a1();				*/
	/*   1  2  3 | printf("Rule: %i\n", $$ );		*/
	/*   -  X  X | a2();				*/
	/*   X  X  - |NEWGROUP		*/
        /*END_TABLE:					*/
	/*GENERATED_CODE: FOR TABLE_1.*/
	/*	3 Rules, 3 conditions, and 7 actions.*/
	/*	Table 1 rule order = 1 2 3 */
	 {	unsigned long CCIDE_table1_yes[3]={   1UL,   2UL,   4UL};
		ccide_group=1;

	CCIDE_TABLE_1:
		switch(CCIDEFindRuleYes(3,
			  (swvar[c2][c3] == 2)
			| (swvar[c2][c3] == 3)<<1
			| (swvar[c2][c3] == 4)<<2
			  ,CCIDE_table1_yes)) {
		case  1:	/*	Rule  2 */
		    printf("Rule: %i\n", 2 );
		    a2();
		    goto CCIDE_TABLE_1;
		case  0:	/*	Rule  1 */
		    printf("Rule: %i\n", 1 );
		    goto CCIDE_TABLE_1;
		case  2:	/*	Rule  3 */
		    a1();
		    printf("Rule: %i\n", 3 );
		    a2();
		    break;
		} /* End Switch*/
	}
	/*END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0  */

	//DECISION_TABLE:
	//   Y  N  Y |c4
	//   -  N  Y |c2
	//   N  Y  - |c3
	//---|--
	//   -  -  X |a3();
	//   X  -  X |a1();
	//   X  X  - |a2();
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_2.
	//	3 Rules, 3 conditions, and 3 actions.
	//	Table 2 rule order = 2 3 1 
	 {	unsigned long CCIDE_table2_yes[3]={   4UL,   3UL,   1UL};
		unsigned long CCIDE_table2_no[3]= {   3UL,   0UL,   4UL};


		switch(CCIDEFindRule(3,
			  (c4)
			| (c2)<<1
			| (c3)<<2
			  ,CCIDE_table2_yes, CCIDE_table2_no)) {
		case  2:	//	Rule  1 
		    a1();
		case  0:	//	Rule  2 
		    a2();
		    break;
		case  1:	//	Rule  3 
		    a3();
		    a1();
		    break;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.7.0-0  



	return 0;
}
