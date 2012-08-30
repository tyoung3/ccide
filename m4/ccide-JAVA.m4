m4_ifelse(
  File ccide-JAVA.m4
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

  Convert text w/embedded macros to JAVA output.
  
  USAGE:
	m4 ccide-JAVA.m4 skel.m4 > skel.java

  forloop (iterator, start, end, text)
  For JAVA conditions: (a > b) ? a : b;

)m4_dnl
m4_define(`array', `defn(format(``array[%d]'', `$1'))')m4_dnl
m4_define(`array_set', `m4_define(format(``array[%d]'', `$1'), `$2')')m4_dnl
m4_define(`CCIDE_SWITCH',    `switch(CCIDE.CcideFindRule(   $1,$2,CCIDE_table$3_yes, CCIDE_table$3_no)) ')m4_dnl
m4_define(`CCIDE_SWITCH_YES',`switch(CCIDE.CcideFindRuleYes($1,$2,CCIDE_table$3_yes)) ')m4_dnl
m4_define(`CCIDE_END_SWITCH',`} CCIDE_END_BLOCK CCIDE_COMMENT(` End Switch')')m4_dnl
m4_define(`CCIDE_SWITCHX_JAVA',`switch($1) {')m4_dnl
m4_define(`CCIDE_END_COND',
	`m4_ifelse($1, `yesno', `,CCIDE_table1_yes, CCIDE_table1_no)) {',
			     `,CCIDE_table1_yes)) {')')m4_dnl
m4_define(`CCIDE_CASE',`CCIDE_LABEL(`CCIDE_$1_$2') case $2:	CCIDE_COMMENT(`	Rule $3')')m4_dnl
m4_define(`CCIDE_IF',`if(')m4_dnl
m4_define(`CCIDE_SAND',` && ')m4_dnl
m4_define(`CCIDE_TRUE',`$1')m4_dnl
m4_define(`CCIDE_FALSE',`!($1)')m4_dnl
m4_define(`CCIDE_ENDCOND',`) {')m4_dnl
m4_define(`CCIDE_ENDIF',`}')m4_dnl
m4_define(`CCIDE_ACTION',`$1')m4_dnl
m4_define(`CCIDE_BREAK',`break;')m4_dnl
m4_define(`CCIDE_COND_BLOCK',`forloop(`j',`7',`7',`$1 $2 <<j')')m4_dnl
m4_define(`CCIDE_COND',`m4_ifelse($1, `0',`($2)',`| ($2) << /*** */ $1')')m4_dnl
m4_define(`CCIDE_LABEL',`/*$1: */')m4_dnl
m4_define(`CCIDE_GOTO',`goto $1;')m4_dnl
m4_define(`CCIDE_BEGIN_BLOCK',`{')m4_dnl
m4_define(`CCIDE_END_BLOCK',`}')m4_dnl
m4_define(`CCIDE_BIT',`int')m4_dnl
m4_define(`CCIDE_COMMENT',`/*$@*/')m4_dnl
m4_define(`CCIDE_END_TABLE',`CCIDE_COMMENT(`GENERATED_CODE:') ')m4_dnl
m4_define(`CCIDE_int_C',`	int C[$1]={$2};')m4_dnl
m4_define(`[[')m4_dnl   #twy
m4_define(`]]')m4_dnl   #twy
m4_define(`_EXP',        `m4_ifelse($#, 0, , $#, 1, ``$1'',
			     ``$1', _EXP(m4_shift($@))')')m4_dnl
m4_define(`forloop',
       `pushdef(`$1', `$2')_forloop(`$1', `$2', `$3', `$4')popdef(`$1')')m4_dnl
m4_define(`_forloop',
       `$4`'m4_ifelse($1, `$3', ,
		   `m4_define(`$1', incr($1))_forloop(`$1', `$2', `$3', `$4')')')m4_dnl
m4_define(`CCIDE_TABLE_YES',
`CCIDE_BIT[] CCIDE_table$1_yes=new CCIDE_BIT[] {_EXP(m4_shift(m4_shift($@)))};')m4_dnl 
m4_define(`CCIDE_TABLE_NO',
`CCIDE_BIT[] CCIDE_table$1_no=new CCIDE_BIT[] {_EXP(m4_shift(m4_shift($@)))};')m4_dnl
m4_define(`CCIDE_MAIN',`int main(int argc, m4_char **argv) {')m4_dnl
m4_define(`CCIDE_INCLUDE',`#include <stdlib.h>
#include <assert.h>
#ifdef CCIDE_LIB
#include <ccide.h>
#else
CCIDE_INLINECODE()
#endif /* End #ifdef CCIDE_LIB */
')m4_dnl
m4_define(`CCIDE_FUN_A',`static void A(int n) {
	printf("%i\n",n);
}
')m4_dnl
m4_define(`CCIDE_COPYING',
`/* Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
 * The code generated by ccide is covered by the same license as the source  
 * code(decision table) from which it is derived. If you created the source,  
 * you are free to do anything you like with the generated code, 
 * including incorporating it into or linking it with proprietary software.  
*/
')m4_dnl
m4_define(`CCIDE_INLINECODE',
`/*GENERATED_CODE:*/

/*
ccide-C.m4
Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
 * The code generated by ccide is covered by the same license as the source  
 * code(decision table) from which it is derived. If you created the source,  
 * you are free to do anything you like with the generated code, 
 * including incorporating it into or linking it with proprietary software.  
*/

class CCIDE {

    public static int CcideFindRule(               /* Return rule number */
	int nbrrules,  CCIDE_BIT ccide_table, CCIDE_BIT yes[], CCIDE_BIT no[]) {
        int r=0;
        CCIDE_BIT nstate;

        nstate = Integer.MAX_VALUE ^ ccide_table;

         while (
		 (
		  ((yes[r] & nstate) != 0)  || 
		  ((no[r]  & ccide_table) != 0 )
		 )
		 && ( ++r < nbrrules )
	) {  };
  	
        return r;
    }

    public static int CcideFindRuleYes(             /* Return rule number */
	int nbrrules, CCIDE_BIT ccide_table, CCIDE_BIT yes[]) {
        int r=0;
        CCIDE_BIT nstate;

        nstate = Integer.MAX_VALUE ^ ccide_table;
        while ( 
		( (yes[r] & nstate) != 0) && 
		  ( ++r < nbrrules )  
	) {};
        
        return r;
    }
}
/*END_GENERATED_CODE:*/')m4_dnl
m4_divert(-1)m4_dnl
m4_divert(0)m4_dnl
m4_dnl
