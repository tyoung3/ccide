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

# ccide.spec.  Generated from ccide.spec.in by configure.

Name: ccide
##Prefix:         /usr
Version:        0.7.0
Release: 	0
License: GPL

Group: Development/Tools
URL: http://www.ccide.com
Summary: Decision Table Code Generator
Packager: The CCIDE Project <ccide@twyoung.com>

#Requires: gcc m4
Source: ftp://ftp.twyoung.com/pub/linux/ccide/ccide-%{version}-%{release}.tar.gz
BuildRoot: /var/tmp/%{name}-%{version}-{release} 
Vendor:  The CCIDE Project
%description 
This package contains ccide, the Decision Table code generator.
Ccide reads a file containing source code (in one of several languages)
with embedded decision tables and creates a compilable program or an interpretable script.
%define ccidev ccide-%{version}
#CHANGE LOG:
%prep
%setup -q 
%build
./configure
make 
%install
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/man/man1
mkdir -p $RPM_BUILD_ROOT/usr/{bin,lib,include,man,share}
mkdir -p $RPM_BUILD_ROOT/usr/share/doc
mkdir -p $RPM_BUILD_ROOT/usr/share/ccide
mkdir -p $RPM_BUILD_ROOT/usr/share/doc/%{ccidev}

install -m 755 scripts/ccide $RPM_BUILD_ROOT/usr/bin/ccide
install -s -m 755 src/ccidew $RPM_BUILD_ROOT/usr/bin/ccidew
install -m 644 m4/ccide-BASH.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-BASH.m4
install -m 644 m4/ccide-VB.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-VB.m4
install -m 644 m4/ccide-QB.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-QB.m4
install -m 644 m4/ccide-BASIC.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-BASIC.m4
install -m 644 m4/ccide-C.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-C.m4
install -m 644 m4/ccide-CC.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-CC.m4
install -m 644 m4/ccide-C++.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-C++.m4
install -m 644 m4/ccide-CS.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-CS.m4
install -m 644 m4/ccide-JAVA.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-JAVA.m4
install -m 644 m4/ccide-EX.m4 $RPM_BUILD_ROOT/usr/share/ccide/ccide-EX.m4
install -m 644 src/ccide.1 $RPM_BUILD_ROOT/usr/man/man1/ccide.1
install -m 644 COPYING $RPM_BUILD_ROOT/usr/share/doc/%{ccidev}/COPYING
install -m 644 ChangeLog $RPM_BUILD_ROOT/usr/share/doc/%{ccidev}/ChangeLog
install -m 644 README $RPM_BUILD_ROOT/usr/share/doc/%{ccidev}/README
%clean
echo Consider doing: "rm -rf $RPM_BUILD_ROOT"

%files
/usr/bin/ccide
/usr/bin/ccidew

/usr/share/ccide/ccide-BASH.m4
/usr/share/ccide/ccide-C.m4
/usr/share/ccide/ccide-CC.m4
/usr/share/ccide/ccide-C++.m4
/usr/share/ccide/ccide-CS.m4
/usr/share/ccide/ccide-BASIC.m4
/usr/share/ccide/ccide-VB.m4
/usr/share/ccide/ccide-QB.m4
/usr/share/ccide/ccide-JAVA.m4
/usr/share/ccide/ccide-EX.m4
%ghost

%doc
/usr/man/man1/ccide.1.gz
/usr/share/doc/%{ccidev}/COPYING
/usr/share/doc/%{ccidev}/README
/usr/share/doc/%{ccidev}/ChangeLog

%config

%triggerin --

%post 
