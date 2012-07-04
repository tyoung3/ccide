# AUTOMAKE_OPTIONS = foreign
DIST_SUBDIRS = lib src tests examples CYGWIN-PATCHES 
SUBDIRS =
SUBDIRS += src 

dist_doc_DATA = \
        AUTHORS \
        COPYING \
        NEWS \
        README \
        TODO 


examplesdir = $(docdir)/examples

dist_examples_DATA = \
	doc/examples/check.c.d  \
	doc/examples/mycheck.c.d  \
	doc/examples/threeway.c.d  \
	doc/examples/threeway.dos.c.d  \
	doc/examples/tryit.cpp.d


EXTRA_DIST = \
        build

# This works with GNU tar and gives cleaner package than normal 'make dist'.

mydist_???:
        VERSION=$(VERSION); \
        if test -d "$(srcdir)/.git" && type git > /dev/null 2>&1; then \
                SNAPSHOT=`cd "$(srcdir)" && git describe --abbrev=4 | cut -b2-`; \
                test -n "$$SNAPSHOT" && VERSION=$$SNAPSHOT; \
        fi; \
        TAR_OPTIONS='--owner=0 --group=0 --numeric-owner --mode=u+rw,go+r-w' \
                $(MAKE) VERSION="$$VERSION" dist-gzip
