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
//  Y N N N N | C01
//  - Y N N N | C02
//  - - Y N N | C03
//  - - - Y N | C04
// _________ | ___
//  X X X X X | X00;
//  - - - - X | A01;
//  - X X X X | A02;
//  - X X X X | A03;
//  - X - X X | A04;
//  - X X X X | A05;
//  - - X X X | A06;
//  - - - X X | A07;
//  - - - X X | A08;
//  X - - - - | A09;
//  X X X X X | X01;
//END_TABLE:
//GENERATED_CODE: FOR TABLE_1. 	5 Rules, 4 conditions, and 11 actions.
 {	CCIDE_BIT CCIDE_table1_yes[5]={   8UL,   4UL,   2UL,   1UL,   0UL};
	CCIDE_BIT CCIDE_table1_no[5]= {   7UL,   3UL,   1UL,   0UL,  15UL};

CCIDE_TABLE_1:
	switch(CcideFindRule(5,
		  (C01)
		| (C02)<<1
		| (C03)<<2
		| (C04)<<3
		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
	case 3:		//  Rule 1  
	     X00;
	     A09;
	     X01;
		break;
	case 4:		//  Rule 5  
	     X00;
	     A01;
	     A02;
	     A03;
	     A04;
	     A05;
	     A06;
	     A07;
	     A08;
	     X01;
		break;
	case 0:		//  Rule 4  
	     X00;
	     A02;
	     A03;
	     A04;
	     A05;
	     A06;
	     A07;
	     A08;
	     X01;
		break;
	case 1:		//  Rule 3  
	     X00;
	     A02;
	     A03;
	     A05;
	     A06;
	     X01;
		break;
	case 2:		//  Rule 2  
	     X00;
	     A02;
	     A03;
	     A04;
	     A05;
	     X01;
		break;
	} // End Switch 
}
//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.0.8-1 Tue Aug 24 21:27:34 2004
 

