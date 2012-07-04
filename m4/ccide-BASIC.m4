ifelse(
  File ccide-BASIC.m4
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

  Convert text w/embedded macros to Visual Basic output.
  
  USAGE:
	m4 ccide-VB.m4 test.vb.m4  > test.vb

)dnl
undefine(`format')dnl
changequote([[,]])dnl
define([[CCIDE_SWITCH]],[[CCIDE=$2
CCIDE=CCIDEFINDRULE($1, CCIDE):Select Case CCIDE
]])dnl
define([[CCIDE_SWITCH_YES]],[[CCIDE=$2
CCIDE=CCIDEFINDRULEYES($1, CCIDE):Select Case CCIDE
]])dnl
define([[CCIDE_END_SWITCH]],[[END SELECT
]])dnl
define([[CCIDE_SWITCHX]],[[Select Case $1 {]])dnl
define([[CCIDE_END_COND]],
	[[ifelse($1, [[yesno]], [[,CCIDE_table1_yes, CCIDE_table1_no)) {]],
			     [[,CCIDE_table1_yes)) {]])]])dnl
define([[CCIDE_CASE]],[[CCIDE_LABEL([[CCIDE_$1_$2]]) case $2:	CCIDE_COMMENT([[	Rule $3]])]])dnl
define([[CCIDE_IF]],[[IF(]])dnl
define([[CCIDE_SAND]],[[ && ]])dnl
define([[CCIDE_TRUE]],[[($1)]])dnl
define([[CCIDE_FALSE]],[[!($1)]])dnl
define([[CCIDE_ENDCOND]],[[) {]])dnl
define([[CCIDE_ENDIF]],[[}]])dnl
define([[CCIDE_ACTION]],[[$1]])dnl
define([[CCIDE_BREAK]],[[]])dnl
define([[CCIDE_COND]],[[ifelse($1, [[0]],[[($2)]],[[| ($2)<<$1]])]])dnl
define([[CCIDE_LABEL]],[[$1:]])dnl
define([[CCIDE_GOTO]],[[goto $1]])dnl
define([[CCIDE_BEGIN_BLOCK]],[[]])dnl
define([[CCIDE_END_BLOCK]],[[}]])dnl
define([[CCIDE_COMMENT]],[[rem ]])dnl
define([[CCIDE_END_TABLE]],[[CCIDE_COMMENT([[GENERATED_CODE:]]) ]])dnl
define([[CCIDE_int_C]],[[	int C[$1]={$2};]])dnl
define([[CCIDE_TYES]],[[	CCIDE_table$1_yes($2)=$3]])dnl
define([[CCIDE_TNO]],[[	CCIDE_table$1_no($2)=$3]])dnl
define([[CCIDE_TABLE_YES]],[[DIM CCIDE_table$1_yes($2)]])dnl
define([[CCIDE_TABLE_NO]],[[DIM CCIDE_table$1_no($2)]])dnl
define([[CCIDE_INLINECODE]],[['GENERATED_CODE:

'ccide-VB.m4
'Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com

DIM CCIDETABLEYES(100) As Integer
DIM CCIDETABLENO(100)  As Integer
DIM CCIDE As Integer
DIM CCIDENSTATE As Integer

              ' Return rule number 
Public Function CCIDEFINDRULE(NBRRULES As Integer, CCIDE_TABLE As Integer) As Integer
	CCIDE=0
        CCIDENSTATE=4294967295 XOR ccide_table
        WHILE  ( (CCIDETABLEYES(CCIDE) AND CCIDENSTATE) OR (CCIDETABLENO(CCIDE)  AND CCIDE_TABLE) ) AND ( CCIDE < NBRRULES )
		CCIDE = CCIDE  + 1
	WEND
	CCIDEFINDRULE=CCIDE
End Function

              ' Return rule number 
Public Function CCIDEFINDRULEYES(NBRRULES As Integer, CCIDE_TABLE As Integer) As Integer
	CCIDE=0
        CCIDENSTATE=4294967295 XOR ccide_table
        WHILE ( CCIDETABLEYES(CCIDE) AND CCIDENSTATE) AND ( CCIDE < NBRRULES )
		CCIDE = CCIDE  + 1
	WEND
	CCIDEFINDRULE=CCIDE
End Function
'END_GENERATED_CODE:]])dnl
divert(-1)dnl
divert(0)dnl
dnl
