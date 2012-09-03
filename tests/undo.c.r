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

/* THISIS: elev.c.d twy 5/9/2002 
**
**  ELEV serves no purpose other than as an example of 
**  decision table processing -- including substition and NEWGROUP.
**
**
**  Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com.
*/

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#ifdef CCIDE_LIB
#include <ccide.h>
#else
//CCIDE_INLINE_CODE:
#endif

static int Idle, Moving, AnybodyRiding;
static char c;
static int b;
 
static int AnybodyWaiting( char c ) {
	return 0;
}

void AdvanceClock() {}
void GoToFloor() {}
void Load() {}
void UnLoad(int x) {}
void DefaultRule() {}
void TestInt(int i) {}

void Act(int a, int b) {c=a+b;}
int Q1(int a) {b=a; return 0;}

int main(int argc, char **argv) {
	int a,b,c;
        char *strg[5] = {"a","b","c","d","e"};
        char *stri={"d"};

//DECISION_TABLE:
//   1  2  2  2  2  3  - |NEWGROUP		
//   0  -  2  -  -  4  1 |strcmp(strg[$$],stri) == 0
//   0  -  2  -  - 40000  1 |b == $$
//   Y  Y  Y  -  Y  -  N |Idle
//   -  -  -  N  -  -  Y |Moving
//   N  -  N  -  N  -  - |AnybodyWaiting(c)
//   N  Y  Y  -  Y  -  - |AnybodyRiding
//------------------------------------------------
//   -  X  -  -  -  -  - |GoToFloor();
//   X  -  -  -  -  -  - |AdvanceClock();
//  11 12  8  -  - 12345  - |a=$$;
//   1  1  2  3  2  -  - |Act($$,$$);
//   -  -  X  -  X  -  X |{ int x=2;  
//   -  -  X  -  X  -  X | UnLoad(x); printf("`date` 'abcd'\n"); 
//   -  -  X  -  X  -  X | Load(); }
//   -  -  -  -  -  X  - |assert(1==0); 
//   -  -  -  X  -  -  - |DefaultRule();
//   -  -  -  X  -  -  - |goto $@;
//   1  2  3  -  3  -  3 |NEWGROUP		
//END_TABLE:


	return 0;
}
