//CCIDE_INLINE_CODE:
#include <iostream>
using namespace std;
int main ()
{
  double number;
  cout<<"Enter a number ";
  cin>>number;
  string sign;

/*  manually coded version
if( number > 0) sign = "positive";
else if (number<0) sign = "negative";
else sign = "zero";
*/

//DECISION_TABLE:
// Y - - |number > 0
// - Y - |number < 0
// - - Y |number == 0
//______________________
// X - - |sign = "positive";
// - X - |sign = "negative";  
// - - X |sign = "zero";	
//END_TABLE:

  cout<<number<< " is "<<sign<<endl;
  return 0;
}
