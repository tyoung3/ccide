
#	  	ccide-0.7.0 - C Language Decision Table Code Generator 

	Copyright (C) 2002-2004,2010,2012,2022;  Thomas W. Young, e-mail:  ccide@twyoung.com

    	This file is part of ccide, the C Language Decision Table Code Generator.

   	Ccide is free software: you can redistribute it and/or modify
   	it under the terms of the GNU General Public License as published by
    	the Free Software Foundation, either version 3 of the License, or
   	(at your option) any later version.

    	Ccide is distributed in the hope that it will be useful,
    	but WITHOUT ANY WARRANTY; without even the implied warranty of
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    	GNU General Public License for more details.

    	You should have received a copy of the GNU General Public License
    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
    	write to the Free Software Foundation, Inc., 51 Franklin St, 
    	Fifth Floor, Boston, MA 02110-1301 USA.
 

See the accompanying file, COPYING, for terms of use.  
  
Ccide generates compilable code in a number of languages(including JAVA, C/C++, BASH script, and Euphoria; from a source language file containing one or more commented decision tables.  Decision tables are easier to read than traditional if-then-else structures, thereby helping to prevent logic errors.
 
See the man page for a complete description or visit
http://github.com/tyoung3/ccide or http://ccide.sourceforge.net/ for more information and downloads.

ccide is part of the GNU project: http://www.gnu.org/gnu/thegnuproject.html.

Install Note:
	Normal procedure is configure, make, [make check], make install (as root). 
	Use './configure --disable-nls'  if NLS support is not wanted or unavailable.
	For mingw something like './configure -disable-nls --prefix=c:/mingw' is 
        probably what you want (but see below).

	To rebuild from scratch, run the './autogen.sh' script in the installation
	directory(contains Makefile.am, etc.) and run './configure' and 'make'.  
	BOOTSTRAP WARNING: If you run 'make clean', you may need a working version of 
	ccide to regenerate ccideparse.y and ccidemain.c. The ccide source code itself contains 
	several, previously expanded, decision tables.  

	Running 'make install' will install ccide without package management.	
	'make uninstall' will undo 'make install'.
	You can build an rpm by running 'make rpm' then install the rpm, as root: 'sudo rpm -Uvh .../RPMS/*/ccide*rpm'.    
	
	On Windows systems, you will want to do something like
	'make DESTDIR=/mingw install' to install.
	The ...mingw.tar.gz tarball is preconfigured with './configure --disable-nls --prefix=c:/mingw && make'. 
	ccidew.exe should work properly, but there is no ccide.bat script, as yet, to replace the ccide bash script.


## Release Notes<a name="releasnotes"/>
### 0.7.0
  * Rebuilt on Ubuntu/Jammy
  * TODO to TODO.md
  * Added several .po files 
