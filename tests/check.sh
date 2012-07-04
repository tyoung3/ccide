#!/bin/bash

# CHECK.SH:  Test ccide 
PGM=`pwd`/../ccide
OPT="-b -c 2"
export CCIDEW=`pwd`/../ccidew

Die() {
        echo "$0/DIE: $*"
        exit 1
}

Success() {
        NS=$(( $NS + 1 ))
        echo -e "               \033[0;32;32m ****  Test $1 Success!   **** \033[0;32;39m"
}

# && Success $DESC || Fail $DESC

Fail() {
        echo -e "               \033[0;32;31m ????   Test $1 Failed   ????\033[0;32;39m"
        NFAIL=$(($NFAIL+1))
}


Summarize() {
        if [ $NFAIL > 0 ]; then                 
                Fail "$NFAIL tests failed and $NS succeeded."
        else 
                Success "All $NS tests succeeded. Total"
        fi
}

Check() {
	DESC="Version Check"
        $PGM -V >/dev/null && Success $DESC || Fail $DESC
	pushd ccide.test >/dev/null || Die Cannot cd ccide.test
		for TIN in *.in ; do
			T=`basename $TIN .in`
			DESC=$T
			. $T.opt 2>/dev/null || OPT="-b -c 2"
			$PGM $OPT < $T.in 2> $T.err > $T.c   
			( diff $T.c $T.right >/dev/null && make $T >/dev/null)    && Success $DESC || Fail $DESC
		done
	popd >/dev/null

}

ShowEm() {
	pushd ccide.test >/dev/null || Die Cannot cd ccide.test
		for TIN in *.in ; do
			T=`basename $TIN .in`
			( echo Testing $T; diff $T.c $T.right) |less    
		done
	popd >/dev/null
}

Reset() {
	MASTER=/mnt/sda7/git/ccide
	pushd ccide.test >/dev/null || Die Cannot cd ccide.test
		for TIN in *.in ; do
			T=`basename $TIN .in`
			cp $T.c $T.right || Die Cannot cp $T.c $T.right
			cp $T.c  $MASTER/tests/ccide.test/$T.right || Die Cannot mv $T.c to $MASTER/tests/ccide.test/$T.right
		done
	popd >/dev/null

}

[ -x $PGM ] || Die $PGM is missing
[ -x $CCIDEW ] || Die $CCIDEW is missing

case $1 in
	show)shift; ShowEm;; 
	reset)shift;Reset;;
	*)
	Check
	Summarize;;
esac
