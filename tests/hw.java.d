/** 
 * The hw class implements an application that tests ccide -L JAVA  < FOOBAR.java 

		ccide - C Language Decision Table Code Generator 

	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

    	This file is part of ccide, the C Language Decision Table Code Generator.

   	Ccide is free software: you can redistribute it and/or modify
   	it under the terms of the GNU General Public License as published by
    	the Free Software Foundation, either version 3 of the License, or
   	(at your option) any later version.

    	Ccide is distributed in the hope that it will be useful,
    	but WITHOUT ANY WARRANTY; without even the implied warranty of
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    	GNU General Public License for more details.

    	You should have received a copy of the GNU General Public License
    	along with Ccide.  If not, see <http://www.gnu.org/licenses/> or
    	write to the Free Software Foundation, Inc., 51 Franklin St, 
    	Fifth Floor, Boston, MA 02110-1301 USA.
*/

/* THISIS: hw.java.d */

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
