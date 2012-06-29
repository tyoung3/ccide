/* cciderun.c  run time decision tables                                      */

/*         ccide - C Language Decision Table Code Generator                  */
/* Copyright (C) 2002-2010 Thomas W. Young, e-mail:  ccide@twyoung.com       */
/* This program is free software; you can redistribute it and/or modify      */
/* it under the terms of the GNU General Public License as published by      */
/* the Free Software Foundation.                                             */
/*                                                                           */
/* This program is distributed in the hope that it will be useful,           */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of            */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             */
/* GNU General Public License for more details.                              */
/*                                                                           */
/* You should have received a copy of the GNU General Public License         */
/* along with this program; if not, write to the Free Software               */
/* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                 */
/* ----------------------------------------------- end of legal stuff ------ */
 
#include "ccide.h"
#include <stdlib.h>

#ifndef UINT_MAX
#include <limits.h>
#endif


#include "ccideparse.h"
#include "parse.h"

int ccide_group=1;

int CCIDEFindRule(               /* Return rule number */
	int nbrrules,
	unsigned long ccide_table, 
	unsigned long yes[], 
	unsigned long no[]) 
{
	int r=0;
	CCIDE_BIT nstate;
	
	nstate = UINT_MAX ^ ccide_table;

        while (	
		( (yes[r] & nstate) || (no[r]  & ccide_table) )
		       &&
		 ( ++r < nbrrules )  
	) {};

	return r;
}

int CCIDEFindRuleYes(		/* Return rule number */
	int nbrrules,
        unsigned long ccide_table,
	unsigned long yes[] )
{
	int r=0;
	CCIDE_BIT nstate;
	
	nstate = UINT_MAX ^ ccide_table;
        while ( ( yes[r] & nstate)  && ( ++r < nbrrules ) ) {};
	return r;
}

/* End of cciderun.c */
