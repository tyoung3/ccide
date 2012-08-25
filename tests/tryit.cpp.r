
/*  TRYIT.CPP	
	 
	Copyright (C) 2012;  David Topham.  Used by permission.

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

/* THISIS: tryit.cpp.d */

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
#include <iostream>
using namespace std;
int main ()
{
  double number;
  cout<<"Enter a number ";
  cin>>number;
  string sign;

/*  manually coded version
if( number > 0) sign = "positive";
else if (number<0) sign = "negative";
else sign = "zero";
*/

//DECISION_TABLE:
//    Y   -   - |number > 0
//    -   Y   - |number < 0
//    -   -   Y |number == 0
//______________________
//    X   -   - |sign = "positive";
//    -   X   - |sign = "negative";  
//    -   -   X |sign = "zero";	
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//	3 Rules, 3 conditions, and 3 actions.
//	Table 1 rule order = 1 2 3 
 {	unsigned long CCIDE_table1_yes[3]={   1UL,   2UL,   4UL};


	switch(CCIDEFindRuleYes(3,
		  (number > 0)
		| (number < 0)<<1
		| (number == 0)<<2
		  ,CCIDE_table1_yes)) {
	case  2:	//	Rule  3 
	    sign = "zero";
	    break;
	case  1:	//	Rule  2 
	    sign = "negative";
	    break;
	case  0:	//	Rule  1 
	    sign = "positive";
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.5-1  

  cout<<number<< " is "<<sign<<endl;
  return 0;
}
