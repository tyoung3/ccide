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

#ifndef _CCIDE__H		/* ccide.h */
#define _CCIDE__H

#include "ccideconfig.h"

/* Define equal condition to eliminate '=' errors in conditionals: */
#define AEQ(A,B,C,D,E) (A)==((B)=C(D,E))   
#define ISA_SUBSTR(A,B) AEQ(NULL,(A),strstr, c1, (B) )
// EX:  if(IS_SUBSTR(s1,svar1) )  // s1 = return from strstr  
//      if ((s1 = strstr (c1, svar1)) == NULL)

typedef unsigned int CCIDE_BIT; 
extern int ccide_group;
extern int CCIDEFindRule(int nbrrules, unsigned long, unsigned long yes[], unsigned long no[]);
extern int CCIDEFindRuleYes(int nbrrules, unsigned long, unsigned long yes[]);
#endif  /* ifndef _CCIDE__H  */
