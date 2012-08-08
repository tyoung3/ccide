/*      ccide - C Language Decision Table Code Generator 
	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

   DEPETER.C 
	from http://stackoverflow.com/questions/5101879/how-to-start-working-with-a-large-decision-table
	Permission requested.


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

#include <stdio.h>

int IsHuman=1, IsPirate=1, IsForeigner=1, IsFarmer=0;
int HasARecord=0,IsKnownByFBI=0, IsKnownByCSI=0, HasChildren=0;
int IsPolitician=0, IsGeek=0;

#define A(M) printf("%s ",#M);
#define C(Q) Q==1

//CCIDE_INLINE_CODE:
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.6.2-8
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
int main(int argc, char** argv) {

//DECISION_TABLE:
//   Y  Y  N  -  -  -  - |C(IsHuman)
//   -  -  N  -  -  Y  - |C(IsForeigner)
//   -  Y  N  Y  Y  -  Y |C(IsPirate)
//   -  -  N  -  -  -  - |C(IsFarmer)
//   -  -  Y  -  -  -  - |C(HasARecord)
//   -  -  Y  -  -  -  - |C(IsKnownByFBI)
//   -  -  N  -  -  -  - |C(IsKnownByCSI)
//   -  -  N  -  -  -  - |C(HasChildren)
//   -  N  -  -  Y  -  - |C(IsPolitician)
//   -  -  -  Y  Y  -  - |C(IsGeek)
//______________________

//   X  -  -  -  X  -  - |A(CanStart);
//   X  -  -  X  X  X  X |A(CanBuyCar);
//   X  -  -  -  -  X  - |A(CanGetJob);
//   X  X  X  -  -  -  X |A(CanBeEvicted);
//   X  -  X  -  -  X  X |A(MustPayTaxes);
//   1  2  3  4  5  6  7 |printf(" according to rule $$, table 1\n");
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1.
//	7 Rules, 10 conditions, and 12 actions.
//	Table 1 rule order = 3 2 5 4 1 6 7 
 {	unsigned long CCIDE_table1_yes[7]={  48UL,   5UL, 772UL, 516UL,   1UL,   2UL,   4UL};
	unsigned long CCIDE_table1_no[7]= { 207UL, 256UL,   0UL,   0UL,   0UL,   0UL,   0UL};


	switch(CCIDEFindRule(7,
		  (C(IsHuman))
		| (C(IsForeigner))<<1
		| (C(IsPirate))<<2
		| (C(IsFarmer))<<3
		| (C(HasARecord))<<4
		| (C(IsKnownByFBI))<<5
		| (C(IsKnownByCSI))<<6
		| (C(HasChildren))<<7
		| (C(IsPolitician))<<8
		| (C(IsGeek))<<9
		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
	case  6:	//	Rule  7 
	    A(CanBuyCar);
	    A(CanBeEvicted);
	    A(MustPayTaxes);
	    printf(" according to rule 7, table 1\n");
	    break;
	case  5:	//	Rule  6 
	    A(CanBuyCar);
	    A(CanGetJob);
	    A(MustPayTaxes);
	    printf(" according to rule 6, table 1\n");
	    break;
	case  2:	//	Rule  5 
	    A(CanStart);
	    A(CanBuyCar);
	    printf(" according to rule 5, table 1\n");
	    break;
	case  3:	//	Rule  4 
	    A(CanBuyCar);
	    printf(" according to rule 4, table 1\n");
	    break;
	case  0:	//	Rule  3 
	    A(CanBeEvicted);
	    A(MustPayTaxes);
	    printf(" according to rule 3, table 1\n");
	    break;
	case  1:	//	Rule  2 
	    A(CanBeEvicted);
	    printf(" according to rule 2, table 1\n");
	    break;
	case  4:	//	Rule  1 
	    A(CanStart);
	    A(CanBuyCar);
	    A(CanGetJob);
	    A(CanBeEvicted);
	    A(MustPayTaxes);
	    printf(" according to rule 1, table 1\n");
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.2-8  


//DECISION_TABLE:
//   -  -  -  Y  Y  -  - |C(IsGeek)
//   -  N  -  -  Y  -  - |C(IsPolitician)
//   -  -  N  -  -  -  - |C(HasChildren)
//   -  -  N  -  -  -  - |C(IsKnownByCSI)
//   -  -  Y  -  -  -  - |C(IsKnownByFBI)
//   -  -  Y  -  -  -  - |C(HasARecord)
//   -  -  N  -  -  -  - |C(IsFarmer)
//   -  Y  N  Y  Y  -  Y |C(IsPirate)
//   -  -  N  -  -  Y  - |C(IsForeigner)
//   Y  Y  N  -  -  -  - |C(IsHuman)
//___________________________________

//   X  -  -  -  X  -  - |A(CanStart);
//   X  -  -  X  X  X  X |A(CanBuyCar);
//   X  -  -  -  -  X  - |A(CanGetJob);
//   X  X  X  -  -  -  X |A(CanBeEvicted);
//   X  -  X  -  -  X  X |A(MustPayTaxes);
//   1  2  3  4  5  6  7 |printf(" according to rule $$, table 2\n");
//END_TABLE:
//GENERATED_CODE: FOR TABLE_2.
//	7 Rules, 10 conditions, and 12 actions.
//	Table 2 rule order = 3 5 2 4 7 6 1 
 {	unsigned long CCIDE_table2_yes[7]={  48UL, 131UL, 640UL, 129UL, 128UL, 256UL, 512UL};
	unsigned long CCIDE_table2_no[7]= { 972UL,   0UL,   2UL,   0UL,   0UL,   0UL,   0UL};


	switch(CCIDEFindRule(7,
		  (C(IsGeek))
		| (C(IsPolitician))<<1
		| (C(HasChildren))<<2
		| (C(IsKnownByCSI))<<3
		| (C(IsKnownByFBI))<<4
		| (C(HasARecord))<<5
		| (C(IsFarmer))<<6
		| (C(IsPirate))<<7
		| (C(IsForeigner))<<8
		| (C(IsHuman))<<9
		  ,CCIDE_table2_yes, CCIDE_table2_no)) {
	case  4:	//	Rule  7 
	    A(CanBuyCar);
	    A(CanBeEvicted);
	    A(MustPayTaxes);
	    printf(" according to rule 7, table 2\n");
	    break;
	case  5:	//	Rule  6 
	    A(CanBuyCar);
	    A(CanGetJob);
	    A(MustPayTaxes);
	    printf(" according to rule 6, table 2\n");
	    break;
	case  1:	//	Rule  5 
	    A(CanStart);
	    A(CanBuyCar);
	    printf(" according to rule 5, table 2\n");
	    break;
	case  3:	//	Rule  4 
	    A(CanBuyCar);
	    printf(" according to rule 4, table 2\n");
	    break;
	case  0:	//	Rule  3 
	    A(CanBeEvicted);
	    A(MustPayTaxes);
	    printf(" according to rule 3, table 2\n");
	    break;
	case  2:	//	Rule  2 
	    A(CanBeEvicted);
	    printf(" according to rule 2, table 2\n");
	    break;
	case  6:	//	Rule  1 
	    A(CanStart);
	    A(CanBuyCar);
	    A(CanGetJob);
	    A(CanBeEvicted);
	    A(MustPayTaxes);
	    printf(" according to rule 1, table 2\n");
	    break;
	} // End Switch
}
//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.6.2-8  


	return 0;
}