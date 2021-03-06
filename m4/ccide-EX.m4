m4_ifelse(
  File ccide-EX.m4
m4_dnl  	ccide - C Language Decision Table Code Generator 
m4_dnl	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
m4_dnl
m4_dnl   	This file is part of ccide, the C Language Decision Table Code Generator.
m4_dnl
m4_dnl   	Ccide is free software: you can redistribute it and/or modify
m4_dnl   	it under the terms of the GNU General Public License as published by
m4_dnl    	the Free Software Foundation, either version 3 of the License, or
m4_dnl   	(at your option) any later version.
m4_dnl
m4_dnl    	Ccide is distributed in the hope that it will be useful,
m4_dnl    	but WITHOUT ANY WARRANTY; without even the implied warranty of
m4_dnl    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
m4_dnl    	GNU General Public License for more details.
m4_dnl
m4_dnl    	You should have received a copy of the GNU General Public License
m4_dnl    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
m4_dnl    	write to the Free Software Foundation, Inc., 51 Franklin St, 
m4_dnl    	Fifth Floor, Boston, MA 02110-1301 USA.

  Convert text w/embedded macros to euphoria(.ex) output.
  
  USAGE:

	m4 -DLANG=ex test.m4 skel.c.m4 > skel.ex

)m4_dnl
m4_define(`{ CCIDE_TABLE_',`label "CCIDE_TABLE_')m4_dnl
m4_define(`} CCIDE_COMMENT',`CCIDE_COMMENT')m4_dnl
m4_define(`CCIDE_SWITCH',`switch(CcideFindRule($1,
			CcideSetCond($2,$3),
			$4,
			$5)) do')m4_dnl
m4_define(`CCIDE_SWITCH_YES',`switch(CcideFindRuleYes($1,
			CcideSetCond($2,$3),
			$4)) do')m4_dnl
m4_define(`CCIDE_END_SWITCH',`end switch')m4_dnl
m4_define(`CCIDE_SWITCHX',`switch($1) do ')m4_dnl
m4_define(`CCIDE_END_COND',
	`m4_ifelse($1, `yesno', `,CCIDE_table1_yes, CCIDE_table1_no)) {',
			     `,CCIDE_table1_yes)) {')')m4_dnl
m4_define(`CCIDE_CASE',`case $2 then CCIDE_COMMENT(`Rule $3')')m4_dnl
m4_define(`CCIDE_IF',`if(')m4_dnl
m4_define(`CCIDE_SAND',` && ')m4_dnl
m4_define(`CCIDE_TRUE',`($1)')m4_dnl
m4_define(`CCIDE_FALSE',`!($1)')m4_dnl
m4_define(`CCIDE_ENDCOND',`) {')m4_dnl
m4_define(`CCIDE_ENDIF',`}')m4_dnl
m4_define(`CCIDE_ACTION',`$1')m4_dnl
m4_define(`CCIDE_BREAK',`break;')m4_dnl
m4_define(`CCIDE_COND',`m4_ifelse($1, `0',`($2)',`| ($2)<<$1')')m4_dnl
m4_define(`CCIDE_LABEL',`label "$1"')m4_dnl
m4_define(`CCIDE_GOTO',`goto $1;')m4_dnl
m4_define(`CCIDE_BEGIN_BLOCK',`')m4_dnl
m4_define(`CCIDE_END_BLOCK',`')m4_dnl
m4_define(`CCIDE_COMMENT',`/*$@*/')m4_dnl
m4_define(`CCIDE_END_TABLE',`CCIDE_COMMENT(`GENERATED_CODE:') ')m4_dnl
m4_define(`CCIDE_int_C',`	int C[$1]={$2};')m4_dnl
m4_define(`_EXP',        `m4_ifelse($#, 0, , $#, 1, `$1',
			     ``$1', _EXP(m4_shift($@))')')m4_dnl
m4_define(`forloop',
       `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')m4_dnl
m4_define(`_forloop',
       `$4`'m4_ifelse($1, `$3', ,
		   `m4_define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')m4_dnl
m4_define(`CCIDE_TABLE_YES',`')m4_dnl
m4_define(`CCIDE_TABLE_NO',`')m4_dnl
m4_define(`CCIDE_MAIN',`int main(int argc, m4_char **argv) {')m4_dnl
m4_define(`CCIDE_INCLUDE',`#include <stdlib.h>
#include <assert.h>
#ifdef CCIDE_LIB
#include <ccide.h>
#else
CCIDE_INLINECODE()
#endif -- End #ifdef CCIDE_LIB
')m4_dnl
m4_define(`CCIDE_FUN_A',`static void A(int n) {
	printf("%i\n",n);
}
')m4_dnl
m4_define(`CCIDE_COPYING',
`--  	ccide - C Language Decision Table Code Generator 
--	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com
-- The code generated by ccide is covered by the same license as the source  
-- code(decision table) from which it is derived. If you created the source,  
-- you are free to do anything you like with the generated code, 
-- including incorporating it into or linking it with proprietary software.  
')m4_dnl
m4_define(`CCIDE_INLINECODE',
`GENERATED_CODE:*/
/*
	ccide-EX.m4  Version 0.3. Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
 		The code generated by ccide is covered by the same license as the source  
 		code(decision table) from which it is derived. If you created the source,  
 		you are free to do anything you like with the generated code, 
 		including incorporating it into or linking it with proprietary software.  
	
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

/*END_GENERATED_CODE')m4_dnl
m4_divert(-1)m4_dnl
m4_divert(0)m4_dnl
m4_dnl
