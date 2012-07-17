/* IF2RPN.H 
*/

#ifndef IF2RPN_H_
#define IF2RPN_H_

typedef char  TOKEN;
typedef int STATE;
typedef enum { 	EMPTY=0, 	NUMBER,   FUNCTION_TOKEN, SEPARATOR, 	LEFT_PAREN, 
		RIGHT_PAREN=5, 	OPERATOR, EQUAL, 	  PLUS, 	MINUS, 
		TIMES, DIV,	NTOK} 
	TYPE;
typedef TYPE TOKEN_TYPE;

extern 	TYPE token;

#define SSIZE 1000
#define TOS stack[SP]

extern TYPE stack[];
extern int SP;  	/* Stack Pointer */

STATE GetPrecedence();
TYPE GetToken();

void PushToken();
void OutputToken();  
void OutputNumber();
void PopToQueue();
void Pop();

#endif // IF2RPN_H_
