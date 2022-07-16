
##  Utterly useless program, but helps test coverage.
##CCIDE_INLINE_CODE:
##DECISION_TABLE:
# #    1   2   3   4   5   6   7   8 |NEWGROUP		
# #    Y   -   Y   -   Y   -   -   - |  Bc=1
# #    -   Y   Y   -   -   Y   -   - |  Bc=3
# #    -   -   Y   -   -   -   Y   - |  Bc1 >> 5
# #    -   -   Y   Y   -   -   -   - |  Bc2 >>> 6
##___________________________________
# #    X   -   -   -   X   -   X   - |  [ Act 1 ]
# #    -   X   -   -   X   X   -   - |  [ Act 2 ]
# #    -   -   -   -   X   X   -   - |  [ Act 3 ]
# #    -   -   -   X   -   -   -   X |  [ Act 5 ]
# #    -   -   -   -   X   X   -   - |  [ Act 1 ]
# #    2   3   4   5   6   7   8   - |NEWGROUP		
##END_TABLE:
CCIDE_COMMENT()(GENERATED_CODE: FOR TABLE_1.)
CCIDE_COMMENT()(	8 Rules, 5 conditions, and 14 actions.)
CCIDE_COMMENT()(        Rule 1 and rule 5 conflict)
CCIDE_COMMENT()(        Rule 2 and rule 6 conflict)
CCIDE_COMMENT()(	Table 1 rule order = 3 1 2 5 6 7 4 8 )
 CCIDE_BEGIN_BLOCK()	CCIDE_TABLE_YES(1, 8, 30, 3, 6, 18, 24, 36, 72, 128)
	ccide_group=1;

CCIDE_LABEL(CCIDE_TABLE_1)
	CCIDE_SWITCH_YES(8,
		  (ccide_group == $$)
		| (Bc=1)<<1
		| (Bc=3)<<2
		| (Bc1 >> 5)<<3
		| (Bc2 >>> 6)<<4
		  ,1)
	CCIDE_CASE(1, 6,7)
	    CCIDE_ACTION(([ Act 1 ]))
	    CCIDE_ACTION((ccide_group = 3;))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 5,6)
	    CCIDE_ACTION(([ Act 2 ]))
	    CCIDE_ACTION(([ Act 3 ]))
	    CCIDE_ACTION(([ Act 1 ]))
	    CCIDE_ACTION((ccide_group = 2;))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 3,5)
	    CCIDE_ACTION(([ Act 1 ]))
	    CCIDE_ACTION(([ Act 2 ]))
	    CCIDE_ACTION(([ Act 3 ]))
	    CCIDE_ACTION(([ Act 1 ]))
	    CCIDE_ACTION((ccide_group = 1;))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 4,4)
	    CCIDE_ACTION(([ Act 5 ]))
	    CCIDE_ACTION(([ Act 1 ]))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 0,3)
	    CCIDE_ACTION(([ Act 5 ]))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 2,2)
	    CCIDE_ACTION(([ Act 2 ]))
	    CCIDE_ACTION(([ Act 3 ]))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 1,1)
	    CCIDE_ACTION(([ Act 1 ]))
	    CCIDE_ACTION(([ Act 2 ]))
	    CCIDE_ACTION((goto CCIDE_TABLE_1;))
	CCIDE_CASE(1, 7,8)
	    CCIDE_ACTION(([ Act 5 ]))
	    CCIDE_BREAK()
	CCIDE_END_SWITCH()
CCIDE_COMMENT()(END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.3-1  )
