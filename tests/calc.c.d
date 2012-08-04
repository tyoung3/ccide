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

/* THISIS: calc.c.d 7/19/2012 */

#include <stdlib.h>
#include <stdio.h>

typedef int REG;   	/* Register */
REG d, x, y;    	/* d=display */
typedef int BOOL;

char L[10][10]={"na","ENTER","TIMES","EQUAL","CLEAR","CLEAN_ENT","PLUS","STOP"};
typedef enum {clear=1,enter,times,equal,clear_ent,plus,stop} INPUTVAL; 
INPUTVAL INPUT;

#define CLEAR 		INPUT==clear
#define CLEAR_ENT 	INPUT==clear_ent
#define ENTER 		INPUT==enter
#define PLUS 		INPUT==plus
#define EQUAL 		INPUT==equal
#define STOP 		INPUT==stop
#define TIMES 		INPUT==times

//CCIDE_INLINE_CODE:

static void ShowD() {
	static REG lastd=-98762029;

	if( d  != lastd ) {
		lastd=d;
		printf("D=%6.3i\n", d);
	}
}

#define SET(X) { INPUT=X;}
static void SetD(int n) {
	d=n; // ShowD();
        SET(enter);
}


static int state=0;
static void GetInput() {   /* Simulate user input */    /* 3 + 5 * 7 =  [38] */
	
	//DECISION_TABLE:
	//  0 1 2 3 4 5 6 7 | state==$$
	//_____________________________
	//  1 2 3 4 5 6 7 7 | state=$$;
	//  X - - - - - - - | SET(clear)
	//  - X - - - - - - | SetD(3);
	//  - - X - - - - - | SET(plus)
	//  - - - X - - - - | SetD(5);
	//  - - - - X - - - | SET(times)
	//  - - - - - X - - | SetD(7);
	//  - - - - - - X - | SET(equal)
	//  - - - - - - - X | SET(stop)
	//END_TABLE: 


}

static int mstate=1;

static void inline table2() {
//DECISION_TABLE:	
//  Y - - - |CLEAR
//  - Y - - |ENTER
//  - - Y - |PLUS
//__________________________________________________________________________ 
//  X X X X |//printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
//  - - X - |y=x; x=d;  // Display changed in GetInput function
//  X - - - |SetD(0);	 
//  X - - - |ShowD();
//  X X X - |GetInput();
//  X X - - |goto $@;		
//END_TABLE: 

}

static void inline table3() {
//DECISION_TABLE:	
//  1 2 3 - |INPUT==$$
//__________________________________________________________________________ 
//  X X X X |//printf("State= ccide-group, I=%s, x=%i, y=%i, d=%i\n",L[INPUT], x,y,d);
//  - X - - |y=x; x=d;  // Display changed in GetInput function
//  - - X - |x+=d; 
//  - - X - |x*=d; 
//  - - X - |d=x;
//  - - X - |SetD(x);	 
//  - - X - |ShowD();
//  X X X - |GetInput();
//  X - X - |goto $@;
//  - 4 - 9 |mstate=$$;	
//END_TABLE: 

}

int main(int argc, char **argv) {     
//DECISION_TABLE:
//  1 5 4 5 - |mstate==$$
//  - Y - - - |EQUAL
//  - - - - Y |STOP
//__________________________________________________________________________ 
//  X X X X X |//printf("Mstate=%i, I=%s, x=%i, y=%i, d=%i\n",mstate, L[INPUT], x,y,d);
//  - - - - - |y=x; x=d;  // Display changed in GetInput function
//  X - - - - |x=0;	 
//  X - - - - |y=0;
//  - X - - - |x*=d; 
//  - X - - - |x+=y;y=0;
//  - X - - - |d=x;
//  X X - - - SetD(x);	 
//  X X - - - |ShowD();
//  X X X X - |GetInput();
//  2 2 - - - |table$$();
//  3 3 - - - |table$$();
//  - - 5 - - |mstate=$$;
//  X X X X - |goto $@;	

//END_TABLE: 

 

	return 0;
}
