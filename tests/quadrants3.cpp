
/* QUADRANTS3.CPP 

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

/* THISIS: quadrant3.cpp.d */

#include <iostream>
using namespace std;
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

struct Point { int x,y; };
string get_location(Point p);
int main()
{
  
  const int N = 9; // number of points to test
  Point p[N] = 
  { 	
	{0,0},{1,1},{0,1},
	{-1,1},{-1,0},{-1,-1},
	{0,-1},{1,-1},{1,0}
  };
  
  for(int i = 0; i < N; i++) {
    cout << "Point (" << p[i].x << "," << p[i].y << ") is located: " 
         << get_location(p[i]) << endl;
  }
}
 
 string get_location(Point p)  { 
 string location = "I don't know";
 //DECISION_TABLE:
 //   Y  Y  Y  -  -  -  -  -  -  - | p.x >  0                          
 //   -  -  -  Y  Y  Y  -  -  -  - | p.x <  0 
 //   -  -  -  -  -  -  Y  Y  Y  - | p.x == 0 
 //   -  -  Y  -  -  Y  -  -  Y  - | p.y >  0                         
 //   -  Y  -  -  Y  -  -  Y  -  - | p.y <  0                       
 //   Y  -  -  Y  -  -  Y  -  -  - | p.y == 0                       
 //_________________________________________
 //   -  -  X  -  -  -  -  -  -  - | location = "Quadrant I";
 //   -  -  -  -  -  X  -  -  -  - | location = "Quadrant II";     
 //   -  -  -  -  X  -  -  -  -  - | location = "Quadrant III";       
 //   -  X  -  -  -  -  -  -  -  - | location = "Quadrant IV";         
 //   -  -  -  -  -  -  X  -  -  - | location = "Origin";              
 //   X  -  -  -  -  -  -  -  -  - | location = "X-Axis (Positive)";  
 //   -  -  -  X  -  -  -  -  -  - | location = "X-Axis (Negative)";   
 //   -  -  -  -  -  -  -  -  X  - | location = "Y-Axis (Positive)";  
 //   -  -  -  -  -  -  -  X  -  - | location = "Y-Axis (Negative)";
 //   -  -  -  -  -  -  -  -  -  X | location = "Program Failed; I still don't know which quadrant.";     
 //END_TABLE:   
 //GENERATED_CODE: FOR TABLE_1.
 //	10 Rules, 6 conditions, and 10 actions.
 //	Table 1 rule order = 3 2 1 6 5 4 9 8 7 10 
  {	unsigned long CCIDE_table1_yes[10]={   9UL,  17UL,  33UL,  10UL,  18UL,  34UL,  12UL,  20UL,  36UL,   0UL};


 	switch(CCIDEFindRuleYes(10,
 		  (p.x >  0)
 		| (p.x <  0)<<1
 		| (p.x == 0)<<2
 		| (p.y >  0)<<3
 		| (p.y <  0)<<4
 		| (p.y == 0)<<5
 		  ,CCIDE_table1_yes)) {
 	case  9:	//	Rule 10 
 	    location = "Program Failed; I still don't know which quadrant.";
 	    break;
 	case  7:	//	Rule  8 
 	    location = "Y-Axis (Negative)";
 	    break;
 	case  6:	//	Rule  9 
 	    location = "Y-Axis (Positive)";
 	    break;
 	case  5:	//	Rule  4 
 	    location = "X-Axis (Negative)";
 	    break;
 	case  2:	//	Rule  1 
 	    location = "X-Axis (Positive)";
 	    break;
 	case  8:	//	Rule  7 
 	    location = "Origin";
 	    break;
 	case  1:	//	Rule  2 
 	    location = "Quadrant IV";
 	    break;
 	case  4:	//	Rule  5 
 	    location = "Quadrant III";
 	    break;
 	case  3:	//	Rule  6 
 	    location = "Quadrant II";
 	    break;
 	case  0:	//	Rule  3 
 	    location = "Quadrant I";
 	    break;
 	} // End Switch
 }
 //END_GENERATED_CODE: FOR TABLE_1, by ccide-0.7.0-0  

  return location;
 }
 
