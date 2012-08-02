#!/bin/bash

# CHECK.SH:  Test ccide 
CWD=`pwd`
[ -x ../src/ccidew ] && CCIDEW=$CWD/../src/ccidew
[ -x src/ccidew ] && CCIDEW=$CWD/src/ccidew
[ -x ../src/ccidew.exe ] && CCIDEW=$CWD/../src/ccidew.exe
[ -x src/ccidew.exe ] && CCIDEW=$CWD/src/ccidew.exe
[ -f ../m4/ccide-C++.m4 ] && CCIDE_M4DIR=$CWD/../m4
[ -f m4/ccide-C++.m4 ] && CCIDE_M4DIR=$CWD/m4
[ -x ../scripts/ccide ] && PGM=$CWD/../scripts/ccide
[ -x scripts/ccide ] && PGM=$CWD/scripts/ccide

export CCIDEW=$CCIDEW
export CCIDE_M4DIR=$CCIDE_M4DIR
# echo CCIDEW=$CCIDEW  m4dir=$CCIDE_M4DIR
OPT="-b "
MAKE="make -s -B -i --no-print-directory"

Die() {
        echo "$0/DIE: $*"
        exit 1
}

Success() {
        NS=$(( $NS + 1 ))
        echo -e "               \033[0;32;32m ****  $* Success!	**** \033[0;32;39m"
}

Fail() {
        echo -e "               \033[0;32;31m ????  $* Failed   ????\033[0;32;39m"
        NFAIL=$(($NFAIL+1))
}

Summarize() {
        if [ $NFAIL ]; then                 
                Fail "$NFAIL tests failed and $NS succeeded."
        else 
                Success "All $NS tests succeeded. Total"
        fi
}

MakeIt() {
	X=`basename $1 .$2`
	echo Makeit $* X=$X
	[ "$2" ==    "c" ] && ( $MAKE -i  $X 	|| return 1 ) 
	[ "$2" ==  "cpp" ] && ( $MAKE $X 	|| return 1 )
	[ "$2" ==  "c++" ] && ( $MAKE $X 	|| return 1 )
	[ "$2" == "bash" ] && ( cp -avp $T $X  && chmod a+x $X	|| return 1 )
	[ "$2" == "java" ] && ( $MAKE $X	|| return 1 )
	return 0
}

TestIt() {
	[ -x $X.exe ] && X=$X.exe 
	./$X $TOPT < /dev/null >$X.output  	\
	&& diff -q $T.X $X.output  >/dev/null	

}

CheckExpand() {
	diff $* && Success "Generate $1" 	\
			|| Fail "Generate" $1  
}

TestCase() {
	CASE=$1
	[ -z $1 ] && CASE=calc
	TINPUT=`ls $CASE*.X` || Die Cannot find $CASE*.X
	T=`basename $TINPUT .X`
	X=`ls $CASE*.d`
	touch $X
	for Y in $X; do
		Z=`basename $Y .d`
		[ -f $Z.opt ] && . $Z.opt
		$MAKE -i $Z && CheckExpand $Z $Z.right  
	done
	$MAKE $CASE && X=$CASE && TestIt
}

Discard() {
	#SFX=`echo $T |cut -f2 -d.`    	
	DESC=$T; TOPT=;TOUT=;TIN=; OPT="-b -c 2"
	[ -f $T.opt ] && . $T.opt 2>/dev/null  
			case $SFX in
				sh|bash|SH|BASH)$PGM 	$OPT -L BASH 	< $T.d 2> $T.err > $T;;
				bas|BAS)$PGM 		$OPT -L BASIC 	< $T.d 2> $T.err > $T;;
				cc|CC)$PGM 		$OPT -L CC 	< $T.d 2> $T.err > $T;;
				c|C)$PGM 		$OPT 		< $T.d 2> $T.err > $T;;
				cpp|c++|CPP|C++)$PGM 	$OPT -L C++ 	< $T.d 2> $T.err > $T;;
				cs|CS)$PGM 		$OPT -L CS 	< $T.d 2> $T.err > $T;;
				ex|EX)$PGM 		$OPT -L EX 	< $T.d 2> $T.err > $T;;
				java|JAVA)$PGM 		$OPT -L JAVA 	< $T.d 2> $T.err > $T;;
				m4|M4)$PGM 		$OPT -m4 	< $T.d 2> $T.err > $T;;
				vb|VB)$PGM 		$OPT -L VB 	< $T.d 2> $T.err > $T;;
				qb|QB)$PGM 		$OPT -L QB 	< $T.d 2> $T.err > $T;;
				*)Die Cannot handle $TINPUT $T;;
			esac   
			diff -q $T $T.right >/dev/null 			\
			  	&& MakeIt $T $SFX 2>&1 >$T.make.out	\
			  	&& Success "$DESC generate"		\
			  	|| Fail "$DESC generate"
			 [ -f $T.X ] 					\
			  	&&  X=`basename $T .$SFX`		\
			  	&& TestIt && Success "$DESC execute" || Fail "$DESC execute"  
}

