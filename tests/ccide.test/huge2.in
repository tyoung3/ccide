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
/* huge2  */

A1() {}
A2() {}
An() {}
//CCIDE_INLINE_CODE:
main() {
	int Q1,Q2,Q3,Q4,Q5,Q6;
// . . . . 5 . . . .10 . . . .15 . . . .20 . . . .25 . . . .30 . .            (Rule Number)  (15 & 16 overlap?)
//DECISION_TABLE:
// Y N Y N Y N Y N Y N Y N Y N Y - Y N Y N Y N Y N Y N Y N Y N Y N |Q1
// N N N N N N N N N N N N N N N - N N N N N N N N N N N N N N N N |Q2
// Y Y Y Y Y Y Y Y Y Y Y Y Y Y Y - N N N N N N N N N N N N N N N N |Q3
// Y Y N N Y Y N N Y Y N N Y Y N - Y Y N N Y Y N N Y Y N N Y Y N N |Q4
// Y Y Y Y N N N N Y Y Y Y N N N - Y Y Y Y N N N N Y Y Y Y N N N N |Q5
// Y Y Y Y Y Y Y Y N N N N N N N - Y Y Y Y Y Y Y Y N N N N N N N N |Q6
//-----------------
// x - x - x x - x - x x - x - x x - x - x x - x - x x - x - x x - |A2();
// x x x x x x x x x x x x x x x x - - - - - - - - - - - - - - - - |A1();
// x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x x |An();
//END_TABLE:

	return 0;
}
