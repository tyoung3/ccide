# DIST_SUBDIRS = lib src tests examples CYGWIN-PATCHES 
SUBDIRS = src 


dist_pkgdata_DATA = 	m4/ccide-C.m4  m4/ccide-CC.m4 m4/ccide-C++.m4  m4/ccide-BASH.m4 m4/ccide-BASIC.m4 	\
			m4/ccide-QB.m4 m4/ccide-VB.m4 m4/ccide-JAVA.m4 m4/ccide-CS.m4   m4/ccide-EX.m4

# This works with GNU tar and gives cleaner package than normal 'make dist'.
mydist_???:
        VERSION=$(VERSION); \
        if test -d "$(srcdir)/.git" && type git > /dev/null 2>&1; then \
                SNAPSHOT=`cd "$(srcdir)" && git describe --abbrev=4 | cut -b2-`; \
                test -n "$$SNAPSHOT" && VERSION=$$SNAPSHOT; \
        fi; \
        TAR_OPTIONS='--owner=0 --group=0 --numeric-owner --mode=u+rw,go+r-w' \
                $(MAKE) VERSION="$$VERSION" dist-gzip
