/* t6.ex.ccide:  Hello World in Euphoria  with decision table */
/*CCIDE_INLINECODE:	*/
   
	integer state
	ccide_group = 1
	state = 4

        /*DECISION_TABLE:		*/
	/*  1 2 3 | ccide_group == $$	*/
        /*  _______________		*/
        /*  X - - | puts(1,"1.\n")	*/
        /*  - x - | puts(1,"2.Hello\n") */
        /*  - - X | puts(1,"3.World\n")	*/
	/*  2 3 4 | NEWGROUP		*/
        /*END_TABLE:			*/

        /*DECISION_TABLE:       	*/
	/*  Y N Y | state = 4		*/
	/*  1 5 6 | NEWGROUP		*/
        /* __________________		*/
        /*  x - - | puts(1,"4.\n")	*/
        /*  - X - | puts(1,"5.Goodbye\n") */
        /*  - - x | puts(1,"6.World\n")	*/
	/*  5 4 6 | state=$$		*/
	/*  5 6 7 | NEWGROUP 		*/
        /*END_TABLE:			*/

        /*DECISION_TABLE:       	*/
	/*  Y - - | state = 6		*/
	/*  - Y - | state = 7		*/
	/*  - - Y | state = 8		*/
	/*  1 8 9 | NEWGROUP		*/
        /* __________________		*/
        /*  x - - | puts(1,"7.\n")	*/
        /*  - X - | puts(1,"8.Goodbye") */
	/*  - X - | puts(1," cruel\n")	*/
        /*  - - x | puts(1,"9.World\n")	*/
	/*  7 8 9 | state=$$		*/
	/*  8 9 0 | NEWGROUP 		*/
        /*END_TABLE:			*/
	
	if (state = 9) then
		puts(1,"t6.ex succeeded!\n")
		abort (0)
	else 
		puts(1,"t6.ex Failed.\n")
		abort (1)
	end if
 


