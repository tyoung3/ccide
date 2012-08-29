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
 //   Y  Y  Y  -  -  -  -  -  - - | p.x >  0                          
 //   -  -  -  Y  Y  Y  -  -  - - | p.x <  0 
 //   -  -  -  -  -  -  Y  Y  Y - | p.x == 0 
 //   -  -  Y  -  -  Y  -  -  Y - | p.y >  0                         
 //   -  Y  -  -  Y  -  -  Y  - - | p.y <  0                       
 //   Y  -  -  Y  -  -  Y  -  - - | p.y == 0                       
 //_________________________________________
 //   -  -  X  -  -  -  -  -  - - | location = "Quadrant I";
 //   -  -  -  -  -  X  -  -  - - | location = "Quadrant II";     
 //   -  -  -  -  X  -  -  -  - - | location = "Quadrant III";       
 //   -  X  -  -  -  -  -  -  - - | location = "Quadrant IV";         
 //   -  -  -  -  -  -  X  -  - - | location = "Origin";              
 //   X  -  -  -  -  -  -  -  - - | location = "X-Axis (Positive)";  
 //   -  -  -  X  -  -  -  -  - - | location = "X-Axis (Negative)";   
 //   -  -  -  -  -  -  -  -  X - | location = "Y-Axis (Positive)";  
 //   -  -  -  -  -  -  -  X  - - | location = "Y-Axis (Negative)";
 //   -  -  -  -  -  -  -  -  - X | location = "Program Failed; I still don't know which quadrant.";     
 //END_TABLE:   

  return location;
 }
 
