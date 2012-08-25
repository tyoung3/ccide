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
// Y - - |number > 0
// - Y - |number < 0
// - - Y |number == 0
//______________________
// X - - |sign = "positive";
// - X - |sign = "negative";  
// - - X |sign = "zero";	
//END_TABLE:

  cout<<number<< " is "<<sign<<endl;
  return 0;
}
