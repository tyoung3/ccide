#!/bin/bash

# CHECK.SH:  Test ccide 
[ -f threeway.c.d ] || cd tests || Die Cannot cd tests 
export CCIDEW=`pwd`/../src/ccidew
export CCIDE_M4DIR=`pwd`/../m4
PGM=`pwd`/../scripts/ccide
OPT="-b -c 2"

Die() {
        echo "$0/DIE: $*"
        exit 1
}

Success() {
        NS=$(( $NS + 1 ))
        echo -e "               \033[0;32;32m ****  Test $1 Success!	**** \033[0;32;39m"
}

Fail() {
        echo -e "               \033[0;32;31m ????   Test $1 Failed   ????\033[0;32;39m"
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
	[ "$2" == "c" ]    && ( make -B $X 	|| return 1 ) 
	[ "$2" == "cpp" ]  && ( make -B $X 	|| return 1 )
	[ "$2" == "c++" ]  && ( make -B $X 	|| return 1 )
	[ "$2" == "bash" ] && ( cp -avp $T $X  && chmod a+x $X	|| return 1 )
	return 0
}

TestIt() {
	./$X $TOPT < /dev/null >$X.output  	\
	&& diff -q $T.X $X.output  >/dev/null	

}

Check() {
	DESC="Version Check"
        $PGM -V  && Success $DESC || Fail $DESC
	for TINPUT in *.d ; do
		if [ "$TINPUT" != "*.d" ]; then 
			T=`basename $TINPUT .d`
			SFX=`echo $T |cut -f2 -d.`    	
			DESC=$T; TOPT=;TOUT=;TIN=; OPT="-b -c 2"
			[ -f $T.opt ] && . $T.opt 2>/dev/null  
			case $SFX in
				sh|bash|SH|BASH)$PGM 	$OPT -L BASH 	< $T.d 2> $T.err > $T;;
				bas|BAS)$PGM 		$OPT -L BASIC 	< $T.d 2> $T.err > $T;;
				cc|CC)$PGM 		$OPT -L CC 	< $T.d 2> $T.err > $T;;
				c|C)$PGM 		$OPT 		< $T.d 2> $T.err > $T;;
				   #echo "$PGM $OPT < $T.d > $T"   
				cpp|c++|CPP|C++)$PGM 	$OPT -L C++ 	< $T.d 2> $T.err > $T;;
				cs|CS)$PGM 		$OPT -L CS 	< $T.d 2> $T.err > $T;;
				ex|EX)$PGM 		$OPT -L EX 	< $T.d 2> $T.err > $T;;
				java|JAVA)$PGM 		$OPT -L JAVA 	< $T.d 2> $T.err > $T;;
				m4|M4)$PGM 		$OPT -m4 	< $T.d 2> $T.err > $T;;
				vb|VB)$PGM 		$OPT -L VB 	< $T.d 2> $T.err > $T;;
				qb|QB)$PGM 		$OPT -L QB 	< $T.d 2> $T.err > $T;;
				*)Die Cannot handle $T;;
			esac   
			diff -q $T $T.right >/dev/null 		\
			  	&& MakeIt $T $SFX 2>&1 >$T.make.out	\
			  	&& Success "$DESC generate"		\
			  	|| Fail "$DESC generate"
			 [ -f $T.X ] 					\
			  	&&  X=`basename $T .$SFX`		\
			  	&& TestIt && Success "$DESC execute" || Fail "$DESC execute"  	
		fi
	done 

}

ShowEm() {
		for TINPUT in *.right ; do
			T=`basename $TINPUT .right`
			( echo Testing $T; diff $T $T.right) |less    
		done
}

Reset() {
		MASTER=/mnt/sda7/git/ccide
		for TINPUT in *.right ; do
			T=`basename $TINPUT .right`
			cp $T $T.right || Die Cannot cp $T $T.right/$T.right
		done

}

MakeEntry() {
	echo 	"$* \\" 	>> $TMPLT
	echo 	"$* \\" 	>> $PTMPLT 
}

		# Convert FOO.c.in to FOO.c.right
MakeRight() {	
	VERSION=$1
	for TINPUT in *.in; do
		T=`basename $TINPUT .in`
		[ "$T" == "Makefile" ] || sed -e "s/\$CCIDE_VERSION/$VERSION/g" $T.in > $T.right
	done
}

MakeAM() {
	TMPLT=`pwd`/../extra_dist.mk
	PTMPLT=`pwd`/../disp_pkg.mk
	TDIR=./tests					 
	echo "#Generated by $0 on `date`." 					   > $TMPLT
	echo "#Generated by $0 on `date`." 					   > $PTMPLT
	echo "dist_pkgdata_DATA = m4/ccide-C.m4  m4/ccide-CC.m4 m4/ccide-C++.m4\\" >> $PTMPLT
	echo "	m4/ccide-BASH.m4 m4/ccide-BASIC.m4 m4/ccide-QB.m4 \\"		   >> $PTMPLT
	echo "EXTRA_DIST = build src/ccide.1 ccide.spec src/ccidew ccide.spec.in ChangeLog CYGWIN-PATCHES/setup.hint.in scripts/ccide.in \\" 	 								   >> $TMPLT
	MakeEntry "	scripts/check.sh scripts/ccide tests/f1 tests/f2 tests/f3 tests/f4 tests/Makefile"

		for TINPUT in *.in; do
			T=`basename $TINPUT .in`
			# echo $TINPUT $T
			MakeEntry "	$TDIR/$TINPUT"
			[ -f $T.d ]    && MakeEntry "	$TDIR/$T.d " 
			[ -f $T.opt ]  && MakeEntry "	$TDIR/$T.opt " 		
			[ -f $T.X ]    && MakeEntry "	$TDIR/$T.X " 	
		done
		echo 				"	scripts/check.sh "	>> $TMPLT	
	echo "	m4/ccide-VB.m4 m4/ccide-JAVA.m4 m4/ccide-CS.m4 m4/ccide-EX.m4"  >> $PTMPLT
}

CheckProgs() {
	[ -x $PGM ] || chmod a+x $PGM || Die $PGM is missing
	[ -x $CCIDEW ] || Die $CCIDEW is missing
}

case $1 in
	show)shift; ShowEm;; 
	reset)echo fix first;exit 1;shift;Reset;;
	mkam)shift; MakeAM $*;;
	mkright)shift; MakeRight $*;;
	*)CheckProgs
	Check
	Summarize
	;;
esac
