/** 
 * The HelloWorldApp2 class implements an application that tests ccide -L java ...
 */


//CCIDE_INLINE_CODE: 

class hw {
    public static void main(String[] args) {
        System.out.println("Hello World!"); //Display the string.
	String A,B,C,D,E; 
	int state=0;
	A = "A"; B = "B"; C = "C"; D = "D"; E = "E";
	
	for (int i = 0; i < args.length; i++) {
	        System.out.println(args[i]);    

		//DECISION_TABLE:
		// Y - - | A.compareTo(args[i]) == 0
		// - Y - | B.compareTo(args[i]) == 0
		// - - Y | C.compareTo(args[i]) == 0
		// _____ |_________________________
		// X - - | System.out.println("Got A!");
		// - X - | System.out.println("Got B!");
		// - - X | System.out.println("Got C!");
		//END_TABLE:
	}

	for (int i = 0; i < args.length; i++) {
	        System.out.println(args[i]);    

		//DECISION_TABLE:
		// Y - - | A.compareTo(args[i]) == 0
		// - Y - | B.compareTo(args[i]) == 0
		// - N Y | C.compareTo(args[i]) == 0
		// N N N | D.compareTo(args[i]) == 0
		// _____ |_________________________
		// X - - | System.out.println("B: Got A!");
		// - X - | System.out.println("B: Got B!");
		// - - X | System.out.println("B: Got C!");
		//END_TABLE:
	}

	for (int i = 0; i < args.length; i++) {
	        System.out.println(args[i]);    

		//DECISION_TABLE:
		// Y | E.compareTo(args[i]) == 0
		//  _ |_________________________
		// X | System.out.println("C: Got E!");
		//END_TABLE:
	}
	   while(state<4) {
		//DECISION_TABLE:
		// 0 1 2 3 | state == $$
		// ________|_________________________
		// 0 1 2 3 | System.out.println("State=$$");
		// 1 2 3 4 | state = $$;
		//END_TABLE:
	   }  // End while state<4

	   for (int j = 0; j < args.length; j++) {
		//DECISION_TABLE:
		// 0 1 2 3 | state == $$
		// Y N - - | A.compareTo(args[j]) == 0
		// ________|_________________________
		// 0 1 2 3 | System.out.println("State=$$");
		// 1 2 3 4 | state = $$;
		//END_TABLE:
	   }  // End for j=...	
    }		
}
