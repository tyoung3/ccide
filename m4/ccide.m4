ifelse(
  File ccide.m4
dnl  	ccide - C Language Decision Table Code Generator 
dnl	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
dnl
dnl   	This file is part of ccide, the C Language Decision Table Code Generator.
dnl
dnl   	Ccide is free software: you can redistribute it and/or modify
dnl   	it under the terms of the GNU General Public License as published by
dnl    	the Free Software Foundation, either version 3 of the License, or
dnl   	(at your option) any later version.
dnl
dnl    	Ccide is distributed in the hope that it will be useful,
dnl    	but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl    	GNU General Public License for more details.
dnl
dnl    	You should have received a copy of the GNU General Public License
dnl    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
dnl    	write to the Free Software Foundation, Inc., 51 Franklin St, 
dnl    	Fifth Floor, Boston, MA 02110-1301 USA.

  Convert text w/embedded macros to C output.
  
  USAGE:
	m4 -DLANG=C test.m4 skel.c.m4 > skel.c
	m4 -DLANG=CC test.m4 inc.cc.m4 > inc.cc

        XX=C | CC 

)dnl
define(`CCIDE_SWITCH',`switch(CcideFindRule($1,$2,CCIDE_table$3_yes, CCIDE_table$3_no)) {')dnl
define(`CCIDE_SWITCH_YES',`switch(CcideFindRuleYes($1,$2,CCIDE_table$3_yes)) {')dnl
define(`CCIDE_END_SWITCH',`} CCIDE_COMMENT(` End Switch')')dnl
define(`CCIDE_SWITCHX',`switch($1) {')dnl
define(`CCIDE_END_COND',
	`ifelse($1, `yesno', `,CCIDE_table1_yes, CCIDE_table1_no)) {',
			     `,CCIDE_table1_yes)) {')')dnl
define(`CCIDE_CASE',`CCIDE_LABEL(`CCIDE_$1_$2') case $2:	CCIDE_COMMENT(`	Rule $3')')dnl
define(`CCIDE_IF',`if(')dnl
define(`CCIDE_SAND',` && ')dnl
define(`CCIDE_TRUE',`($1)')dnl
define(`CCIDE_FALSE',`!($1)')dnl
define(`CCIDE_ENDCOND',`) {')dnl
define(`CCIDE_ENDIF',`}')dnl
define(`CCIDE_ACTION',`$1')dnl
define(`CCIDE_BREAK',`break;')dnl
define(`CCIDE_COND',`ifelse($1, `0',`($2)',`| ($2)<<$1')')dnl
define(`CCIDE_LABEL',`$1:')dnl
define(`CCIDE_GOTO',`goto $1;')dnl
define(`CCIDE_BEGIN_BLOCK',`{')dnl
define(`CCIDE_END_BLOCK',`}')dnl
define(`CCIDE_COMMENT',`//$@')dnl
define(`CCIDE_END_TABLE',`CCIDE_COMMENT(`GENERATED_CODE:') ')dnl
define(`CCIDE_int_C',`	int C[$1]={$2};')dnl
define(`_EXP',        `ifelse($#, 0, , $#, 1, ``$1'UL',
			     ``$1'UL, _EXP(shift($@))')')dnl
define(`forloop',
       `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')dnl
define(`_forloop',
       `$4`'ifelse($1, `$3', ,
		   `define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')dnl
define(`CCIDE_TABLE_YES',
`CCIDE_BIT CCIDE_table$1_yes[$2]={_EXP(shift(shift($@)))};')dnl
define(`CCIDE_TABLE_NO',
`CCIDE_BIT CCIDE_table$1_no[$2]={_EXP(shift(shift($@)))};')dnl
define(`CCIDE_MAIN',`int main(int argc, char **argv) {')dnl
define(`CCIDE_INCLUDE',`#include <stdlib.h>
#include <assert.h>
#ifdef CCIDE_LIB
#include <ccide.h>
#else
CCIDE_INLINECODE()
#endif // End #ifdef CCIDE_LIB
')dnl
define(`CCIDE_FUN_A',`static void A(int n) {
	printf("%i\n",n);
}
')dnl
define(`CCIDE_COPYING',
`/* Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
*/
')dnl
define(`CCIDE_INLINECODE',
`//GENERATED_CODE:
#ifndef __CCIDE_INLINE_C
#define __CCIDE_INLINE_C

/*
Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
*/
typedef unsigned int CCIDE_BIT;
static int ccide_group=1;

#ifndef UINT_MAX
#include "limits.h"
#endif

static int CcideFindRule(               /* Return rule number */
	int nbrrules,  CCIDE_BIT ccide_table, CCIDE_BIT yes[], CCIDE_BIT no[])
{
        int r=0;
        CCIDE_BIT nstate;

        nstate = UINT_MAX ^ ccide_table;

        while (
		( (yes[r] & nstate) || (no[r]  & ccide_table) )
		 && ( ++r < nbrrules )
	) {};

        return r;
}

static int CcideFindRuleYes(             /* Return rule number */
	int nbrrules, CCIDE_BIT ccide_table, CCIDE_BIT yes[])
{
        int r=0;
        CCIDE_BIT nstate;

        nstate = UINT_MAX ^ ccide_table;
        while ( (yes[r] & nstate) && ( ++r < nbrrules ) ) {};
        return r;
}
#endif /* End ifndef  __CCIDE_INLINE_C  */
//END_GENERATED_CODE:')dnl
divert(-1)dnl
divert(0)dnl
dnl