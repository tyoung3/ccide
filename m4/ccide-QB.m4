m4_ifelse(
  File ccide-QB.m4
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

  Convert text w/embedded macros to Visual Basic output.
  
  USAGE:
	m4 ccide-VB.m4 test.vb.m4  > test.vb

)m4_dnl
m4_undefine(`format')m4_dnl
m4_changequote([[,]])m4_dnl
m4_define([[CCIDE_SWITCH]],[[CCIDE=$2
CCIDE=CCIDEFINDRULE($1, CCIDE):Select Case CCIDE
]])m4_dnl
m4_define([[CCIDE_SWITCH_YES]],[[CCIDE=$2
CCIDE=CCIDEFINDRULEYES($1, CCIDE):Select Case CCIDE
]])m4_dnl
m4_define([[CCIDE_END_SWITCH]],[[END SELECT
]])m4_dnl
m4_define([[CCIDE_SWITCHX]],[[Select Case $1 {]])m4_dnl
m4_define([[CCIDE_END_COND]],
	[[m4_ifelse($1, [[yesno]], [[,CCIDE_table1_yes, CCIDE_table1_no)) {]],
			     [[,CCIDE_table1_yes)) {]])]])m4_dnl
m4_define([[CCIDE_CASE]],[[CCIDE_LABEL([[CCIDE_$1_$2]]) case $2:	CCIDE_COMMENT([[	Rule $3]])]])m4_dnl
m4_define([[CCIDE_IF]],[[IF(]])m4_dnl
m4_define([[CCIDE_SAND]],[[ && ]])m4_dnl
m4_define([[CCIDE_TRUE]],[[($1)]])m4_dnl
m4_define([[CCIDE_FALSE]],[[!($1)]])m4_dnl
m4_define([[CCIDE_ENDCOND]],[[) {]])m4_dnl
m4_define([[CCIDE_ENDIF]],[[}]])m4_dnl
m4_define([[CCIDE_ACTION]],[[$1]])m4_dnl
m4_define([[CCIDE_BREAK]],[[]])m4_dnl
m4_define([[CCIDE_COND]],[[m4_ifelse($1, [[0]],[[($2)]],[[| ($2)<<$1]])]])m4_dnl
m4_define([[CCIDE_LABEL]],[[$1:]])m4_dnl
m4_define([[CCIDE_GOTO]],[[goto $1]])m4_dnl
m4_define([[CCIDE_BEGIN_BLOCK]],[[]])m4_dnl
m4_define([[CCIDE_END_BLOCK]],[[}]])m4_dnl
m4_define([[CCIDE_COMMENT]],[[rem ]])m4_dnl
m4_define([[CCIDE_END_TABLE]],[[CCIDE_COMMENT([[GENERATED_CODE:]]) ]])m4_dnl
m4_define([[CCIDE_int_C]],[[	int C[$1]={$2};]])m4_dnl
m4_define([[CCIDE_TYES]],[[	CCIDE_table$1_yes($2)=$3]])m4_dnl
m4_define([[CCIDE_TNO]],[[	CCIDE_table$1_no($2)=$3]])m4_dnl
m4_define([[CCIDE_TABLE_YES]],[[DIM CCIDE_table$1_yes($2)]])m4_dnl
m4_define([[CCIDE_TABLE_NO]],[[DIM CCIDE_table$1_no($2)]])m4_dnl
m4_define([[CCIDE_INLINECODE]],[[rem GENERATED_CODE:

rem ccide-VB.m4
	rem Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
 	rem The code generated by ccide is covered by the same license as the source  
 	rem code(decision table) from which it is derived. If you created the source,  
 	rem you are free to do anything you like with the generated code, 
 	rem including incorporating it into or linking it with proprietary software.  
	

DIM CCIDETABLEYES(100) As Integer
DIM CCIDETABLENO(100)  As Integer
DIM CCIDE As Integer
DIM CCIDENSTATE As Integer

              REM Return rule number 
Public Function CCIDEFINDRULE(NBRRULES As Integer, CCIDE_TABLE As Integer) As Integer
	CCIDE=0
        CCIDENSTATE=4294967295 XOR ccide_table
        WHILE  ( (CCIDETABLEYES(CCIDE) AND CCIDENSTATE) OR (CCIDETABLENO(CCIDE)  AND CCIDE_TABLE) ) AND ( CCIDE < NBRRULES )
		CCIDE = CCIDE  + 1
	WEND
	CCIDEFINDRULE=CCIDE
End Function

              REM Return rule number 
Public Function CCIDEFINDRULEYES(NBRRULES As Integer, CCIDE_TABLE As Integer) As Integer
	CCIDE=0
        CCIDENSTATE=4294967295 XOR ccide_table
        WHILE ( CCIDETABLEYES(CCIDE) AND CCIDENSTATE) AND ( CCIDE < NBRRULES )
		CCIDE = CCIDE  + 1
	WEND
	CCIDEFINDRULE=CCIDE
End Function
rem END_GENERATED_CODE:]])m4_dnl
m4_divert(-1)m4_dnl
m4_divert(0)m4_dnl
m4_dnl
