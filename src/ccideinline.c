/*  	ccide - C Language Decision Table Code Generator 
	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

    	This file is part of ccide, the C Language Decision Table Code Generator.

   	ccide is free software: you can redistribute it and/or modify
   	it under the terms of the GNU General Public License as published by
    	the Free Software Foundation, either version 3 of the License, or
   	(at your option) any later version.

    	ccide is distributed in the hope that it will be useful,
    	but WITHOUT ANY WARRANTY; without even the implied warranty of
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    	GNU General Public License for more details.

    	You should have received a copy of the GNU General Public License
    	along with ccide.  If not, see <http://www.gnu.org/licenses/> or
    	write to the Free Software Foundation, Inc., 51 Franklin St, 
    	Fifth Floor, Boston, MA 02110-1301 USA.
*/

/* ccideinline.c: Generate inline code.  Generate skeleton program */

/*  NLS support */
#include "gettext.h"
#define _(string) gettext (string)

#include <stdio.h>
#include <string.h>
#include "ccidemain.h"

#define J_(L) printf("%s %c",_(L),'\n');
#define J(L) printf("%s %c",L,'\n');

char *slang = "";		/* D/T file source language: C, C++, etc. */

/** Print 'Generated Code' message.
 */
void
GenInLineCode (char *s)
{

  if (noinline)
    return;

  noinline = 1;

  if (m4out)
    {
      printf ("%s_INLINECODE()\n", pPrefix);
      if (changequote)
	{
	  printf ("%sGENERATED_CODE: %s\n", M4Comment, M4Ecomment);
	  printf (_
		  ("%s_COMMENT(%s Substitution strings are: %s and %s%s)\n"),
		  pPrefix, qt1, svar1, svar2, qt2);
	  printf ("%sEND_GENERATED_CODE: %s\n", M4Comment, M4Ecomment);
	}
      return;
    }

  printf ("%sGENERATED_CODE: %s\n", pComment, pEcomment);
  printf ("#ifndef __%s_INLINE_C\n", pPrefix);
  printf ("#define __%s_INLINE_C\n\n/*", pPrefix);

    printf ("ccide-%s-%s\n", VERSION, RELEASE);
    J_ ("ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com") 
    J_ ("The code generated by ccide is covered by the same license as the source ") 
    J_ ("code(decision table) from which it is derived. If you created the source, ") 
    J_ ("you are free to do anything you like with the generated code,") 
    J_ ("including incorporating it into or linking it with proprietary software. ") 
    J ("*/") printf ("static int %s_group=1;", pPrefixLc);
    J ("")
    J ("#ifndef UINT_MAX")
    J ("#include \"limits.h\"")
    J ("#endif /* End if not defined UINT_MAX */")
    J ("")
    J_ ("		/* Return rule number */")
    printf ("static int %sFindRule(\n", pPrefix);
    printf("	int nbrrules,  unsigned long ccide_table, unsigned long yes[], unsigned long no[])");
    J ("{") J ("        int r=0;") J ("        unsigned long nstate;") J ("")
    J ("        nstate = UINT_MAX ^ ccide_table;") J ("")
    J ("        while (")
    J ("		( (yes[r] & nstate) || (no[r]  & ccide_table) )")
    J ("		 && ( ++r < nbrrules ) ") J ("	) {};") J ("")
    J ("        return r;") J ("}") J ("")
    printf
    ("static int %sFindRuleYes(             /* Return rule number */\n",
     pPrefix);
    J ("	int nbrrules, unsigned long ccide_table, unsigned long yes[])")
    J ("{") J ("        int r=0;") printf ("        unsigned long nstate;\n");
    J ("") J ("        nstate = UINT_MAX ^ ccide_table;")
    J ("        while ( (yes[r] & nstate) && ( ++r < nbrrules ) ) {};")
    J ("        return r;") J ("}")
    printf ("#endif /* End ifndef  __%s_INLINE_C  */\n", pPrefix);
    printf ("%sEND_GENERATED_CODE: %s\n", pComment, pEcomment);

}				/* End of GenInLineCode() */

#define bar "__"

/** Output D/T skeleton code.
 */
