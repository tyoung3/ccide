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
/* THISIS: huge:  8/13/2004  twy
        Test ccide
*/
#include "stdlib.h"
#include "stdio.h"
#include "assert.h"
/*CCIDE_INLINE_CODE:*/
/*GENERATED_CODE: */
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*ccide-0.6.2-8
ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com 
The code generated by ccide is covered by the same license as the source  
code(decision table) from which it is derived. If you created the source,  
you are free to do anything you like with the generated code, 
including incorporating it into or linking it with proprietary software.  
*/ 
static int ccide_group=1; 
#ifndef UINT_MAX 
#include "limits.h" 
#endif  
 
		/* Return rule number */ 
static int CCIDEFindRule(
	int nbrrules,  unsigned long ccide_table, unsigned long yes[], unsigned long no[]){ 
        int r=0; 
        unsigned long nstate; 
 
        nstate = UINT_MAX ^ ccide_table; 
 
        while ( 
		( (yes[r] & nstate) || (no[r]  & ccide_table) ) 
		 && ( ++r < nbrrules )  
	) {}; 
 
        return r; 
} 
 
static int CCIDEFindRuleYes(             /* Return rule number */
	int nbrrules, unsigned long ccide_table, unsigned long yes[]) 
{ 
        int r=0; 
        unsigned long nstate;
 
        nstate = UINT_MAX ^ ccide_table; 
        while ( (yes[r] & nstate) && ( ++r < nbrrules ) ) {}; 
        return r; 
} 
#endif /* End ifndef  __CCIDE_INLINE_C  */
/*END_GENERATED_CODE: */
int main(int argc, char **argv) {
        int A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z;
	int AA,AB,AC,AD,AE,AF, x;
	int A1,A2,A3,A4,A5,A6,A7,A8,A9;
	int A10,A11,A12,A13,A14,A15,A16,A17,A18,A19;
	int A20,A21,A22,A23,A24,A25,A26,A27,A28,A29;
	int A30,A31,A32;

        for( x=1; x<33; x++) {
		//DECISION_TABLE:
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | x==$$
		//-----------------
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A1=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A2=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A3=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A4=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A5=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A6=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A7=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A8=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A9=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A10=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A11=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A12=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A13=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A14=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A15=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A16=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A17=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A18=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A19=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A20=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A21=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A22=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A23=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A24=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A25=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A26=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A27=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A28=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A29=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A30=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A31=$$;
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | A32=$$;
		//END_TABLE:
		//GENERATED_CODE: FOR TABLE_1.
		//	32 Rules, 32 conditions, and 1024 actions.
		 { CCIDE_TABLE_1: switch(x) {	
			case 32:		//  Rule 32  
			    A1=32;
			    A2=32;
			    A3=32;
			    A4=32;
			    A5=32;
			    A6=32;
			    A7=32;
			    A8=32;
			    A9=32;
			    A10=32;
			    A11=32;
			    A12=32;
			    A13=32;
			    A14=32;
			    A15=32;
			    A16=32;
			    A17=32;
			    A18=32;
			    A19=32;
			    A20=32;
			    A21=32;
			    A22=32;
			    A23=32;
			    A24=32;
			    A25=32;
			    A26=32;
			    A27=32;
			    A28=32;
			    A29=32;
			    A30=32;
			    A31=32;
			    A32=32;
			    break;
			case 31:		//  Rule 31  
			    A1=31;
			    A2=31;
			    A3=31;
			    A4=31;
			    A5=31;
			    A6=31;
			    A7=31;
			    A8=31;
			    A9=31;
			    A10=31;
			    A11=31;
			    A12=31;
			    A13=31;
			    A14=31;
			    A15=31;
			    A16=31;
			    A17=31;
			    A18=31;
			    A19=31;
			    A20=31;
			    A21=31;
			    A22=31;
			    A23=31;
			    A24=31;
			    A25=31;
			    A26=31;
			    A27=31;
			    A28=31;
			    A29=31;
			    A30=31;
			    A31=31;
			    A32=31;
			    break;
			case 30:		//  Rule 30  
			    A1=30;
			    A2=30;
			    A3=30;
			    A4=30;
			    A5=30;
			    A6=30;
			    A7=30;
			    A8=30;
			    A9=30;
			    A10=30;
			    A11=30;
			    A12=30;
			    A13=30;
			    A14=30;
			    A15=30;
			    A16=30;
			    A17=30;
			    A18=30;
			    A19=30;
			    A20=30;
			    A21=30;
			    A22=30;
			    A23=30;
			    A24=30;
			    A25=30;
			    A26=30;
			    A27=30;
			    A28=30;
			    A29=30;
			    A30=30;
			    A31=30;
			    A32=30;
			    break;
			case 29:		//  Rule 29  
			    A1=29;
			    A2=29;
			    A3=29;
			    A4=29;
			    A5=29;
			    A6=29;
			    A7=29;
			    A8=29;
			    A9=29;
			    A10=29;
			    A11=29;
			    A12=29;
			    A13=29;
			    A14=29;
			    A15=29;
			    A16=29;
			    A17=29;
			    A18=29;
			    A19=29;
			    A20=29;
			    A21=29;
			    A22=29;
			    A23=29;
			    A24=29;
			    A25=29;
			    A26=29;
			    A27=29;
			    A28=29;
			    A29=29;
			    A30=29;
			    A31=29;
			    A32=29;
			    break;
			case 28:		//  Rule 28  
			    A1=28;
			    A2=28;
			    A3=28;
			    A4=28;
			    A5=28;
			    A6=28;
			    A7=28;
			    A8=28;
			    A9=28;
			    A10=28;
			    A11=28;
			    A12=28;
			    A13=28;
			    A14=28;
			    A15=28;
			    A16=28;
			    A17=28;
			    A18=28;
			    A19=28;
			    A20=28;
			    A21=28;
			    A22=28;
			    A23=28;
			    A24=28;
			    A25=28;
			    A26=28;
			    A27=28;
			    A28=28;
			    A29=28;
			    A30=28;
			    A31=28;
			    A32=28;
			    break;
			case 27:		//  Rule 27  
			    A1=27;
			    A2=27;
			    A3=27;
			    A4=27;
			    A5=27;
			    A6=27;
			    A7=27;
			    A8=27;
			    A9=27;
			    A10=27;
			    A11=27;
			    A12=27;
			    A13=27;
			    A14=27;
			    A15=27;
			    A16=27;
			    A17=27;
			    A18=27;
			    A19=27;
			    A20=27;
			    A21=27;
			    A22=27;
			    A23=27;
			    A24=27;
			    A25=27;
			    A26=27;
			    A27=27;
			    A28=27;
			    A29=27;
			    A30=27;
			    A31=27;
			    A32=27;
			    break;
			case 26:		//  Rule 26  
			    A1=26;
			    A2=26;
			    A3=26;
			    A4=26;
			    A5=26;
			    A6=26;
			    A7=26;
			    A8=26;
			    A9=26;
			    A10=26;
			    A11=26;
			    A12=26;
			    A13=26;
			    A14=26;
			    A15=26;
			    A16=26;
			    A17=26;
			    A18=26;
			    A19=26;
			    A20=26;
			    A21=26;
			    A22=26;
			    A23=26;
			    A24=26;
			    A25=26;
			    A26=26;
			    A27=26;
			    A28=26;
			    A29=26;
			    A30=26;
			    A31=26;
			    A32=26;
			    break;
			case 25:		//  Rule 25  
			    A1=25;
			    A2=25;
			    A3=25;
			    A4=25;
			    A5=25;
			    A6=25;
			    A7=25;
			    A8=25;
			    A9=25;
			    A10=25;
			    A11=25;
			    A12=25;
			    A13=25;
			    A14=25;
			    A15=25;
			    A16=25;
			    A17=25;
			    A18=25;
			    A19=25;
			    A20=25;
			    A21=25;
			    A22=25;
			    A23=25;
			    A24=25;
			    A25=25;
			    A26=25;
			    A27=25;
			    A28=25;
			    A29=25;
			    A30=25;
			    A31=25;
			    A32=25;
			    break;
			case 24:		//  Rule 24  
			    A1=24;
			    A2=24;
			    A3=24;
			    A4=24;
			    A5=24;
			    A6=24;
			    A7=24;
			    A8=24;
			    A9=24;
			    A10=24;
			    A11=24;
			    A12=24;
			    A13=24;
			    A14=24;
			    A15=24;
			    A16=24;
			    A17=24;
			    A18=24;
			    A19=24;
			    A20=24;
			    A21=24;
			    A22=24;
			    A23=24;
			    A24=24;
			    A25=24;
			    A26=24;
			    A27=24;
			    A28=24;
			    A29=24;
			    A30=24;
			    A31=24;
			    A32=24;
			    break;
			case 23:		//  Rule 23  
			    A1=23;
			    A2=23;
			    A3=23;
			    A4=23;
			    A5=23;
			    A6=23;
			    A7=23;
			    A8=23;
			    A9=23;
			    A10=23;
			    A11=23;
			    A12=23;
			    A13=23;
			    A14=23;
			    A15=23;
			    A16=23;
			    A17=23;
			    A18=23;
			    A19=23;
			    A20=23;
			    A21=23;
			    A22=23;
			    A23=23;
			    A24=23;
			    A25=23;
			    A26=23;
			    A27=23;
			    A28=23;
			    A29=23;
			    A30=23;
			    A31=23;
			    A32=23;
			    break;
			case 22:		//  Rule 22  
			    A1=22;
			    A2=22;
			    A3=22;
			    A4=22;
			    A5=22;
			    A6=22;
			    A7=22;
			    A8=22;
			    A9=22;
			    A10=22;
			    A11=22;
			    A12=22;
			    A13=22;
			    A14=22;
			    A15=22;
			    A16=22;
			    A17=22;
			    A18=22;
			    A19=22;
			    A20=22;
			    A21=22;
			    A22=22;
			    A23=22;
			    A24=22;
			    A25=22;
			    A26=22;
			    A27=22;
			    A28=22;
			    A29=22;
			    A30=22;
			    A31=22;
			    A32=22;
			    break;
			case 21:		//  Rule 21  
			    A1=21;
			    A2=21;
			    A3=21;
			    A4=21;
			    A5=21;
			    A6=21;
			    A7=21;
			    A8=21;
			    A9=21;
			    A10=21;
			    A11=21;
			    A12=21;
			    A13=21;
			    A14=21;
			    A15=21;
			    A16=21;
			    A17=21;
			    A18=21;
			    A19=21;
			    A20=21;
			    A21=21;
			    A22=21;
			    A23=21;
			    A24=21;
			    A25=21;
			    A26=21;
			    A27=21;
			    A28=21;
			    A29=21;
			    A30=21;
			    A31=21;
			    A32=21;
			    break;
			case 20:		//  Rule 20  
			    A1=20;
			    A2=20;
			    A3=20;
			    A4=20;
			    A5=20;
			    A6=20;
			    A7=20;
			    A8=20;
			    A9=20;
			    A10=20;
			    A11=20;
			    A12=20;
			    A13=20;
			    A14=20;
			    A15=20;
			    A16=20;
			    A17=20;
			    A18=20;
			    A19=20;
			    A20=20;
			    A21=20;
			    A22=20;
			    A23=20;
			    A24=20;
			    A25=20;
			    A26=20;
			    A27=20;
			    A28=20;
			    A29=20;
			    A30=20;
			    A31=20;
			    A32=20;
			    break;
			case 19:		//  Rule 19  
			    A1=19;
			    A2=19;
			    A3=19;
			    A4=19;
			    A5=19;
			    A6=19;
			    A7=19;
			    A8=19;
			    A9=19;
			    A10=19;
			    A11=19;
			    A12=19;
			    A13=19;
			    A14=19;
			    A15=19;
			    A16=19;
			    A17=19;
			    A18=19;
			    A19=19;
			    A20=19;
			    A21=19;
			    A22=19;
			    A23=19;
			    A24=19;
			    A25=19;
			    A26=19;
			    A27=19;
			    A28=19;
			    A29=19;
			    A30=19;
			    A31=19;
			    A32=19;
			    break;
			case 18:		//  Rule 18  
			    A1=18;
			    A2=18;
			    A3=18;
			    A4=18;
			    A5=18;
			    A6=18;
			    A7=18;
			    A8=18;
			    A9=18;
			    A10=18;
			    A11=18;
			    A12=18;
			    A13=18;
			    A14=18;
			    A15=18;
			    A16=18;
			    A17=18;
			    A18=18;
			    A19=18;
			    A20=18;
			    A21=18;
			    A22=18;
			    A23=18;
			    A24=18;
			    A25=18;
			    A26=18;
			    A27=18;
			    A28=18;
			    A29=18;
			    A30=18;
			    A31=18;
			    A32=18;
			    break;
			case 17:		//  Rule 17  
			    A1=17;
			    A2=17;
			    A3=17;
			    A4=17;
			    A5=17;
			    A6=17;
			    A7=17;
			    A8=17;
			    A9=17;
			    A10=17;
			    A11=17;
			    A12=17;
			    A13=17;
			    A14=17;
			    A15=17;
			    A16=17;
			    A17=17;
			    A18=17;
			    A19=17;
			    A20=17;
			    A21=17;
			    A22=17;
			    A23=17;
			    A24=17;
			    A25=17;
			    A26=17;
			    A27=17;
			    A28=17;
			    A29=17;
			    A30=17;
			    A31=17;
			    A32=17;
			    break;
			case 16:		//  Rule 16  
			    A1=16;
			    A2=16;
			    A3=16;
			    A4=16;
			    A5=16;
			    A6=16;
			    A7=16;
			    A8=16;
			    A9=16;
			    A10=16;
			    A11=16;
			    A12=16;
			    A13=16;
			    A14=16;
			    A15=16;
			    A16=16;
			    A17=16;
			    A18=16;
			    A19=16;
			    A20=16;
			    A21=16;
			    A22=16;
			    A23=16;
			    A24=16;
			    A25=16;
			    A26=16;
			    A27=16;
			    A28=16;
			    A29=16;
			    A30=16;
			    A31=16;
			    A32=16;
			    break;
			case 15:		//  Rule 15  
			    A1=15;
			    A2=15;
			    A3=15;
			    A4=15;
			    A5=15;
			    A6=15;
			    A7=15;
			    A8=15;
			    A9=15;
			    A10=15;
			    A11=15;
			    A12=15;
			    A13=15;
			    A14=15;
			    A15=15;
			    A16=15;
			    A17=15;
			    A18=15;
			    A19=15;
			    A20=15;
			    A21=15;
			    A22=15;
			    A23=15;
			    A24=15;
			    A25=15;
			    A26=15;
			    A27=15;
			    A28=15;
			    A29=15;
			    A30=15;
			    A31=15;
			    A32=15;
			    break;
			case 14:		//  Rule 14  
			    A1=14;
			    A2=14;
			    A3=14;
			    A4=14;
			    A5=14;
			    A6=14;
			    A7=14;
			    A8=14;
			    A9=14;
			    A10=14;
			    A11=14;
			    A12=14;
			    A13=14;
			    A14=14;
			    A15=14;
			    A16=14;
			    A17=14;
			    A18=14;
			    A19=14;
			    A20=14;
			    A21=14;
			    A22=14;
			    A23=14;
			    A24=14;
			    A25=14;
			    A26=14;
			    A27=14;
			    A28=14;
			    A29=14;
			    A30=14;
			    A31=14;
			    A32=14;
			    break;
			case 13:		//  Rule 13  
			    A1=13;
			    A2=13;
			    A3=13;
			    A4=13;
			    A5=13;
			    A6=13;
			    A7=13;
			    A8=13;
			    A9=13;
			    A10=13;
			    A11=13;
			    A12=13;
			    A13=13;
			    A14=13;
			    A15=13;
			    A16=13;
			    A17=13;
			    A18=13;
			    A19=13;
			    A20=13;
			    A21=13;
			    A22=13;
			    A23=13;
			    A24=13;
			    A25=13;
			    A26=13;
			    A27=13;
			    A28=13;
			    A29=13;
			    A30=13;
			    A31=13;
			    A32=13;
			    break;
			case 12:		//  Rule 12  
			    A1=12;
			    A2=12;
			    A3=12;
			    A4=12;
			    A5=12;
			    A6=12;
			    A7=12;
			    A8=12;
			    A9=12;
			    A10=12;
			    A11=12;
			    A12=12;
			    A13=12;
			    A14=12;
			    A15=12;
			    A16=12;
			    A17=12;
			    A18=12;
			    A19=12;
			    A20=12;
			    A21=12;
			    A22=12;
			    A23=12;
			    A24=12;
			    A25=12;
			    A26=12;
			    A27=12;
			    A28=12;
			    A29=12;
			    A30=12;
			    A31=12;
			    A32=12;
			    break;
			case 11:		//  Rule 11  
			    A1=11;
			    A2=11;
			    A3=11;
			    A4=11;
			    A5=11;
			    A6=11;
			    A7=11;
			    A8=11;
			    A9=11;
			    A10=11;
			    A11=11;
			    A12=11;
			    A13=11;
			    A14=11;
			    A15=11;
			    A16=11;
			    A17=11;
			    A18=11;
			    A19=11;
			    A20=11;
			    A21=11;
			    A22=11;
			    A23=11;
			    A24=11;
			    A25=11;
			    A26=11;
			    A27=11;
			    A28=11;
			    A29=11;
			    A30=11;
			    A31=11;
			    A32=11;
			    break;
			case 10:		//  Rule 10  
			    A1=10;
			    A2=10;
			    A3=10;
			    A4=10;
			    A5=10;
			    A6=10;
			    A7=10;
			    A8=10;
			    A9=10;
			    A10=10;
			    A11=10;
			    A12=10;
			    A13=10;
			    A14=10;
			    A15=10;
			    A16=10;
			    A17=10;
			    A18=10;
			    A19=10;
			    A20=10;
			    A21=10;
			    A22=10;
			    A23=10;
			    A24=10;
			    A25=10;
			    A26=10;
			    A27=10;
			    A28=10;
			    A29=10;
			    A30=10;
			    A31=10;
			    A32=10;
			    break;
			case 9:		//  Rule  9  
			    A1=9;
			    A2=9;
			    A3=9;
			    A4=9;
			    A5=9;
			    A6=9;
			    A7=9;
			    A8=9;
			    A9=9;
			    A10=9;
			    A11=9;
			    A12=9;
			    A13=9;
			    A14=9;
			    A15=9;
			    A16=9;
			    A17=9;
			    A18=9;
			    A19=9;
			    A20=9;
			    A21=9;
			    A22=9;
			    A23=9;
			    A24=9;
			    A25=9;
			    A26=9;
			    A27=9;
			    A28=9;
			    A29=9;
			    A30=9;
			    A31=9;
			    A32=9;
			    break;
			case 8:		//  Rule  8  
			    A1=8;
			    A2=8;
			    A3=8;
			    A4=8;
			    A5=8;
			    A6=8;
			    A7=8;
			    A8=8;
			    A9=8;
			    A10=8;
			    A11=8;
			    A12=8;
			    A13=8;
			    A14=8;
			    A15=8;
			    A16=8;
			    A17=8;
			    A18=8;
			    A19=8;
			    A20=8;
			    A21=8;
			    A22=8;
			    A23=8;
			    A24=8;
			    A25=8;
			    A26=8;
			    A27=8;
			    A28=8;
			    A29=8;
			    A30=8;
			    A31=8;
			    A32=8;
			    break;
			case 7:		//  Rule  7  
			    A1=7;
			    A2=7;
			    A3=7;
			    A4=7;
			    A5=7;
			    A6=7;
			    A7=7;
			    A8=7;
			    A9=7;
			    A10=7;
			    A11=7;
			    A12=7;
			    A13=7;
			    A14=7;
			    A15=7;
			    A16=7;
			    A17=7;
			    A18=7;
			    A19=7;
			    A20=7;
			    A21=7;
			    A22=7;
			    A23=7;
			    A24=7;
			    A25=7;
			    A26=7;
			    A27=7;
			    A28=7;
			    A29=7;
			    A30=7;
			    A31=7;
			    A32=7;
			    break;
			case 6:		//  Rule  6  
			    A1=6;
			    A2=6;
			    A3=6;
			    A4=6;
			    A5=6;
			    A6=6;
			    A7=6;
			    A8=6;
			    A9=6;
			    A10=6;
			    A11=6;
			    A12=6;
			    A13=6;
			    A14=6;
			    A15=6;
			    A16=6;
			    A17=6;
			    A18=6;
			    A19=6;
			    A20=6;
			    A21=6;
			    A22=6;
			    A23=6;
			    A24=6;
			    A25=6;
			    A26=6;
			    A27=6;
			    A28=6;
			    A29=6;
			    A30=6;
			    A31=6;
			    A32=6;
			    break;
			case 5:		//  Rule  5  
			    A1=5;
			    A2=5;
			    A3=5;
			    A4=5;
			    A5=5;
			    A6=5;
			    A7=5;
			    A8=5;
			    A9=5;
			    A10=5;
			    A11=5;
			    A12=5;
			    A13=5;
			    A14=5;
			    A15=5;
			    A16=5;
			    A17=5;
			    A18=5;
			    A19=5;
			    A20=5;
			    A21=5;
			    A22=5;
			    A23=5;
			    A24=5;
			    A25=5;
			    A26=5;
			    A27=5;
			    A28=5;
			    A29=5;
			    A30=5;
			    A31=5;
			    A32=5;
			    break;
			case 4:		//  Rule  4  
			    A1=4;
			    A2=4;
			    A3=4;
			    A4=4;
			    A5=4;
			    A6=4;
			    A7=4;
			    A8=4;
			    A9=4;
			    A10=4;
			    A11=4;
			    A12=4;
			    A13=4;
			    A14=4;
			    A15=4;
			    A16=4;
			    A17=4;
			    A18=4;
			    A19=4;
			    A20=4;
			    A21=4;
			    A22=4;
			    A23=4;
			    A24=4;
			    A25=4;
			    A26=4;
			    A27=4;
			    A28=4;
			    A29=4;
			    A30=4;
			    A31=4;
			    A32=4;
			    break;
			case 3:		//  Rule  3  
			    A1=3;
			    A2=3;
			    A3=3;
			    A4=3;
			    A5=3;
			    A6=3;
			    A7=3;
			    A8=3;
			    A9=3;
			    A10=3;
			    A11=3;
			    A12=3;
			    A13=3;
			    A14=3;
			    A15=3;
			    A16=3;
			    A17=3;
			    A18=3;
			    A19=3;
			    A20=3;
			    A21=3;
			    A22=3;
			    A23=3;
			    A24=3;
			    A25=3;
			    A26=3;
			    A27=3;
			    A28=3;
			    A29=3;
			    A30=3;
			    A31=3;
			    A32=3;
			    break;
			case 2:		//  Rule  2  
			    A1=2;
			    A2=2;
			    A3=2;
			    A4=2;
			    A5=2;
			    A6=2;
			    A7=2;
			    A8=2;
			    A9=2;
			    A10=2;
			    A11=2;
			    A12=2;
			    A13=2;
			    A14=2;
			    A15=2;
			    A16=2;
			    A17=2;
			    A18=2;
			    A19=2;
			    A20=2;
			    A21=2;
			    A22=2;
			    A23=2;
			    A24=2;
			    A25=2;
			    A26=2;
			    A27=2;
			    A28=2;
			    A29=2;
			    A30=2;
			    A31=2;
			    A32=2;
			    break;
			case 1:		//  Rule  1  
			    A1=1;
			    A2=1;
			    A3=1;
			    A4=1;
			    A5=1;
			    A6=1;
			    A7=1;
			    A8=1;
			    A9=1;
			    A10=1;
			    A11=1;
			    A12=1;
			    A13=1;
			    A14=1;
			    A15=1;
			    A16=1;
			    A17=1;
			    A18=1;
			    A19=1;
			    A20=1;
			    A21=1;
			    A22=1;
			    A23=1;
			    A24=1;
			    A25=1;
			    A26=1;
			    A27=1;
			    A28=1;
			    A29=1;
			    A30=1;
			    A31=1;
			    A32=1;
			    break;
		 }
		}
		//END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.2-8  

		ccide_group=0;
		//DECISION_TABLE:
		//   0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 | ccide_group==$$
		// ___________________________________________________________
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 | assert(A$$==x);  printf(".");
		//   1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31 32 |NEWGROUP		
		//END_TABLE:
		//GENERATED_CODE: FOR TABLE_2.
		//	32 Rules, 32 conditions, and 65 actions.
		 { CCIDE_TABLE_2: switch(ccide_group) {	
			case 31:		//  Rule 32  
			    assert(A32==x);  printf(".");
			    ccide_group = 32;
			    goto CCIDE_TABLE_2;
			case 30:		//  Rule 31  
			    assert(A31==x);  printf(".");
			    ccide_group = 31;
			    goto CCIDE_TABLE_2;
			case 29:		//  Rule 30  
			    assert(A30==x);  printf(".");
			    ccide_group = 30;
			    goto CCIDE_TABLE_2;
			case 28:		//  Rule 29  
			    assert(A29==x);  printf(".");
			    ccide_group = 29;
			    goto CCIDE_TABLE_2;
			case 27:		//  Rule 28  
			    assert(A28==x);  printf(".");
			    ccide_group = 28;
			    goto CCIDE_TABLE_2;
			case 26:		//  Rule 27  
			    assert(A27==x);  printf(".");
			    ccide_group = 27;
			    goto CCIDE_TABLE_2;
			case 25:		//  Rule 26  
			    assert(A26==x);  printf(".");
			    ccide_group = 26;
			    goto CCIDE_TABLE_2;
			case 24:		//  Rule 25  
			    assert(A25==x);  printf(".");
			    ccide_group = 25;
			    goto CCIDE_TABLE_2;
			case 23:		//  Rule 24  
			    assert(A24==x);  printf(".");
			    ccide_group = 24;
			    goto CCIDE_TABLE_2;
			case 22:		//  Rule 23  
			    assert(A23==x);  printf(".");
			    ccide_group = 23;
			    goto CCIDE_TABLE_2;
			case 21:		//  Rule 22  
			    assert(A22==x);  printf(".");
			    ccide_group = 22;
			    goto CCIDE_TABLE_2;
			case 20:		//  Rule 21  
			    assert(A21==x);  printf(".");
			    ccide_group = 21;
			    goto CCIDE_TABLE_2;
			case 19:		//  Rule 20  
			    assert(A20==x);  printf(".");
			    ccide_group = 20;
			    goto CCIDE_TABLE_2;
			case 18:		//  Rule 19  
			    assert(A19==x);  printf(".");
			    ccide_group = 19;
			    goto CCIDE_TABLE_2;
			case 17:		//  Rule 18  
			    assert(A18==x);  printf(".");
			    ccide_group = 18;
			    goto CCIDE_TABLE_2;
			case 16:		//  Rule 17  
			    assert(A17==x);  printf(".");
			    ccide_group = 17;
			    goto CCIDE_TABLE_2;
			case 15:		//  Rule 16  
			    assert(A16==x);  printf(".");
			    ccide_group = 16;
			    goto CCIDE_TABLE_2;
			case 14:		//  Rule 15  
			    assert(A15==x);  printf(".");
			    ccide_group = 15;
			    goto CCIDE_TABLE_2;
			case 13:		//  Rule 14  
			    assert(A14==x);  printf(".");
			    ccide_group = 14;
			    goto CCIDE_TABLE_2;
			case 12:		//  Rule 13  
			    assert(A13==x);  printf(".");
			    ccide_group = 13;
			    goto CCIDE_TABLE_2;
			case 11:		//  Rule 12  
			    assert(A12==x);  printf(".");
			    ccide_group = 12;
			    goto CCIDE_TABLE_2;
			case 10:		//  Rule 11  
			    assert(A11==x);  printf(".");
			    ccide_group = 11;
			    goto CCIDE_TABLE_2;
			case 9:		//  Rule 10  
			    assert(A10==x);  printf(".");
			    ccide_group = 10;
			    goto CCIDE_TABLE_2;
			case 8:		//  Rule  9  
			    assert(A9==x);  printf(".");
			    ccide_group = 9;
			    goto CCIDE_TABLE_2;
			case 7:		//  Rule  8  
			    assert(A8==x);  printf(".");
			    ccide_group = 8;
			    goto CCIDE_TABLE_2;
			case 6:		//  Rule  7  
			    assert(A7==x);  printf(".");
			    ccide_group = 7;
			    goto CCIDE_TABLE_2;
			case 5:		//  Rule  6  
			    assert(A6==x);  printf(".");
			    ccide_group = 6;
			    goto CCIDE_TABLE_2;
			case 4:		//  Rule  5  
			    assert(A5==x);  printf(".");
			    ccide_group = 5;
			    goto CCIDE_TABLE_2;
			case 3:		//  Rule  4  
			    assert(A4==x);  printf(".");
			    ccide_group = 4;
			    goto CCIDE_TABLE_2;
			case 2:		//  Rule  3  
			    assert(A3==x);  printf(".");
			    ccide_group = 3;
			    goto CCIDE_TABLE_2;
			case 1:		//  Rule  2  
			    assert(A2==x);  printf(".");
			    ccide_group = 2;
			    goto CCIDE_TABLE_2;
			case 0:		//  Rule  1  
			    assert(A1==x);  printf(".");
			    ccide_group = 1;
			    goto CCIDE_TABLE_2;
		 }
		}
		//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.6.2-8  
	} /* End For */
	printf("\n ccide_group=%li", ccide_group);
	return 0;
}