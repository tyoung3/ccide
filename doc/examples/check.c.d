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

//DECISION_TABLE:   CHECK 15(seconds to compile on a 360/50)
// Y N N N N | C01
// - Y N N N | C02
// - - Y N N | C03
// - - - Y N | C04
//________________
// - - - - 5 | A01;
// - 1 1 1 1 | A02;
// - 2 2 2 2 | A03;
// - 3 - 6 6 | A04;
// - 4 4 7 7 | A05;
// - - 3 3 3 | A06;
// - - - 4 4 | A07;
// - - - 5 5 | A08;
// 1 - - - - | A09;
// X X X X X | X01;
//END_TABLE:


