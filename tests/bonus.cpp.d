/*  	ccide - C Language Decision Table Code Generator 
	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com


   BONUS.CPP.D
	Copyright 2012, David Topham, d t opham@gm ail. c om
	Used here by permission.

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
//CCIDE_INLINE_CODE:
#include <iostream>
using namespace std;
struct Emp
{
	int dept;
	int dep;
	int id;
};
const int N = 8;
int get_bonus( Emp e )
{
  int bonus = 0;
/*  manually coded version
if e.dept != 2 and e.dep > 5 and e.id <= 800  bonus = 1000;
else if e.dept == 2 and e.dep <= 5 and e.id <= 800  bonus = 200;
else bonus = 100;
*/

/* The small table and the big table are logically equivalent. twy */	
#ifndef USE_BIG_TABLE
//DECISION_TABLE:
//  Y - N  | e.dept == 2
//  N - Y  | e.dep > 5
//  N - N  | e.id > 800
//______________________
//  - X -  | bonus = 100;
//  X - -  | bonus = 200; 
//  - - X  | bonus = 1000;	
//END_TABLE:
#else
//DECISION_TABLE:
// Y Y Y Y N N N N | e.dept == 2
// Y Y N N Y Y N N | e.dep > 5
// Y N Y N Y N Y N | e.id > 800
//______________________
// X X X - X - X X | bonus = 100;
// - - - X - - - - | bonus = 200; 
// - - - - - X - - | bonus = 1000;	
//END_TABLE:	
#endif

  return bonus;
}
int main ()
{
  Emp e[N] = { {2,6,900},{2,6,700},{2,4,850},{2,5,750},
               {1,10,950},{1,9,775},{1,3,975},{1,1,1}  
	     };
  cout<<"Testing Emplyee bonus plan decision table... " << endl;
  
  for( int i = 0; i < N; i++ )
  {	  
    cout << "Emp:" << i+1 << '\t' << "Bonus is $" 
	 << get_bonus(e[i]) << endl;
  }
  return 0;
}
