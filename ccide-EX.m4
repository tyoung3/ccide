ifelse(
  File ccide-EX.m4
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

  Convert text w/embedded macros to euphoria(.ex) output.
  
  USAGE:

	m4 -DLANG=ex test.m4 skel.c.m4 > skel.ex

)dnl
define(`{ CCIDE_TABLE_',`label "CCIDE_TABLE_')dnl
define(`} CCIDE_COMMENT',`CCIDE_COMMENT')dnl
define(`CCIDE_SWITCH',`switch(CcideFindRule($1,
			CcideSetCond($2,$3),
			$4,
			$5)) do')dnl
define(`CCIDE_SWITCH_YES',`switch(CcideFindRuleYes($1,
			CcideSetCond($2,$3),
			$4)) do')dnl
define(`CCIDE_END_SWITCH',`end switch')dnl
define(`CCIDE_SWITCHX',`switch($1) do ')dnl
define(`CCIDE_END_COND',
	`ifelse($1, `yesno', `,CCIDE_table1_yes, CCIDE_table1_no)) {',
			     `,CCIDE_table1_yes)) {')')dnl
define(`CCIDE_CASE',`case $2 then CCIDE_COMMENT(`Rule $3')')dnl
define(`CCIDE_IF',`if(')dnl
define(`CCIDE_SAND',` && ')dnl
define(`CCIDE_TRUE',`($1)')dnl
define(`CCIDE_FALSE',`!($1)')dnl
define(`CCIDE_ENDCOND',`) {')dnl
define(`CCIDE_ENDIF',`}')dnl
define(`CCIDE_ACTION',`$1')dnl
define(`CCIDE_BREAK',`break;')dnl
define(`CCIDE_COND',`ifelse($1, `0',`($2)',`| ($2)<<$1')')dnl
define(`CCIDE_LABEL',`label "$1"')dnl
define(`CCIDE_GOTO',`goto $1;')dnl
define(`CCIDE_BEGIN_BLOCK',`')dnl
define(`CCIDE_END_BLOCK',`')dnl
define(`CCIDE_COMMENT',`/*$@*/')dnl
define(`CCIDE_END_TABLE',`CCIDE_COMMENT(`GENERATED_CODE:') ')dnl
define(`CCIDE_int_C',`	int C[$1]={$2};')dnl
define(`_EXP',        `ifelse($#, 0, , $#, 1, `$1',
			     ``$1', _EXP(shift($@))')')dnl
define(`forloop',
       `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')dnl
define(`_forloop',
       `$4`'ifelse($1, `$3', ,
		   `define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')dnl
define(`CCIDE_TABLE_YES',`')dnl
define(`CCIDE_TABLE_NO',`')dnl
define(`CCIDE_MAIN',`int main(int argc, char **argv) {')dnl
define(`CCIDE_INCLUDE',`#include <stdlib.h>
#include <assert.h>
#ifdef CCIDE_LIB
#include <ccide.h>
#else
CCIDE_INLINECODE()
#endif -- End #ifdef CCIDE_LIB
')dnl
define(`CCIDE_FUN_A',`static void A(int n) {
	printf("%i\n",n);
}
')dnl
define(`CCIDE_COPYING',
`--  	ccide - C Language Decision Table Code Generator 
--	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
')dnl
define(`CCIDE_INLINECODE',
`GENERATED_CODE:*/
/*
	ccide-EX.m4  Version 0.3. Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
	
*/

integer ccide_group, CCIDE_UINT_MAX
	ccide_group=1
	CCIDE_UINT_MAX=1073741823

function CcideSetCond(integer n, sequence s)   
	integer i

	switch (n) do
		case 0 then
			return 0
		case 1 then
			return s[1]
		case 2  then
			return( or_bits( s[1], s[2] + s[2] ) )
		case else 
			i = CcideSetCond( n-2, tail(s,n-2) )
			i+=i
			i+=i
			return( or_bits( or_bits( s[1], s[2] + s[2] ),i) )
	end switch
end function

function CcideFindRule(			-- Return rule number
	integer nbrrules,
	atom ccide_table,
	sequence yes,
	sequence no)
        integer r
        atom nstate

	r=1
        nstate = xor_bits( CCIDE_UINT_MAX, ccide_table)

        while (1) do
	   if ( and_bits(yes[r],nstate) or and_bits(no[r],ccide_table) ) then 
		r+=1
	   else
		 return r-1 
           end if 
	   if r>nbrrules then
		return r
	   end if
	end while
end function

function CcideFindRuleYes(             -- Return rule number 
	integer nbrrules,
	atom ccide_table,	
	sequence yes)

        integer r
        atom nstate
	r=1
        nstate = xor_bits(CCIDE_UINT_MAX, ccide_table)

        while (1) do
	   if ( and_bits(yes[r],nstate) ) then
		r+=1
	   else
		return r-1
           end if
	   if r>nbrrules then
		return r
	   end if
	end while
end function

/*END_GENERATED_CODE')dnl
divert(-1)dnl
divert(0)dnl
dnl
