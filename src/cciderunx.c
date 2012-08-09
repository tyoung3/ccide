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

/* cciderun.c  run time decision tables                                      */

#include <stdlib.h>
#include "ccide.h"
#include "ccideparse.h"
#include "parse.h"

#ifndef UINT_MAX
#include <limits.h>
#endif

int ccide_group = 1;

/** Return number of the first matching rule in a D/T.
 */
int
CCIDEFindRule (			/* Return rule number */
		int nbrrules,
		unsigned long ccide_table,
		unsigned long yes[], unsigned long no[])
{
  int r = 0;
  CCIDE_BIT nstate;

  nstate = UINT_MAX ^ ccide_table;

  while (((yes[r] & nstate) || (no[r] & ccide_table)) && (++r < nbrrules))
    {
    };

  return r;
}

/** Find first matching rule in a D/T, which has no 'N' condition entries.
 */
int
CCIDEFindRuleYes (		/* Return rule number */
		   int nbrrules,
		   unsigned long ccide_table, unsigned long yes[])
{
  int r = 0;
  CCIDE_BIT nstate;

  nstate = UINT_MAX ^ ccide_table;
  while ((yes[r] & nstate) && (++r < nbrrules))
    {
    };
  return r;
}

/* End of cciderun.c */
