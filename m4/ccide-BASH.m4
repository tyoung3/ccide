ifelse(
  File ccide-BASH.m4
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

  Convert text w/embedded macros to BASH script output.
  
  USAGE:
	m4 ccide-BASH.m4 ba.sh.m4 > ba.sh

)dnl
changequote(^^^, %%%)
define(^^^CCIDE_SWITCH%%%, ^^^$2
	CcideFindRule $1 $CCIDE;	case $CCIDE in%%%)dnl
define(^^^CCIDE_SWITCH_YES%%%, ^^^$2
	CcideFindRuleYes $1 $CCIDE;	case $CCIDE in
%%%)dnl
define(^^^CCIDE_END_SWITCH%%%,^^^esac%%%)dnl
define(^^^CCIDE_SWITCHX%%%,^^^switch($1) %%%)dnl
define(^^^CCIDE_END_COND%%%,^^^%%%)dnl
define(^^^CCIDE_CASE%%%,^^^($2) CCIDE_COMMENT(^^^	Rule $3%%%)%%%)dnl
define(^^^CCIDE_CASE_BEGIN%%%,^^^($2%%%)dnl
define(^^^CCIDE_CASE_END%%%,^^^)CCIDE_COMMENT(^^^       Rule $1%%%)%%%)dnl
define(^^^CCIDE_IF%%%,^^^if [[ %%%)dnl
define(^^^CCIDE_ENDIF%%%,^^^fi%%%)dnl
define(^^^CCIDE_SAND%%%,^^^ && %%%)dnl
define(^^^CCIDE_TRUE%%%,^^^( $1 )%%%)dnl
define(^^^CCIDE_FALSE%%%,^^^!( $1 )%%%)dnl
define(^^^CCIDE_ENDCOND%%%,^^^ ]]; then%%%)dnl
define(^^^CCIDE_ACTION%%%,^^^$1;%%%)dnl
define(^^^CCIDE_BREAK%%%,^^^;;%%%)dnl
define(^^^CCIDE_COND%%%,^^^ifelse($1, ^^^0%%%,^^^($2)%%%,^^^| ($2)<<$1%%%)%%%)dnl
define(^^^CCIDE_LABEL%%%,^^^# $1:%%%)dnl
dnl  No %%%goto%%% in BASH. define(^^^CCIDE_GOTO%%%,^^^goto $1;%%%)dnl
define(^^^CCIDE_BEGIN_BLOCK%%%,^^^{%%%)dnl
define(^^^CCIDE_END_BLOCK%%%,^^^}%%%)dnl
define(^^^CCIDE_COMMENT%%%,^^^#$1%%%)dnl
define(^^^CCIDE_END_TABLE%%%,^^^CCIDE_COMMENT(^^^GENERATED_CODE:%%%) %%%)dnl
define(^^^CCIDE_TABLE_YES%%%,
^^^CCIDE_YES=(shift(shift($@)))%%%)dnl
define(^^^CCIDE_TABLE_NO%%%,
^^^CCIDE_NO=(shift(shift($@)))%%%)dnl
define(^^^CCIDE_INLINECODE%%%,
^^^#GENERATED_CODE:
#
#ccide-BASH.m4
#Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
#
function CcideFindRule() {             # Return rule number
	CCIDE=0; nstate=$(( 4294967295 ^ ${2} ))
        while [[ $CCIDE -lt ${1} ]] 						\
		&& (    [[ $((${CCIDE_YES[$CCIDE]} & $nstate)) -ne 0 ]] 	\
		     || [[ $((${CCIDE_NO[$CCIDE]}  & ${2})) -ne 0 ]] ); do	\
 	               CCIDE=$(($CCIDE+1))
        done
}
#
function CcideFindRuleYes() {             # Return rule number
	CCIDE=0; nstate=$(( 4294967295 ^ ${2} ))
        while [[ $CCIDE -lt ${1} ]] 						\
		&& [[ $((${CCIDE_YES[$CCIDE]} & $nstate)) -ne 0 ]]; do		\
               CCIDE=$(($CCIDE+1))
        done
}
#
#END_GENERATED_CODE:%%%)dnl
dnl
divert(-1)dnl
divert(0)dnl
dnl