All(){
	X=`ls *.X`
	for T in $X; do 
		Y=`basename $T .X`
		SFX=`echo $Y|cut -f2 -d.` 
		Z=`basename $Y .$SFX`
		TestCase $Z $* && Success "Test" $Z || Fail "Test" $Z ;
	done
	Summarize
}


MakeEntry() {
	echo 	"$* \\" 	>> $TMPLT
	echo 	"$* \\" 	>> $PTMPLT 
}

MakeAM() {
	TMPLT=`pwd`/../extra_dist.mk
	PTMPLT=`pwd`/../disp_pkg.mk
	TDIR=./tests					 
	echo "#Generated by $0 on `date`." 					   > $TMPLT
	echo "#Generated by $0 on `date`." 					   > $PTMPLT
	echo "dist_pkgdata_DATA = m4/ccide-C.m4  m4/ccide-CC.m4 m4/ccide-C++.m4\\" >> $PTMPLT
	echo "	m4/ccide-BASH.m4 m4/ccide-BASIC.m4 m4/ccide-QB.m4 \\"		   >> $PTMPLT
	echo "EXTRA_DIST = autogen.sh src/ccide.1 ccide.spec src/ccidew ccide.spec.in ChangeLog CYGWIN-PATCHES/setup.hint.in scripts/ccide.in \\" 	 								   >> $TMPLT
	MakeEntry "	src/Makefile.in  src/ccide.pod.in src/ccideconfig.h.in"
	MakeEntry "	src/ccidemain.h src/ccide.h src/parse.h \$(srcdir)/src/ccidelex.l"
	MakeEntry "	src/ccideinline.c  src/ccidelex.c  src/ccidemain.c  src/ccideparse.c src/ccideparse.y  src/cciderunx.c"
	MakeEntry "	tests/f1 tests/f2 tests/f3 tests/f4 tests/if2rpn.txt tests/Makefile"
	MakeEntry "	scripts/check.sh scripts/Makefile scripts/Makefile.in scripts/ccide.in"
	for TINPUT in src/ccide*.d; do 
		echo $TINPUT							   >> $TMPLT
	done						   
	for TINPUT in *.in; do
			T=`basename $TINPUT .in`
			# echo $TINPUT $T
			MakeEntry "	$TDIR/$TINPUT"
			[ -f $T.d ]    && MakeEntry "	$TDIR/$T.d " 
			[ -f $T.opt ]  && MakeEntry "	$TDIR/$T.opt " 	
			[ -f $T.right ] && MakeEntry "	$TDIR/$T.right " 	
	done				   
	for TINPUT in *.X; do
			MakeEntry "	$TDIR/$TINPUT"	
			T=`basename $TINPUT .X`
			[ -f $T.h ] && MakeEntry "	$TDIR/$T.h "
	done
	echo 				"	scripts/check.sh "	>> $TMPLT	
	echo "	m4/ccide-VB.m4 m4/ccide-JAVA.m4 m4/ccide-CS.m4 m4/ccide-EX.m4"  >> $PTMPLT
}

Usage() {
	cat << EOF

	Usage:
		$0 all			. Test all cases
		$0 right CASENAME	. Create CASENAME*.in & CASENAME*.right files
		$0 CASENAME		. Run CASENAME test.  Ex.  "$0 calc"
		$0 -V			. Show check.sh version
		$0 [--help]		. Show usage

EOF
	exit 1
}


MakeRight() {
	for T in $*; do 
		X=`ls $T*.d`
		SFX=`echo $X|cut -f2 -d.`
		Y=`ls $T*.$SFX `
		for X in $Y; do
			Z=`basename $X .$SFX`
			echo make $Z.$SFX.right from $Z.$SFX
			cp -avp $Z.$SFX  $Z.$SFX.right 	
			# && sed -e "s/$VERSION/\$CCIDE_VERSION/g" $Z.$SFX.right > $Z.$SFX.in  
		done
	done
}

VERSION=0.6.2-1
[ -d ../tests ] && pushd ../tests 
[ -d ./tests  ] && pushd ./tests
[ -f threeway.c.in ] || Die cannot find threeway.c.in 

case $1 in
	--help)	Usage;;
	-V)	echo 	check.sh-0.0;;
	all)	shift; 	All $*;;
	mkam)shift; MakeAM $*;;
	mkright)shift;	MakeRight $*;;
	*) 	[ -z $1 ] && Usage 
	   	for T in $*; do 
			TestCase $T 	\
			&& Success "Test $T" 	\
			|| Fail "Test" $T  
	  	done
	        Summarize
	   ;;
esac
	
