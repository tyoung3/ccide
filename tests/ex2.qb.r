REM Taken from http://www.romankoch.ch/capslock/vbdectable.htm

;CCIDE_INLINE_CODE:
rem GENERATED_CODE:

rem ccide-VB.m4
	rem Copyright (C) 2002-2004,2010,2012; Thomas W. Young, e-mail:  ccide@twyoung.com
 	rem The code generated by ccide is covered by the same license as the source  
 	rem code(decision table) from which it is derived. If you created the source,  
 	rem you are free to do anything you like with the generated code, 
 	rem including incorporating it into or linking it with proprietary software.  
	

DIM CCIDETABLEYES(100) As Integer
DIM CCIDETABLENO(100)  As Integer
DIM CCIDE As Integer
DIM CCIDENSTATE As Integer

              REM Return rule number 
Public Function CCIDEFINDRULE(NBRRULES As Integer, CCIDE_TABLE As Integer) As Integer
	CCIDE=0
        CCIDENSTATE=4294967295 XOR ccide_table
        WHILE  ( (CCIDETABLEYES(CCIDE) AND CCIDENSTATE) OR (CCIDETABLENO(CCIDE)  AND CCIDE_TABLE) ) AND ( CCIDE < NBRRULES )
		CCIDE = CCIDE  + 1
	WEND
	CCIDEFINDRULE=CCIDE
End Function

              REM Return rule number 
Public Function CCIDEFINDRULEYES(NBRRULES As Integer, CCIDE_TABLE As Integer) As Integer
	CCIDE=0
        CCIDENSTATE=4294967295 XOR ccide_table
        WHILE ( CCIDETABLEYES(CCIDE) AND CCIDENSTATE) AND ( CCIDE < NBRRULES )
		CCIDE = CCIDE  + 1
	WEND
	CCIDEFINDRULE=CCIDE
End Function
rem END_GENERATED_CODE:

;DECISION_TABLE:
;   Y  Y  Y  Y  Y  Y  Y  Y  N  N | bNetwork
;   Y  Y  Y  Y  N  N  N  N  -  - | bFast
;   Y  Y  N  N  Y  Y  N  N  -  - | bNewer
;   Y  N  Y  N  Y  N  Y  N  Y  N | bLocal
;____________________ | ______
;   X  -  -  X  X  -  -  -  -  - | rem ask if user wants to download
;   -  X  -  -  -  -  -  X  -  - | rem how can the original be newer than the copy if there is no copy?
;   -  -  X  -  -  -  X  -  X  - | rem continue with local copy
;   -  -  -  -  -  X  -  -  -  - | rem tell user that program can only continue after download
;   -  -  -  -  -  -  -  -  -  X | rem inform user that program cannot continue
;END_TABLE:
rem 
rem 
rem 
 	DIM CCIDE_table1_yes(10)
DIM CCIDE_table1_no(10)


	CCIDE=
		  (bNetwork)
		| (bFast)<<1
		| (bNewer)<<2
		| (bLocal)<<3
		  
CCIDE=CCIDEFINDRULE(10, CCIDE):Select Case CCIDE

	CCIDE_1_9: case 9:	rem 
	    rem inform user that program cannot continue
	    
	CCIDE_1_5: case 5:	rem 
	    rem tell user that program can only continue after download
	    
	CCIDE_1_2: case 2:	rem 
	CCIDE_1_6: case 6:	rem 
	CCIDE_1_8: case 8:	rem 
	    rem continue with local copy
	    
	CCIDE_1_1: case 1:	rem 
	CCIDE_1_7: case 7:	rem 
	    rem how can the original be newer than the copy if there is no copy?
	    
	CCIDE_1_0: case 0:	rem 
	CCIDE_1_3: case 3:	rem 
	CCIDE_1_4: case 4:	rem 
	    rem ask if user wants to download
	    
	END SELECT

rem 

