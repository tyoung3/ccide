#! /bin/sh

#  	ccide - C Language Decision Table Code Generator 
#	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

#    	This file is part of ccide, the C Language Decision Table Code Generator.

#   	Ccide is free software: you can redistribute it and/or modify
#   	it under the terms of the GNU General Public License as published by
#    	the Free Software Foundation, either version 3 of the License, or
#   	(at your option) any later version.

#    	Ccide is distributed in the hope that it will be useful,
#    	but WITHOUT ANY WARRANTY; without even the implied warranty of
#    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    	GNU General Public License for more details.

#    	You should have received a copy of the GNU General Public License
#    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
#    	write to the Free Software Foundation, Inc., 51 Franklin St, 
#    	Fifth Floor, Boston, MA 02110-1301 USA.
# ----------------------------------------------- end of legal stuff ---------------------- #

# THISIS: autogen.sh
# autogen.sh script:  bootstrap like.  See:
#	http://sources.redhat.com/autobook/autobook/autobook_43.html#SEC43
#
# N.B.:  try ./configure before running autogen.sh.
# If autogen.sh is missing try 'bash autogen.sh.in'.  
    		
set -e				\
&&sudo ./scripts/check.sh mkam	\
&&sudo autoreconf -i --force	\
&&sudo rm -rf autom4te.cache		

