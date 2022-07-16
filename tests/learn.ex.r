	-----------------------------------------------
	-- A Quiz to Test Your Knowledge of Euphoria --
	-----------------------------------------------
include std/get.e
include std/graphics.e

--CCIDE_INLINE_CODE:
GENERATED_CODE:*/
/*
	ccide-EX.m4  Version 0.3. Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
 		The code generated by ccide is covered by the same license as the source  
 		code(decision table) from which it is derived. If you created the source,  
 		you are free to do anything you like with the generated code, 
 		including incorporating it into or linking it with proprietary software.  
	
*/

integer ccide_group, CCIDE_UINT_MAX
	ccide_group=1
	CCIDE_UINT_MAX=1073741823

function CcideSetCond(integer n, sequence s)   
	integer i

	switch (n) do
		case 0 then
			return 0
		case 1 then
			return s[1]
		case 2  then
			return( or_bits( s[1], s[2] + s[2] ) )
		case else 
			i = CcideSetCond( n-2, tail(s,n-2) )
			i+=i
			i+=i
			return( or_bits( or_bits( s[1], s[2] + s[2] ),i) )
	end switch
end function

function CcideFindRule(			-- Return rule number
	integer nbrrules,
	atom ccide_table,
	sequence yes,
	sequence no)
        integer r
        atom nstate

	r=1
        nstate = xor_bits( CCIDE_UINT_MAX, ccide_table)

        while (1) do
	   if ( and_bits(yes[r],nstate) or and_bits(no[r],ccide_table) ) then 
		r+=1
	   else
		 return r-1 
           end if 
	   if r>nbrrules then
		return r
	   end if
	end while
end function

function CcideFindRuleYes(             -- Return rule number 
	integer nbrrules,
	atom ccide_table,	
	sequence yes)

        integer r
        atom nstate
	r=1
        nstate = xor_bits(CCIDE_UINT_MAX, ccide_table)

        while (1) do
	   if ( and_bits(yes[r],nstate) ) then
		r+=1
	   else
		return r-1
           end if
	   if r>nbrrules then
		return r
	   end if
	end while
end function

/*END_GENERATED_CODE
/*GENERATED_CODE: */
/* Substitution strings are: $$ and $@*/
/*END_GENERATED_CODE: */

constant NTRYS = 3
constant KEYBOARD = 0, SCREEN = 1

procedure get_answer(object correct)
    sequence answer
    atom t
    integer c
    
    for i = 1 to NTRYS do
	answer = get(KEYBOARD)
	puts(SCREEN, '\n')
	/*DECISION_TABLE:				*/
	/*   Y  Y  - | answer[1] = GET_SUCCESS        	
	/*   Y  N  - | equal(answer[2], correct)	
	/*   -  Y  - | i < NTRYS    			
	/* ____________________________			*/
	/*   X  -  - | puts(SCREEN, "Correct!\n\n")	*/ 
	/*   X  -  - | t = time()			
	/*   X  -  - | while time() < t+0.1 do		
	/*   X  -  - | end while			
	/*   X  -  - | return				
	/*   -  X  - | puts(SCREEN, "Try again\n")	
	/*   -  X  - | t = time()			
	/*   -  X  - | while time() < t+0.4 do		
	/*   -  X  - | end while			
	/*   -  -  - | puts(SCREEN, "syntax error - a Euphoria object is expected\n")	
	/*   -  -  X | -- clear rest of line:		
	/*   -  -  X |    for j = 1 to 100 do		
	/*   -  -  X |c = getc(KEYBOARD)		
	/*   -  -  X |if c = -1 then			
	/*   -  -  X |    abort(0)			
	/*   -  -  X |elsif c = '\n' then		
	/*   -  -  X |    exit			
	/*   -  -  X |end if				
	/*   -  -  X |   end for 			
	/*END_TABLE:					*/
	/*GENERATED_CODE: FOR TABLE_1.*/
	/*	3 Rules, 3 conditions, and 19 actions.*/
	/*	Table 1 rule order = 2 1 3 */
	 	
	


		switch(CcideFindRule(3,
			CcideSetCond(3,{answer[1] = GET_SUCCESS,equal(answer[2], correct),i < NTRYS}),
			{5,3,0},
			{2,0,0})) do
		case 2 then /*Rule 3*/
		    -- clear rest of line:
		    for j = 1 to 100 do
		    c = getc(KEYBOARD)
		    if c = -1 then
		    abort(0)
		    elsif c = \n' then'
		    exit
		    end if
		    end for
		    break;
		case 0 then /*Rule 2*/
		    puts(SCREEN, "Try again\n")
		    t = time()
		    while time() < t+0.4 do
		    end while
		    break;
		case 1 then /*Rule 1*/
		    puts(SCREEN, "Correct!\n\n")	*/
		    t = time()
		    while time() < t+0.1 do
		    end while
		    return
		    break;
		end switch
	/*END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.5-1  */
