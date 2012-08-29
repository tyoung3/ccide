// t2.cs.ccide:  Hello World in C Sharp with decision table
class Hello {
//CCIDE_INLINE_CODE:
   
   static void Main() {
	int ccide_group=1,state=4;

        //DECISION_TABLE:					 
	//  1 2 3 | NEWGROUP 					 
        //  ______|________					 
        //  X - - | System.Console.WriteLine("1.");		 
        //  - X - | System.Console.WriteLine("2.Hello");	 
        //  - - X | System.Console.WriteLine("3.World");	 
	//  2 3 4 | NEWGROUP				 
        //END_TABLE:						 

        //DECISION_TABLE:					 
	//  Y N Y | state==4 					 
	//  1 5 6 | NEWGROUP					 
        //  ______|________					 
        //  x - - | System.Console.WriteLine("4.");		 
        //  - x - | System.Console.WriteLine("5.Goodbye");	 
        //  - - x | System.Console.WriteLine("6.World");	 
	//  5 4 - | state=$$;					 
	//  5 6 7 | NEWGROUP				 
        //END_TABLE:						 
	
	if(ccide_group == 7) System.Console.WriteLine("Success!\n");
	else System.Console.WriteLine("Failed.\n");
 
    }  // End of Main

}  // End of Hello

