ifelse(
  File ccide.m4
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
`-- Copyright (C) 2002-2010 Thomas W. Young, e-mail:  ccide@twyoung.com
-- This program is free software; you can redistribute it and/or modify   
-- it under the terms of the GNU General Public License as published by   
-- the Free Software Foundation.                                          
--                                                                        
-- This program is distributed in the hope that it will be useful,        
-- but WITHOUT ANY WARRANTY; without even the implied warranty of         
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the          
-- GNU General Public License for more details.                           
--                                                                        
-- You should have received a copy of the GNU General Public License      
-- along with this program; if not, write to the Free Software            
-- Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.              
-- ------------------------------------------ end of legal stuff -------- 
--
')dnl
define(`CCIDE_INLINECODE',
`GENERATED_CODE:*/
/*
	ccide-EX.m4  Version 0.2
	Copyright (C) 2002-2010 Thomas W. Young, e-mail:  ccide@twyoung.com
	This code (generated by ccide) is licensed under the GNU Library
	General Public License
	As such, it may be freely used, even link-edited with proprietary code
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