--	if answer[1] = GET_SUCCESS then
--	    if equal(answer[2], correct) then
--		puts(SCREEN, "Correct!\n\n")
--		t = time()
--		while time() < t+0.1 do
--		end while
--		return
--	    elsif i < NTRYS then
--		puts(SCREEN, "Try again\n")
--		t = time()
--		while time() < t+0.4 do
--		end while
--	    end if
--	else
--	    puts(SCREEN, "syntax error - a Euphoria object is expected\n")
--	    -- clear rest of line:
--	    for j = 1 to 100 do
--		c = getc(KEYBOARD)
--		if c = -1 then
--		    abort(0)
--		elsif c = '\n' then
--		    exit
--		end if
--	    end for 
--	end if    
--    end for
    puts(SCREEN, "The correct answer was: ")
    print(SCREEN, correct)
    puts(SCREEN, '\n')
end procedure

procedure part1()
-- evaluating simple expressions
    object x, y

    puts(SCREEN, "Please evaluate the following Euphoria expressions\n")
    puts(SCREEN, "You have 3 guesses.\n\n")

    x = rand(10)
    y = rand(10)
    printf(SCREEN, "%d + %d\n", {x, y})
    get_answer(x + y)

    x = rand(repeat(10, 3))
    y = rand(10)
    print(SCREEN, x)
    puts(SCREEN, " * ")
    print(SCREEN, y)
    puts(SCREEN, '\n')
    get_answer(x * y)

    x = rand(repeat(10, 4)) - 5
    y = rand(repeat(10, 4)) - 5
    print(SCREEN, x)
    puts(SCREEN, " > ")
    print(SCREEN, y)
    puts(SCREEN, '\n')
    get_answer(x > y)    

    x = rand(20)
    y = rand(5)
    puts(SCREEN, "repeat(")
    print(1, x)
    puts(SCREEN, ", ")
    print(1, y)
    puts(SCREEN, ")\n")
    get_answer(repeat(x, y))
    
    x = rand(repeat(25, 3)) + 'a'
    y = rand(repeat(25, 2)) + 'a'
    printf(SCREEN, "\"%s\" & \"%s\"\n", {x, y})
    get_answer(x & y)

    x = rand(repeat(99,3))
    y = rand(repeat(99,2))
    puts(SCREEN, "append(")
    print(SCREEN, x)
    puts(SCREEN, ", ")
    print(SCREEN, y)
    puts(SCREEN, ")\n")
    get_answer(append(x, y))
    
    puts(SCREEN, "what will the value of x be\n")
    puts(SCREEN, "after executing the following statements?\n")
    puts(SCREEN, "x = ")
    x = rand({10, 10, {10, 10, 10, 10}, 20})
    print(SCREEN, x)
    y = rand({20, 20, 20, 20, 20})
    puts(SCREEN, "\ny = ")
    print(SCREEN, y)
    puts(SCREEN, "\nx[3][2..3] = y[4..5]\n")    
    x[3][2..3] = y[4..5]
    get_answer(x)
end procedure

part1()   -- quick questions
