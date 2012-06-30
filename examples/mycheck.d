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
 
//DECISION_TABLE:   MYCHECK
// Y N N N N | C01
// - Y N N N | C02
// - - Y N N | C03
// - - - Y N | C04
// _________ | ___
// X X X X X | X00;
// - - - - X | A01;
// - X X X X | A02;
// - X X X X | A03;
// - X - X X | A04;
// - X X X X | A05;
// - - X X X | A06;
// - - - X X | A07;
// - - - X X | A08;
// X - - - - | A09;
// X X X X X | X01;
//END_TABLE:
 

