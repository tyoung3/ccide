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


	return 0;
}
