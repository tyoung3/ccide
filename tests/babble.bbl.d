
~~  Utterly useless program, but helps test coverage.
	  ~~BABBLE_INLINE_CODE:
	  ~~DECISION_TABLE:
	  ~~ 1  2  3  4  5  6  7  8  |NEWGROUP
	  ~~ Y  -  Y  -  N  -  -  -  |  Bc=1
	  ~~ -  Y  Y  -  -  N  -  -  |  Bc=3
	  ~~ -  -  Y  -  -  -  N  -  |  Bc1 >> 5
	  ~~ -  -  Y  Y  -  -  -  -  |  Bc2 >>> 6
	  ~~___________________________________
	  ~~ X  -  -  -  X  -  X  -  |  [ Act 1 ]
	  ~~ -  X  -  -  X  X  -  -  |  [ Act 2 ]
	  ~~ -  -  -  -  X  X  -  -  |  [ Act 3 ]
	  ~~ -  -  -  X  -  -  -  X  |  [ Act 5 ]
	  ~~ -  -  -  -  X  X  -  -  |  [ Act 1 ]
	  ~~ 2  3  4  5  6  7  8  -  |  NEWGROUP
	  ~~END_TABLE:
