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
/* THISIS: ccidetime */

#include <stdlib.h>

unsigned long count=0;
unsigned long max=1000;

//CCIDE_INLINE_CODE:
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.6.5-1
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

int main(int argc, char **argv) {

	if( argc>1 ) max = atol(argv[1]);

//DECISION_TABLE:
//   N  - | count>max
//-----------------
//   X  - | count++;
//   1  - |NEWGROUP		
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//WARNING: Dropping rule 2 in table 1. 
//	1 Rules, 1 conditions, and 3 actions.

CCIDE_TABLE_1:if( !(count>max) )  {
   count++;
   ccide_group = 1;
   goto CCIDE_TABLE_1;
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.5-1  

	return 0;
}

#if 0
[tyoung3@baja ccide]$ time ./ccidetime 10000000

real    0m2.932s
user    0m1.420s
sys     0m0.020s

[tyoung3@baja ccide]$ ric
"main"
"add_f"
"Starting yyparse"
10000000/2.932

3410641

#endif 
