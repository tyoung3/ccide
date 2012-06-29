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
			# echo BASE=$T
			DESC=$T
			. $T.opt 2>/dev/null || OPT="-b -c 2"
			$PGM $OPT < $T.in 2> $T.err > $T.c   
			diff $T.c $T.right >/dev/null   && Success $DESC || Fail $DESC
		done
	popd >/dev/null

}

Nullo() {
        TestHello > /tmp/check.out 2>/tmp/check.err && ShowBal >/tmp/ShowBal.out 2>/tmp/ShowBal.err && echo $* TestHello checks OK! &
        for  NDL in test*.ndl; do
                echo -n Testing ${NDL}: 
                ../dfd -g0 <$NDL 2>/dev/null >/dev/null && Success $NDL || Fail $NDL
        done
        for  NDL in fail*.ndl; do
                echo -n Testing ${NDL}: 
                ../dfd -g0 <$NDL 2>/dev/null >/dev/null && Fail $NDL || Success $NDL
        done
        
        Summarize
        
}

[ -x $PGM ] || Die $PGM is missing
[ -x $CCIDEW ] || Die $CCIDEW is missing

Check
Summarize