int
GenSkeleton (char *s)
{
  int i, j, skelsize = 4, size, RC = 0;
  char *sep = " ";
  int c[32][CCIDE_NRULE];
  int logsize = 1;		/* log(s) skelsize. */
  int l = 2;

  if (s != NULL)
    {
      size = atoi (s);
      if (size > 0)
	{
	  skelsize = size;
	}
      RC = 1;
    }

  assert (MAX_SKELSIZE < CCIDE_NRULE);

  if (skelsize > MAX_SKELSIZE)
    {
      fprintf (stderr,
	       _("%i exceeds maximum skeleton size:%i.  Resetting.\n"),
	       skelsize, MAX_SKELSIZE);
      skelsize = MAX_SKELSIZE;
    }


  printf (_("%s Skeleton Program Generated by ccide-%s.%s %s \n"),
	  pComment, VERSION, RELEASE, GetTimeStamp ());

    J ("")
    J("ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com")
    J_("The code generated by ccide is covered by the same license as the source ")
    J_("code(decision table) from which it is derived. If you created the source, ")
    J_("you are free to do anything you like with the generated code,")
    J_("including incorporating it into or linking it with proprietary software. ")
    printf("%s\n", pEcomment);
    J(" ") 
    J ("#include <stdlib.h>") 
    J ("#include <stdio.h>")
    J("#include <assert.h>") 
    printf ("#ifdef %s_LIB\n", pPrefix);
    printf ("#include <%s.h>\n", pPrefixLc);
    J ("#else") 
    printf ("%s %s_INLINE_CODE:%s\n", pComment, pPrefix, pEcomment);
    printf ("#endif %s End #ifdef %s_LIB %s", pComment, pPrefix, pEcomment);
    J ("\nstatic void A(int n) {")
    printf ("\tprintf((const char*)\"%s\\n\",n);\n", "%i");
    J ("}\n") J ("int main(int argc, char **argv) {") 
    i = skelsize;
    while ((1 << logsize) < i)
           logsize++;

  printf ("\tint C[%i]={1", logsize);

  for (i = 1; i < logsize; i++)
    {
      printf (",1");
    }

  printf ("};\n\n");
  printf ("\t%sDECISION_TABLE:%s\n", pComment, pEcomment);

#if GEN_GROUP
  printf ("\t%s %s ", pComment, pEcomment);
  for (j = 0; j < skelsize; j++)
    {
      if ((skelsize > 10) && (j < 9))
	printf ("%i  ", j);
      else
	printf ("%i ", j);
    }

  printf ("| %s_group == $$\n", pPrefixLc);
#endif  // if GEN_GROUP

  /* c[32][skelsize] is a controller for condition entries 
     if c[j] is on, then set X, else not
   */

  /* Clear control */
  for (i = 0; i < 32; i++)
    {
      for (j = 0; j < skelsize; j++)
	{
	  c[i][j] = 0;
	}
    }

  /* Set Control */
  for (i = 0; i < 32; i++)
    {
      if (1)
	{
	  for (j = 0; j < skelsize; j++)
	    {
	      int k;
	      for (k = 0; k < (l / 2); k++)
		{
		  c[i][j + k] = 1;
		}
	      j += (l - 1);
	    }
	  if (l < CCIDE_NRULE)
	    l += l;
	}
    }

  for (i = 0; (i < logsize) && (i < CCIDE_NCOND); i++)
    {
      printf ("\t%s  ", pComment);
      for (j = 0; j < skelsize; j++)
	{
	  if (c[i][j])
	    {
	      printf ("Y%s", sep);
	    }
	  else
	    {
	      printf ("N%s", sep);
	    }
	}
      printf ("| C[%i] %s\n", i, pEcomment);
    }


  printf ("\t%s  ", pComment);

  for (j = 1; j < skelsize; j++)
    {
      printf ("%s", bar);
    }

  printf ("_______________ %s\n", pEcomment);

  for (i = 0; i < skelsize; i++)
    {
      printf ("\t%s  ", pComment);
      for (j = 0; j < skelsize; j++)
	{
	  if (i == j)
	    printf ("X%s", sep);
	  else
	    printf ("-%s", sep);
	}
      printf ("| A(%i);%s\n", i, pEcomment);
    }

#ifdef GEN_NEWGROUP
  printf ("\t%s  ", pComment);

  for (j = 0; j < skelsize; j++)
    {
      if ((skelsize > 10) && (j < 10))
	printf ("%i  ", j);
      else
	printf ("%i ", j);
    }

  printf ("| NEWGROUP\n");
#endif /* if GEN_NEWGROUP */

  printf ("\t%sEND_TABLE:%s\n", pComment, pEcomment);
  J ("")
  J ("	return 0;")
  J ("}")
  J ("") 
  printf (_("%sEnd of Skeleton Program.%s\n"), pComment, pEcomment);

  return RC;
}				/* End of GenSkeleton */

/** Show program usage.  Popt is not used in order to reduce library dependencies.
 */
void
Usage ()
{

    J_("Usage:")
    J ("         ccidew -s [SKELETONSIZE]")
    J ("       | ccidew -V | --version")
    J ("       | ccidew --help")
    J ("       | ccidew [-a] [-b] [-c COLUMNSIZE] [-d STUBSTRING1 STUBSTRING2] [-e] [-l] ")
    J ("               [-L LANG] [-m4] [-n] [-p PREFIX] [-q LEFTQUOTE RIGHTQUOTE]")
    J ("	          [-s SKELSIZE][-t] [-u] [-x] < STDIN > STDOUT") 
    J ("") 
    J_("Environmental Variables:") 
    J_("CCIDEW			Path to the ccidew program.\n\t\t\tExample: /usr/local/bin/ccidew") 
    J_("CCIDE_M4DIR		Directory containing ccide .m4 files.\n\t\t\tExample: /usr/local/share/ccide  ") 
    J("");
    J_("Exit status is 0 if OK, or 1 if some problem.") 
    J_("Report bugs to https://sourceforge.net/projects/ccide/forums/forum/395422.") 
    RC = 0;
    exit (0);
}

/** Print Copyright information.
 */
void
ShowCopyright ()
{

  printf
    ("    ccidew version %s-%s, Copyright (C) 2002-2004,2010,2012 Thomas W. Young, e-mail ccide@twyoung.com\n",
     VERSION, RELEASE);

  printf ("    %s comes with ABSOLUTELY NO WARRANTY.", PACKAGE);
J ("    ccide is Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com") J_ ("    ccide is free software, and you are welcome to redistribute it") J_ ("    under certain conditions; see file COPYING for details.") J ("") J_ ("The code generated by ccide is covered by the same license as the source ") J_ ("code(decision table) from which it is derived. If you created the source, ") J_ ("you are free to do anything you like with the generated code,") J_ ("including incorporating it into or linking it with proprietary software. ")}

/* End of ccideinline.c */
