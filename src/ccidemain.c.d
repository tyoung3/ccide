/*  	ccide - C Language Decision Table Code Generator 
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


/* ccidemain.c:  decision table generation and checking 
 * N.B.  Ccidemain.c is generated from ccidemain.c.d by ccide.
 */


	/* ********************  Includes ******************** */

/*  For gettext */
#include "gettext.h"
#define _(string) gettext (string)

#include <stdio.h>
#include <stdlib.h>
#define ThisProgramCanHandleDefaultCases
#include "ccide.h"
#include "ccidemain.h"
#include "ccideparse.h"
#include "parse.h"

#ifdef HAVE_STRING_H
#include <string.h>
#else
#pragma message "string.h not available"
#endif /* if HAVE_STRING_H */

#ifdef HAVE_LIMITS_H
#include <limits.h>
#ifdef WORD_BIT
#define INTBITS WORD_BIT
#else
#define INTBITS 32
#endif  /* if WORD_BIT */
#else
#undef INTBITS
#define INTBITS 32
#endif  /* HAVE_LIMITS_H */

#if TIME_WITH_SYS_TIME
# include <sys/time.h>
# include <time.h>
#else
# if HAVE_SYS_TIME_H
#  include <sys/time.h>
# else
#  include <time.h>
# endif /* if HAVE_SYS_TIME_H   */
#endif /* if TIME_WITH_SYS_TIME */

void warning (char *s);  /* Parser warning message. */

typedef int STATE;

	/* ******************** Local Defines ******************** */
/* Exclusive OR */
#define XOR ^	

/* Maximum no. unique entry values      */	                                   
#define MAXENTRY 99999                                         

#define CBFRSIZE 64000		/* Space for all condition stubs in a table. */
#define MAX_ATBL (CCIDE_NACTION/32)  /* Maximum number of actions for a rule. */

typedef CCIDE_BIT ACTON[1 + MAX_ATBL];
typedef CCIDE_BIT RULE[1 + CCIDE_NCOND / INTBITS];

	/* ********************  Shared Variables  ******************** */
int nbrtables = 1;		/* Number of tables defined 			*/
int ccide_newgroup = 0;		/* Default state for NEWGROUP 			*/
int m4out = 0;			/* 1 = generate m4 code, rather than C code. 	*/
int noinline = 0;		/* 1 = do not generate inline code. 		*/
int notimestamp = 0;		/* 1 = bypass timestamps. 			*/
int uselocaltime = 0;		/* 1 = local time in timestamps. 		*/
int donotgenerate = 0;		/* 1 = do not generate any code. 		*/
int checkequal = 1;		/* 0 = do not check for '=' in cond stub. 	*/
char *lws = "";			/* Decision table leading White Space 		*/
char bfr[BFRSIZE];		/* Internal buffer 		  		*/
int lang = C;			/* Source file program language.  		*/
int changequote = 0;		/* 1=issue m4 changequote command 		*/
char pPrefix[MAXPREFIX+1] = "CCIDE";	/* Generated code prefix 		*/
char pPrefixLc[MAXPREFIX+1] = "ccide";	/* Lower case generated code prefix 	*/
char *pComment = "/*";		/* Comment start 				*/
char *pEcomment = "*/";		/* Comment end   				*/

	/* ******************** Decision Table Structure ******************** */
typedef struct
{
  int dummy_guard[1];			/* Something clobbering this on Solaris 9 ?? 	*/
  int nact[CCIDE_NRULE + 1];		/* Number of actions per rule.  		*/
  RULE yes[CCIDE_NRULE + 1];		/* 'Y' bits for rule 				*/
  RULE no[CCIDE_NRULE + 1];		/* 'N' bits for rule 				*/
  ACTON act[CCIDE_NRULE + 1];		/* Action bits for rule 			*/
  char *actiontable[CCIDE_NACTION];	/* Pointers to actions for rule 		*/
  char *conccideable[CCIDE_NCOND];	/* Pointers to condition for rule 		*/
} CCIDEABLE;

	/* ********************  Local Variables  ******************** */
static CCIDEABLE ccide;			/* Current Decision table 			*/
static int saven[MAXENTRY + 1];
static int numbers[CCIDE_NRULE + 1];
static int rulemap[CCIDE_NRULE + 1];	 
static int isagoto[CCIDE_NRULE + 1];	/* 1 to generate case label 			*/
static int remap[CCIDE_NRULE + 1];	/* Rule order remap vector.			*/
static int save4goto[CCIDE_NRULE + 1];

static int nunique = 0;
static int nbractions = 0;		/* Number of actions			*/
static int nbrcond = 0;			/* Number of conditions 		*/
static int nbrrule = 0;			/* Number of rules 			*/
static int ncwords;			/* ncwords = (nbrcond-1)/INTBITS + 1; 	*/
static int nawords;			/* nawords = (nactions-1)/INTBITS + 1; 	*/

static int switchable = 0;		/* 1 if numbers in condition entries	*/
static char nullact[] = { "{};" };
char bufs[BFRSIZE];			/* Internal buffer			*/
static char bash_cases[BFRSIZE];
static char bash_rules[BFRSIZE];
static int logLabel = FALSE;		/* 1 = generate table label. 		*/
		/* *******************  Local Functions ************* */

	/* Turn on bit, n, in array of BITs. */
static void
turnbitson (CCIDE_BIT b[], int n)
{
  int w, r;

  w = n / INTBITS;		/* Word -- b subscript */
  r = n - INTBITS * w;
  assert (r < 32);
  b[w] = (1 << r) | b[w];
}

	/* Get Case value for switch statement */
	/* Since there is only one condition row, the rule number
	   gives the condition for the case statement.
	 */
char *
FindCaseValue (int nrule)
{
  static char *c;
  int foundit = 0;

  c = ccide.conccideable[nrule - 1];
  if (c)
    {
      while (*c != 0)
	{
	  if ((*c == '=') && (*(c + 1) == '='))
	    {
	      c += 2;
	      foundit = 1;
	      break;
	    }
	  c++;
	}
      while ((*c == ' ') || (*c == '\t'))
	c++;

      if (!foundit)
	{
	  ERROR3 (_("Cannot find case value for rule %i%s\n"), nrule, "");
	  return "ERROR";
	}
    }
  else
    {
      return "default";
    }				// end if(c)
  return c;
}


	/* Sorting rule for qsort */
static int
mapseq (const void *a, const void *b)
{
  register int x, y;

  x = *(int *) a;
  y = *(int *) b;
  if (ccide.act[x][0] < ccide.act[y][0])
    return 1;

  if (ccide.act[x][0] > ccide.act[y][0])
    return -1;

  if (x < y)
    return -1;

  return 1;

}

	/* Order the rule generation so that action supersets precede 
	 ** subsets. 
	 */
static void
SetRuleMap (int nrules)
{
  int r;

  for (r = 0; r < nrules; r++)
    {
      rulemap[r] = r;
    }

  qsort ((void *) rulemap, nrules, sizeof (int), mapseq);

  rulemap[nrules] = -1;
}

/* Return number of bits set in z */
#ifdef HAVE___BUILTIN_POPCOUNT
static inline int
CountEm (CCIDE_BIT z)
{
  return __builtin_popcount ((unsigned long) z);
}
#else
/* From: http://stackoverflow.com/questions/109023/best-algorithm-to-count-the-number-of-set-bits-in-a-32-bit-integer */
static int
CountEm (CCIDE_BIT n)
{
  unsigned int c;		// c accumulates the total bits set in n
  for (c = 0; n; c++)
    n &= n - 1;			// clear the least significant bit set
  return c;
}
#endif /* if HAVE___BUILTIN_POPCOUNT */

static inline int
YesNoCount (int x)
{
  return CountEm (ccide.yes[x][0] | ccide.no[x][0]);
}

/** Hack to reverse bits for sorting
	FROM: http://graphics.stanford.edu/~seander/bithacks.html#BitReverseObvious
 */
static unsigned int ReverseBits(unsigned int v ) {
	unsigned int r = v; // r will be reversed bits of v; first get LSB of v
	
	int s = sizeof(v) * CHAR_BIT - 1; // extra shift needed at end

	for (v >>= 1; v; v >>= 1) {   
  		r <<= 1;
  		r |= v & 1;
  		s--;
	}
	r <<= s; // shift when v's highest bits are zero
	return r;
}

	/* Qsort rule sequencing function */
static int
RuleSeq (const void *a, const void *b)
{
  register int x, y;
  unsigned int ca, cb;			// Count a, count b

  x = *(int *) a;
  y = *(int *) b;
  ca = YesNoCount (x);
  cb = YesNoCount (y);

  if (ca > cb)      
    return -1;		/* Rule x+1 before rule y+1 */
  if (ca < cb)
    return 1;		/* Rule y+1 before rule x+1 */

  ca = ReverseBits(ccide.yes[x][0]) | ReverseBits(ccide.no[x][0]);
  cb = ReverseBits(ccide.yes[y][0]) | ReverseBits(ccide.no[y][0]);
  if (ca > cb)
    return -1;  		/* Rule x+1 before rule y+1 */   
  if (ca < cb)
    return 1;		/* Rule y+1 before rule x+1 */

  /*  Unreachable in theory. */

  if (x < y)		
    return -1;		/* Rule x+1 before rule y+1 */

  return 1;		/* Rule y+1 before rule x+1 */
}

	/* Delete rules with no actions.  */
static int
DropEmpty (int nrules)
{
  int i, j, ndrop = 0, hasaction;

  i = nrules;

  do
    {
      i--;
      hasaction = 0;
      for (j = 0; j < nawords; j++)
	{
	  if (ccide.act[i][j] != 0)
	    {
	      hasaction = 1;
	      break;
	    }
	}
      if (!hasaction)
	{
	  ndrop++;		// N.B.: Cannot change nrules, so pass back number to drop.
	  WARN3 ("Dropping rule %i in table %i.", remap[i], nbrtables);
	}
      else
	{
	  return ndrop;
	}
    }
  while (i > 0);

  return ndrop;

}

	/* Sequence rules with most specific first.  */
static void
Reorder (int nrules)
{
  int mapr[CCIDE_NRULE + 1];
  int i, k;
  CCIDEABLE ccide2;		/* Decision table copy */

  /* Build mapr array */
  for (i = 0; i < nrules; i++)
    {
      mapr[i] = i;
    };

  /* Sort mapr array */
  qsort ((void *) mapr, nrules, sizeof (int), RuleSeq);

  /* Copy the table */
  for (i = 0; i < nrules; i++)
    {
      ccide2.yes[i][0] = ccide.yes[i][0];
      ccide2.no[i][0] = ccide.no[i][0];
      for (k = 0; k < MAX_ATBL; k++)
	{
	  ccide2.act[i][k] = ccide.act[i][k];
	}
    }

  /* Reorder yes/no & action tables accordingly */
  for (i = 0; i < nrules; i++)
    {
      ccide.yes[i][0] = ccide2.yes[mapr[i]][0];
      ccide.no[i][0] = ccide2.no[mapr[i]][0];
      for (k = 0; k < MAX_ATBL; k++)
	{
	  ccide.act[i][k] = ccide2.act[mapr[i]][k];
	}
    }

  /* Map the new rule numbers to the old numbers for
   ** comments on the generated 'case' statements.
   **  remap[newrule#] = oldrule#.
   */
  for (i = 0; i < nrules; i++)
    {
      remap[i] = mapr[i] + 1;
    }
}


	/* Replace NULL action stubs with 'nullact' */
static void
FixNulls (int nbrrules)
{
  int r;

  for (r = 0; r < nbrrules; r++)
    {
      if (ccide.actiontable[r] == NULL)
	ccide.actiontable[r] = nullact;
    }

}

int
MoreActions (CCIDE_BIT tbl[], int naword)
{
  int i = 0;

  while (i < naword)
    {
      if (tbl[i++])
	return 1;
    }
  return 0;
}

	/* see if the remaining actions = the actions in some subsequent rule. */
int
TableEqual (int rindex, int nawords, CCIDE_BIT utbl[])
{
  int ri, lastrule = 0, j = 0, gotit = 1;
  STATE state = 0;

  /* Find the Last rule index */
  for (ri = rindex; rulemap[ri] != -1; ri++)
    {
    }
  ri--;

//DECISION_TABLE:
//  0 1 1 1 2 2 - | state==$$
//  Y Y Y - - - N | ri > rindex+1
//  - Y Y N - - - | j< nawords
//  - N Y - - - - | utbl[j] == ccide.act[lastrule][j]
//  - - - - Y N - | gotit
//__________________________________
//  1 0 - - - - - | gotit=$$;
//  X - - - - - - | lastrule=rulemap[ri];
//  1 2 - 2 - 0 - | state=$$;
//  X - - - - - - | j=0;
//  - - X - - - - | j++;
//  - - - - - X - | ri--;
//  X X X X - X - | goto $@; 
//  - - - - X - - | return rulemap[ri];
//  - - - - - - X | return -1;   
//END_TABLE:



#ifndef NOTSTRICT
// Needed for -Werror compiler option
  return -1;
#endif /* End if not defined NOTSTRICT. */
}

	/* See if the remaining actions = the actions in the next rule. */
int
NextTableEqual (int nawords, CCIDE_BIT utbl[], CCIDE_BIT ntbl[])
{
  int i = -1;

  while (++i < nawords)
    {
      if (utbl[i] != ntbl[i])
	{
	  return 0;
	}
    }
  return 1;
}

void
SetUtbl (int i, CCIDE_BIT utbl[])
{

  if (i < 32)
    {
      utbl[0] ^= (1 << i);
    }
  else
    {
      utbl[1] ^= (1 << (i - 32));
    }
}

	/* Generate action output for this rule. */
static void
PerformActions (int rindex, int rule, int nextrule, int nbrrules)
{
  int nt, k = 0, j, i = 0, li = 0, ec;
  int ended = 0;
  CCIDE_BIT tbl[MAX_ATBL];	/* Current action table */
  CCIDE_BIT utbl[MAX_ATBL];	/* Current action table updated to 
				   reflect generated actions. 
				   If this matches the next table, 
				   we are done. */
  CCIDE_BIT ntbl[MAX_ATBL];	/* Next   action table */
  char *s1;

  assert (nactions <= (CCIDE_NACTION));

  /* If action table for next rule is the same as the
     remainder of this table, then we are done with 
     this rule.  Otherwise find the next action for this
     rule and mark it done.
   */

  /* Set up this action table and the next action table */
  for (j = 0; j < nawords; j++)
    {
      utbl[j] = tbl[j] = ccide.act[rule][j];
      if (nextrule > -1)
	{			/* ? Last case */
	  ntbl[j] = ccide.act[nextrule][j];
	}
      else
	{
	  ntbl[j] = 0;
	}
    }

  nt = 0;

  for (i = 0; i < nactions; i++)
    {
      if (MoreActions (tbl, nawords))
	{
	  if (NextTableEqual (nawords, utbl, ntbl) && (lang != BASH))
	    return;		/* Next rule has remaining actions. */
	  if ((lang == BASH) && !ended)
	    {
	      ended = 1;
	      printf ("%s\t%s_CASE(%i,%s,%s)\n",
		      lws, pPrefix, nbrtables, bash_cases, bash_rules);
	      bash_cases[0] = 0;
	      bash_rules[0] = 0;
	    }
	  ec = TableEqual (rindex, nawords, utbl);
	  if ((ec > -1) && (lang != BASH))
	    {
	      isagoto[ec] = 1;	/* Generates the label later. */
	      if (m4out)
		printf ("%s\t    %s_GOTO(%sCCIDE_%i_%i%s)\n",
			lws, pPrefix, qt1, nbrtables, ec, qt2);
	      else
		printf ("%s\t    goto %s_case%i_%i;\n", lws, pPrefix, nbrtables,
			ec);
	      return;		/* Case ec: will generate remaining actions. */
	    }
	  if (tbl[0] & 1)
	    {
	      if (ccide.actiontable[i] != NULL)
		{
		  if (m4out)
		    printf ("%s\t    %s_ACTION(%s%s%s)\n",
			    lws, pPrefix, qt1, ccide.actiontable[i], qt2);
		  else
		    printf ("%s\t    %s\n", lws, ccide.actiontable[i]);
		  li = i;
		}
	      SetUtbl (i, utbl);
	    }
	}			/* End more actions ? */
      tbl[0] = tbl[0] >> 1;
      if (++nt > 31)
	{
	  tbl[0] = tbl[++k];
	  nt = 0;
	}
    }				/* End for */

  s1 = ccide.actiontable[li];
  while ((*s1 == ' ') && (*s1))
    s1++;
  if (strncmp (s1, "goto ", 5))
    {
      if (m4out)
	{
	  if (lang != VB)
	    printf ("%s\t    %s_BREAK()\n", lws, pPrefix );
	}
      else
	{
	  printf ("%s\t    break;\n", lws);
	}
    }
}

		/* Check for duplicate rules */
static void
CompareRules (int r1, int r2)
{
  int i;
  int diff;

  diff = 0;

  /* If r1 include all of r2, then r1 or r2 is extra */
  for (i = 0; i < ncwords; i++)
    {
      if (ccide.yes[r1][i] != ccide.yes[r2][i])
	{
	  diff = 1;
	  break;
	}
      if (ccide.no[r1][i] != ccide.no[r2][i])
	{
	  diff = 1;
	  break;
	}
    }

  if (diff == 0)
    {
      ERROR3 (_("Rule %i conflicts with rule %2i\n"), remap[r1], remap[r2]);
    }
}

	/* Check for overlapping rules.
	   Rules i and j overlap if all Ys and Ns in rule i
	   appear the same or empty in rule j.  
	 */
static void
Overlap (int r1, int r2)
{
  int j, diff;
  int eq1 = 1, eq2 = 1;
  CCIDE_BIT w1[1 + (CCIDE_NCOND - 1) / INTBITS],
    w2[1 + (CCIDE_NCOND - 1) / INTBITS];

  diff = 0;
  for (j = 0; j < ncwords; j++)
    {
      w1[j] = (CCIDE_BIT) ccide.yes[r1][j] | ccide.yes[r2][j];
      w2[j] = (CCIDE_BIT) ccide.no[r1][j] | ccide.no[r2][j];
    }

  for (j = 0; j < ncwords; j++)
    {
      if ((w1[j] != ccide.yes[r1][j]) || (w2[j] != ccide.no[r1][j]))
	{
	  eq1 = 0;
	}
      if ((w1[j] != ccide.yes[r2][j]) || (w2[j] != ccide.no[r2][j]))
	{
	  eq2 = 0;
	}
    }

  if (eq1 || eq2)
    {
      ERROR3 (_("Rules %2i and  %2i overlap.\n"), remap[r1], remap[r2]);
    }
}


	/* *******************  Global Functions ************* */

	/* Y input */
void inline
SetYes (int nrule, int ncond)
{
  turnbitson (ccide.yes[nrule], ncond);
}

	/* N input */
void inline
SetNo (int nrule, int ncond)
{
  turnbitson (ccide.no[nrule], ncond);
}

	/* Local version of strdup() function 
	   -- checks for memory.
	 */
char *
Strdup (const char *s)
{
  char *s1 = malloc (strlen (s) + 1);	// Space for length plus null

  if (s1 == NULL)
    {
      perror ("Strdup");
      exit (1);
    }

  strcpy (s1, s);		// Copy the characters
  return s1;			// Return the new string

}

	/*  Save lws from decision table statement for code generation.
	 */
void
SaveLeadingWhiteSpace (char *s1)
{
  char *s;

  s = s1;
  ccide.dummy_guard[0] = 19;
  while ((*s == ' ') || (*s == '\t'))
    {
      (s++);
    }

  if (strncmp (s, "//", 2) == 0)
    {
      pComment = "//";
      pEcomment = "";
    }
  else
    {
      if (strncmp (s, "/*", 2) == 0)
	{
	  pComment = "/*";
	  pEcomment = "*/";
	}
    }

  free (lws);
  {
    register int i = s - s1;
    if ((lws = (char *) malloc (i + 1)) == NULL)
      {
	perror (_("Allocating leading white space"));
      };
    memcpy (lws, s1, i);
    lws[i] = '\0';
  }
}

	/* Clear ccide table */
void
ClearTable ()
{
  int i, k;

  for (i = 0; i < CCIDE_NACTION; i++)
    {
      ccide.actiontable[i] = NULL;
    }
  for (i = 0; i < CCIDE_NCOND; i++)
    {
      ccide.conccideable[i] = NULL;
    }
  for (i = 0; i < CCIDE_NRULE; i++)
    {
      ccide.yes[i][0] = 0;
      ccide.no[i][0] = 0;
      for (k = 0; k < MAX_ATBL; k++)
	{
	  ccide.act[i][k] = 0;
	}
    }
  logLabel = FALSE;
}

	/* Check for lonely equal sign in condition expression. */
void
CheckEqual (char *cstub, int ncond)
{
  char *c1 = cstub;

  while (checkequal && (*c1 != 0))
    {
      if (*c1 == '=')
	{
	  if ((*(c1 + 1) == '=') || (*(c1 - 1) == '!') || (*(c1 - 1) == '<'))
	    {
	      c1++;
	    }
	  else
	    {
	      ERROR3 (_("%s '=' error in condition expression %i"),
		      cstub, ncond + 1);
	    }
	}
      c1++;
    }
}

	/* Store Condition stub */
void
SetCSTUB (int ncond, char *cstub)
{
  int i;
  char *c1;

  c1 = cstub;
  while ((*c1 != 0) && ((*c1 == ' ') || (*c1 == '\t')))
    c1++;

  ccide.conccideable[ncond] = c1;
  CheckEqual (cstub, ncond);

  for (i = 0; i < ncond; i++)
    {
      if (strcmp (cstub, ccide.conccideable[i]) == 0)
	{
	  ERROR3 (_("%s is the same as condition %i"), cstub, i + 1);
	}
    }
}

	/* Returns count of unique numbers */
int
SetNumber (int nconds, int nrule, int n)
{

  assert (n < MAXENTRY + 1);
  if (saven[n] == -1)
    {
      numbers[nrule] = n;
      saven[n] = nconds + nunique;
      nunique++;
    }

  SetYes (nrule, saven[n]);
  return nunique;
}

	/* X in input */
void
SetAct (int nrule, int naction)
{
  turnbitson (ccide.act[nrule], naction);
}

	/* Returns count of unique numbers */
int
SetANumber (int nactions, int nrule, int n)
{

  assert (n < MAXENTRY + 1);
  if (saven[n] == -1)
    {
      numbers[nrule] = n;
      saven[n] = nactions + nunique;
      nunique++;
    }

  save4goto[nrule] = 1;
  SetAct (nrule, saven[n]);
  return nunique;
}

	/* Clear table of unique integers */
void
UnSetNumbers ()
{
  int i;

  nunique = 0;

  for (i = 0; i < CCIDE_NRULE; i++)
    {
      numbers[i] = -1;
      save4goto[i] = 0;
    }

  for (i = 0; i < MAXENTRY + 1; i++)
    {
      saven[i] = -1;
    }
}

	/* Store action stub */
void
SetASTUB (int n, char *stub)
{
  int i;

  while ((*stub != 0) && ((*stub == ' ') || (*stub == '\t')))
    stub++;
  DISPLAY (SetASTUB);		/* if yydebug */
  ccide.actiontable[n] = Strdup (stub);
  if (yydebug)
    {
      fprintf (stderr, "n=%i act:'%s'\n", n, ccide.actiontable[n]);
    }
  i = 0;
  while (i < n)
    {
      if ((ccide.actiontable[i] != NULL)
	  && (strcmp (stub, ccide.actiontable[i]) == 0)
	  && DupeActionIsAnError)
	{
	  ERROR3 (_("%s is the same as action %i"), stub, i + 1);
	}
      i++;
    }
  DISPLAY (End SetASTUB);	/* if yydebug */

}

	/* Scan for substitution variable
	   If none, then use SetASTUB, otherwise expand
	 */

char *svar1 = "$$";		/* Replace with entry integer. */
int lsvar1 = 2;

char *svar2 = "$@";		/* Replace with decision table entry point. */
int lsvar2 = 2;

char *qt1 = "[[";		/* m4 left quote  */
int lqt1 = 2;

char *qt2 = "]]";		/* m4 right quote */
int lqt2 = 2;

	/* Replace all occurances of svar2 with table entry point. */
char *
ExpVar2 (char *c1)
{
  char *s1, *s2, *s3;
  static char bufs2[BFRSIZE];

  if ((s1 = strstr (c1, svar2)) == NULL)
    {
      return c1;
    }

  logLabel = TRUE;
  s2 = bufs2;
  s3 = c1;

  while (s1 != NULL)
    {
      strncpy (s2, s3, s1 - s3);
      s2 += (s1 - s3);
      s3 += (s1 - s3 + lsvar2);
      s2 += snprintf (s2, BFRSIZE - 1, "%s_TABLE_%i ", pPrefix, nbrtables);
      s1 = strstr (s3, svar2);
    }

  strncpy (s2, s3, sizeof (bufs2) - strlen (s2) - strlen (s3));
  return bufs2;

}

int
SetASTUBscan (int nactions, char *c1)
{
  int i = 0, a = nactions;
  char *s1, *s2, *s3;
  static char bufs[BFRSIZE];

  DISPLAY (SetASTUBscan);	/* if yydebug */
  if ((s1 = strstr (c1, svar1)) == NULL)
    {
      SetASTUB (nactions, c1);
      return 1;
    }

  for (a = 0; a < substitute; a++)
    {
      while (numbers[i++] == -1)
	{
	}
      s2 = bufs;
      s3 = c1;
      s1 = strstr (s3, svar1);
      while (s1 != NULL)
	{
	  strncpy (s2, s3, s1 - s3);
	  s2 += (s1 - s3);
	  s3 += (s1 - s3 + lsvar1);
	  s2 += snprintf (s2, BFRSIZE, "%i", numbers[i - 1]);
	  s1 = strstr (s3, svar1);
	}
      strncpy (s2, s3, sizeof (bufs) - strlen (s2) - strlen (s3));
      SetASTUB (a + nactions, bufs);
    }

  UnSetNumbers ();
  return substitute;
}

/** Dead code */
#if 0
void
SetASTUBhere (int nactions, char *c1)
{

  DISPLAY (SetASTUBhere);	/* if yydebug */
  snprintf (bufs, BFRSIZE - 1, "%s%s %s_TABLE_%i;",
	    lws, c1, pPrefix, nbrtables);
  SetASTUB (nactions, bufs);
}
#endif 

	/* NEWGROUP in last action */
void
SetASTUBn (int nactions, int nrules)
{
  int i = 0, a = nactions, a1;

  DISPLAY (SetASTUBn);		/* if yydebug */
  logLabel = TRUE;

  /* Set Action table */
  for (a1 = 0; a1 < substitute; a1++)
    {
      while (numbers[i++] == -1)
	{
	}
      if (lang == EX)
	snprintf (bufs, BFRSIZE, "%s_group = %i", pPrefixLc, numbers[i - 1]);
      else
	snprintf (bufs, BFRSIZE, "%s_group = %i;", pPrefixLc, numbers[i - 1]);
      SetASTUB (a++, bufs);
    }

  /* Set goto ...table action */
  for (a1 = 0; a1 < nrules; a1++)
    {
      if (save4goto[a1])
	SetAct (a1, a);
    }

  if (lang == EX)
    snprintf (bufs, sizeof (bufs) - strlen (pPrefix) - 40,
	      "goto \"%s_TABLE_%i\"", pPrefix, nbrtables);
  else
    snprintf (bufs, sizeof (bufs) - strlen (pPrefix) - 40,
	      "goto %s_TABLE_%i;", pPrefix, nbrtables);

  SetASTUB (a, bufs);
  UnSetNumbers ();
}


int
SetCSTUBscan (int ncond, char *c1)
{
  int i = 0, a = ncond;
  char *c3, *s1, *s2, *s3;
  static char bufs[BFRSIZE];

  if ((s1 = strstr (c1, svar1)) == NULL)
    {
      SetCSTUB (ncond, Strdup (c1));
      return 1;
    }

  c3 = c1;
  while ((*c3 != 0) && ((*c3 == ' ') || (*c3 == '\t')))
    c3++;

  for (a = 0; a < substitute; a++)
    {
      while (numbers[i++] == -1)
	{
	}
      s2 = bufs;
      s3 = c3;
      s1 = strstr (s3, svar1);
      while (s1 != NULL)
	{
	  strncpy (s2, s3, s1 - s3);
	  s2 += (s1 - s3);
	  s3 += (s1 - s3 + lsvar1);
	  s2 += snprintf (s2, BFRSIZE, "%i", numbers[i - 1]);
	  s1 = strstr (s3, svar1);
	}
      strncpy (s2, s3, sizeof (bufs) - strlen (s2) - strlen (s3));
      SetCSTUB (a + ncond, Strdup (bufs));
    }

  UnSetNumbers ();
  switchable = 1;		/* Allow to generate switch/case statement. */
  return substitute;
}


	/* Check for inconsistent (dupe or conflicting) rules. */
void
CcideCheckRules (int ndrop)
{
  int i, j;
  CCIDE_BIT w;

  assert (nbractions > 0);
  assert (nbrcond > 0);
  assert ((nbrrule - ndrop) > 0);

  if ((nbrrule - ndrop) > 1)
    {
      for (i = 0; i < ((nbrrule - ndrop) - 1); i++)
	{
	  for (j = i + 1; j < (nbrrule - ndrop); j++)
	    {
	      CompareRules (i, j);
	    }
	  w = (CCIDE_BIT) ccide.act[i][0];
	  for (j = i + 1;
	       j < (nbrrule - ndrop) && (w == (CCIDE_BIT) ccide.act[j][0]);
	       j++)
	    {
	      Overlap (i, j);
	    }
	}			/* End for */
    }				/* End if */

}

	/* Build string to display yes table entry values. */
char *yes_tbl (int nrules) {
  int i;
  static char bfr[4000];
  char bfr2[4000];

  sprintf (bfr, "`{%i", ccide.yes[0][0]);

  for (i = 1; i < nrules; i++)
    {
      sprintf (bfr2, ",%i", ccide.yes[i][0]);
      strcat (bfr, bfr2);
    }

  strcat (bfr, "}'");
  return bfr;
}

	/* Build string to display no table entry values. */
char *no_tbl (int nrules) {
  int i;
  static char bfr[4000];
  char bfr2[4000];

  sprintf (bfr, "`{%i", ccide.no[0][0]);

  for (i = 1; i < nrules; i++)
    {
      sprintf (bfr2, ",%i", ccide.no[i][0]);
      strcat (bfr, bfr2);
    }

  strcat (bfr, "}'");
  return bfr;
}
        /* Build string to display condition stub. */
char *cond_seq (int nconds) {
  int i;
  static char bfr[1000], conds[1000];

  conds[0] = 0;
  strcpy (conds, ccide.conccideable[0]);
  for (i = 1; i < nconds; i++)
    {
      strcat (conds, ",");
      strcat (conds, ccide.conccideable[i]);
    }
  sprintf (bfr, "`%i',`{%s}'", nconds, conds);
  return bfr;
}

char *java_cond_seq (int nconds){
  int i;
  static char bfr[10000];
  char conds[10000], bfr2[10000];

  conds[0] = 0;
  sprintf (conds, "((%s) ? 1: 0)", ccide.conccideable[0]);
  //strcpy(conds,ccide.conccideable[0]);
  for (i = 1; i < nconds; i++)
    {
      strcat (conds, "|");
      sprintf (bfr2, "((%s) ? 1: 0)<<%i", ccide.conccideable[i], i);
      strcat (conds, bfr2);
    }
  sprintf (bfr, "`(%s)' ",
	   // nconds, 
	   conds);
  return bfr;
}

	/* Generate Condition statements */
void
GenConds (int nconds, int nrules, int notable)
{
  int c, r, l;
  int pwr2 = 1;
  char condbfr[CBFRSIZE];

  if (lang == BASH)
    snprintf (condbfr,
	      CBFRSIZE,
	      "\n%sCCIDE=0\n%s%s[[ %s ]] %s && CCIDE=1",
	      lws, lws, qt1, ccide.conccideable[0], qt2);
  else if (lang == VB)
    snprintf (condbfr, CBFRSIZE, "(%s)", ccide.conccideable[0]);
  else
    snprintf (condbfr, CBFRSIZE, "\n%s\t\t  (%s)",
	      lws, ccide.conccideable[0]);

  for (c = 1; c < nconds; c++)
    {
      l = strlen (condbfr);
      pwr2 = pwr2 << 1;
      if (lang == BASH)
	snprintf (condbfr + l, CBFRSIZE - l,
		  "\n%s%s[[ %s ]]%s && CCIDE=$((CCIDE+=%i)) ",
		  lws, qt1, ccide.conccideable[c], qt2, pwr2);
      else if (lang == VB)
	snprintf (condbfr + l, CBFRSIZE - l,
		  "+(%s)*%i", ccide.conccideable[c], pwr2);
      else
	snprintf (condbfr + l, CBFRSIZE - l,
		  "\n%s\t\t| (%s)<<%i", lws, ccide.conccideable[c], c);
    }

  l = strlen (condbfr);

  if (lang != VB)
    snprintf (condbfr + l, CBFRSIZE - l, "\n%s\t\t  ", lws);

  //DECISION_TABLE:
  //  Y Y Y Y N N N N | notable
  //  Y - N - Y - N - | lang==EX
  //  - Y N - - Y N - | lang==JAVA
  //  - - Y - - - Y - | m4out
  // ____________________________________
  //  X - - - - - - - |printf( "\n%s\t%s_SWITCH(%i,%s,%s,%s)\n",   
  //  - - X - - - - - |printf( "\n%s\t%s_SWITCH(%i,%s%s%s,%i)\n",
  //  - - - X - - - - |printf( "\n%s\tswitch(%sFindRule(%i,%s,", lws, pPrefix, nrules, condbfr);
  //  - - - X - - - - |printf(   "%s_table%i_yes", pPrefix, nbrtables); 
  //  - - - X - - - - |printf( ", %s_table%i_no", pPrefix, nbrtables); 
  //  - - - - X - - - |printf( "\n%s\t%s_SWITCH_YES(%i,%s,%s)\n",
  //  - - - - - X - - |printf( "\n%s\t%s_SWITCH_YES(%i,%s,\n",
  //  - X - - - - - - |printf( "\n%s\t%s_SWITCH(%i,%s,\n",           
  //  - - - - - - X - |printf( "\n%s\t%s_SWITCH_YES(%i,%s,%i)\n",
  //  - - - - - - - X |printf( "\n%s\tswitch(%sFindRuleYes(%i,%s,",
  //  - - - - - - - X |lws, pPrefix, nrules, condbfr);
  //  X - - - - - - - |lws, pPrefix, nrules, cond_seq(nconds),yes_tbl(nrules), no_tbl(nrules));
  //  - - X - - - - - |lws, pPrefix, nrules, qt1, condbfr, qt2,nbrtables);
  //  - - - - X - - - |lws, pPrefix, nrules, cond_seq(nconds), yes_tbl(nrules));
  //  - X - - - X - - |lws, pPrefix, nrules, java_cond_seq(nconds) );     
  //  - X - - - X - - |printf( "%s\t\t `%i\') { \n", lws,  nbrtables ); 
  //  - - - - - - X - |lws, pPrefix, nrules,condbfr, nbrtables);
  //  - - - - - - - X |printf( "%s_table%i_yes", pPrefix, nbrtables);      
  //  - - - X - - - X |printf(")) {\n");
  //END_TABLE:




  SetRuleMap (nrules);
  for (r = 0; r < nrules; r++)
    {
      int rm;
      rm = rulemap[r];
      if (m4out)
	if (lang == BASH)
	  {
	    if (bash_rules[0] == 0)
	      {
		snprintf (bfr, sizeof (bfr), "%i", remap[rm]);
		STRCAT (bash_rules, bfr);
		snprintf (bfr, sizeof (bfr), "%i", rm);
		STRCAT (bash_cases, bfr);
	      }
	    else
	      {
		snprintf (bfr, sizeof (bfr), "%i", remap[rm]);
		STRCAT (bash_rules, " ");
		STRCAT (bash_rules, bfr);
		snprintf (bfr, sizeof (bfr), "%i", rm);
		STRCAT (bash_cases, "|");
		STRCAT (bash_cases, bfr);
	      }
	  }
	else
	  {
	    printf ("%s\t%s_CASE(%i,%2i,%i)\n",
		    lws, pPrefix, nbrtables, rm, remap[rm]);
	  }
      else if (isagoto[rm])
	printf ("%s\t%s_case%i_%i: case %2i:\t%s\tRule %2i %s\n",
		lws, pPrefix,nbrtables, rm, rm, pComment, remap[rm], pEcomment);
      else
	printf ("%s\tcase %2i:\t%s\tRule %2i %s\n",
		lws, rm, pComment, remap[rm], pEcomment);
      PerformActions (r, rm, rulemap[r + 1], nrules);
    };

  if (m4out)
    printf ("%s\t%s_END_SWITCH()\n", lws, pPrefix );
  else
    printf ("%s\t} %s End Switch%s\n", lws, pComment, pEcomment);

}


	/* Compute timestamp for output */
char *
GetTimeStamp ()
{
  char bfr[100];
  time_t tmt;
  struct tm *tm;
  static char *ts = NULL;

  if (notimestamp)
    return ("");

  if (ts != NULL)
    {
      free (ts);
      ts = NULL;
    };

  time (&tmt);

#if 1
  tm = localtime (&tmt);
  strftime (bfr, 100, "%c", tm);
#else
  if (localtime)
    {
      tm = localtime (&tmt);
      strftime (bfr, 100, "%c", tm);
    }
  else
    {
      tm = gmtime (&tmt);
      strftime (bfr, 100, "%cUTC", tm);
    }
#endif /* if 1  */

  ts = Strdup (bfr);
  return (ts);
}

void
GenEnd ()
{
  if (m4out)
    printf ("%s%s%sEND_GENERATED_CODE: FOR TABLE_%i, by ccide-%s-%s %s %s%s",
	    lws, pComment, qt1, nbrtables, VERSION, RELEASE, GetTimeStamp (),
	    qt2, pEcomment);
  else
    printf ("%s}\n%s%sEND_GENERATED_CODE: FOR TABLE_%i, by ccide-%s-%s %s %s",
	    lws, lws, pComment, nbrtables, VERSION, RELEASE, GetTimeStamp (),
	    pEcomment);
}

	/* Generate code when there is just one substitution condition stub. */
void
GenerateCases (int nactions, int nrules)
{
  int r;
  char *c3, *c1;

  c1 = c3 = Strdup (ccide.conccideable[0]);
  while ((*c3 != 0))
    {
      if ((*c3 == '=') && (*(c3 + 1) == '='))
	{
	  *c3 = 0;
	  break;
	}
      c3++;
    }

  while ((*c1 == ' ') || (*c1 == '\t'))
    c1++;

  if (lang == EX)
    printf ("%s %s_BEGIN_BLOCK() label \"%s_TABLE_%i\"\n%s ", lws, pPrefix, pPrefix,
	    nbrtables, lws);
  else if (lang == C)
    printf ("%s { %s_TABLE_%i:", lws, pPrefix, nbrtables);
  else
    printf ("%s %s_BEGIN_BLOCK() %s_TABLE_%i:", lws, pPrefix, pPrefix, nbrtables);

  if (m4out)
    {
      if (lang == JAVA)
	printf (" %s_SWITCHX_JAVA(%s%s%s)\n", pPrefix, qt1, c1, qt2);
      else
	printf (" %s_SWITCHX(%s%s%s)\n", pPrefix, qt1, c1, qt2);
    }
  else
    {
      printf (" switch(%s) {\t\n", c1);
    }

#if 1
  if (strcmp (FindCaseValue (remap[nrules - 1]), "default") == 0)
    {
      SetRuleMap (nrules - 1);
      rulemap[nrules - 1] = nrules - 1;
      rulemap[nrules] = -1;
    }
  else
    {
      SetRuleMap (nrules);
    }
#else
  SetRuleMap (nrules);
#endif  /* if 1 */
  for (r = 0; r < nrules; r++)
    {
      int rm;
      char *cv;
      rm = rulemap[r];
      if (m4out)
	printf ("%s\t%s_CASE(%i, %s, %i)\n",	//?? for default
		lws, pPrefix, nbrtables, FindCaseValue (remap[rm]), remap[rm]);
      else
	{
	  cv = FindCaseValue (remap[rm]);
	  if (strcmp (cv, "default") != 0)
	    {
	      printf ("%s\tcase %s:\t\t%s  Rule %2i  %s\n",
		      lws, cv, pComment, remap[rm], pEcomment);
	    }
	  else
	    {
	      printf ("%s\t default:\t\t%s  Rule %2i  %s\n",
		      lws, pComment, remap[rm], pEcomment);
	    }
	}
      PerformActions (r, rm, rulemap[r + 1], nrules);
    };

  if (lang == C)
    printf ("%s }\n", lws);
  else
    printf ("%s %s_END_SWITCH() \n", lws, pPrefix);
  GenEnd ();
}

	/* Generate code using CcideFindRule... function(s). */
void
GenerateFindRule (int nconds, int nactions, int nrules)
{
  int r, notable;
  int NotFirst = 0;

  if (m4out)
    if (lang == BASH)
      printf ("%s\t", lws);
    else
      printf ("%s %s_BEGIN_BLOCK()\t", lws, pPrefix);
  else
    printf ("%s {\t", lws);

  notable = 0;
  for (r = 0; r < nrules; r++)
    {
      if (ccide.no[r][0])
	notable = 1;
    }

  /* Yes table */
  if (m4out)
    {
      if (lang == VB)
	{
	  printf ("\n%s%s_TABLE_YES(%i, %i)\n",
		  lws, pPrefix, nbrtables, nrules);
	  for (r = 0; r < nrules; r++)
	    {
	      printf ("%s%s_TYES(%i,%i,%i)\n",
		      lws, pPrefix, nbrtables, r, ccide.yes[r][0]);
	    }
	}
      else
	{
	  printf ("%s_TABLE_YES(%i, %i", pPrefix, nbrtables, nrules);
	  if (lang == BASH)
	    {
	      printf (",");
	      for (r = 0; r < nrules; r++)
		{
		  printf (" %u", ccide.yes[r][0]);
		}
	    }
	  else
	    {
	      for (r = 0; r < nrules; r++)
		{
		  printf (", %u", ccide.yes[r][0]);
		}
	    }
	  printf (")\n");
	}
    }
  else
    {
      printf ("unsigned long %s_table%i_yes[%i]={",
	      pPrefix, nbrtables, nrules);
      NotFirst = 0;
      for (r = 0; r < nrules; r++)
	{
	  if (NotFirst)
	    printf (",");
	  NotFirst = 1;
	  if (lang == EX)
	    printf ("%4u", ccide.yes[r][0]);
	  else
	    printf ("%4uUL", ccide.yes[r][0]);
	}
      printf ("};\n");
    }


  /* No table */
  if (notable)
    {
      if (m4out)
	{
	  if (lang == VB)
	    {
	      printf ("%s%s_TABLE_NO(%i, %i)\n",
		      lws, pPrefix, nbrtables, nrules);
	      for (r = 0; r < nrules; r++)
		{
		  printf ("%s%s_TNO(%i,%i,%i)\n",
			  lws, pPrefix, nbrtables, r, ccide.no[r][0]);
		}
	    }
	  else
	    {
	      printf ("%s%s_TABLE_NO(%i, %i",
		      lws, pPrefix, nbrtables, nrules);
	      if (lang == BASH)
		{
		  printf (" ,");
		  for (r = 0; r < nrules; r++)
		    {
		      printf (" %u", ccide.no[r][0]);
		    }
		}
	      else
		{
		  for (r = 0; r < nrules; r++)
		    {
		      printf (", %u", ccide.no[r][0]);
		    }
		}
	      printf (")\n");
	    }
	}
      else
	{
	  printf ("%s\tunsigned long %s_table%i_no[%i]= {",
		  lws, pPrefix, nbrtables, nrules);
	  NotFirst = 0;
	  for (r = 0; r < nrules; r++)
	    {
	      if (NotFirst)
		printf (",");
	      NotFirst = 1;
	      if (lang == EX)
		printf ("%4u", ccide.no[r][0]);
	      else
		printf ("%4uUL", ccide.no[r][0]);
	    }
	  printf ("};\n");
	}
    }

  if (ccide_newgroup)
    {
      if (lang == EX)
	printf ("%s\t%s_group=1\n", lws, pPrefixLc);
      else
	printf ("%s\t%s_group=1;\n", lws, pPrefixLc);
      ccide_newgroup = 0;
    }

  if (logLabel)
    {
      if (m4out)
	printf ("\n%s%s_LABEL(%s_TABLE_%i)",
		lws, pPrefix, pPrefix, nbrtables);
      else
	printf ("\n%s%s_TABLE_%i:", lws, pPrefix, nbrtables);
    }
  else
    {
      printf ("\n");
    }

  GenConds (nconds, nrules, notable);
  GenEnd ();
}

#ifndef ThisProgramCanHandleDefaultCases
	/* Look for condition substitution. */
int
CanDoSwitch ()
{
  static char *c;

  c = ccide.conccideable[0];

  while (*c != 0)
    {
      if ((*c == '$') && (*(c + 1) == '$'))
	{
	  return 1;
	}
      c++;
    }

  return 0;
}
#endif  /* End if ThisProgramCanHandleDefaultCases is not defined. */

static void
GenerateLabel ()
{

  if (logLabel)
    {
      if (m4out)
	printf ("\n%s%s_LABEL(%s_TABLE_%i)",
		lws, pPrefix, pPrefix, nbrtables);
      else
	printf ("\n%s%s_TABLE_%i:", lws, pPrefix, nbrtables);
    }
}

	/* Just one condition entry, number rules < 3. */
void
GenerateIfElseRule (int nrules, int nconds, int nactions)
{
  int i, c, r = 0;
  char *s;
  char sand[80] = "";

  GenerateLabel ();

  if (m4out)
    printf ("%s%s_IF()", lws, pPrefix);
  else
    printf ("%sif( ", lws);

  strcpy (sand, "");
  s = ccide.conccideable[0];
  while ((*s != 0) && ((*s == ' ') || (*s == '\t')))
    s++;
  if (ccide.no[0][0] & 1)
    {
      if (m4out)
	printf ("%s%s_FALSE(%s%s%s)", sand, pPrefix, qt1, s, qt2);
      else
	printf ("%s!(%s)", sand, s);
    }
  else
    {
      if (ccide.yes[0][0] & 1)
	{
	  if (m4out)
	    printf ("%s%s_TRUE(%s%s%s)", sand, pPrefix, qt1, s, qt2);
	  else
	    printf ("%s(%s)", sand, s);
	}
    }

  if (m4out)
    printf ("%s_ENDCOND()\n", pPrefix);
  else
    printf (" )  {\n");

  for (i = 0; i < nactions; i++)
    {
      c = 1 << i;
      if ((ccide.actiontable[i] != NULL) && (ccide.act[0][0] & c))
	{
	  if (m4out)
	    printf ("%s   %s_ACTION(%s%s%s)\n",
		    lws, pPrefix, qt1, ccide.actiontable[i], qt2);
	  else
	    printf ("%s   %s\n", lws, ccide.actiontable[i]);
	}
    }

  if (nrules > 0)
    {
      if (m4out)
	printf ("%s%s_ELSE()", lws, pPrefix);
      else
	printf ("%s} else { \n", lws);
      for (i = 0; i < nactions; i++)
	{
	  c = 1 << i;
	  if ((ccide.actiontable[i] != NULL) && (ccide.act[1][0] & c))
	    {
	      if (m4out)
		printf ("%s   %s_ACTION(%s%s%s)\n",
			lws, pPrefix, qt1, ccide.actiontable[i], qt2);
	      else
		printf ("%s   %s\n", lws, ccide.actiontable[i]);
	    }
	}

    }


  if (m4out)
    printf
      ("%s%s_ENDIF()\n%s%s%sEND_GENERATED_CODE: FOR TABLE_%i, by ccide-%s-%s %s%s%s",
       lws, pPrefix, lws, pComment, qt1, nbrtables, VERSION, RELEASE,
       GetTimeStamp (), pEcomment, qt2);
  else
    GenEnd ();
}

	/* Print the generated C code from the ccide table. */
void
GenerateSingleRule (int nconds, int nactions)
{				/* ?? MARKIT Generate label */
  int i, c;
  char *s;
  char sand[80] = "";

  GenerateLabel ();
  if (m4out)
    printf ("%s%s_IF()", lws, pPrefix);
  else
    printf ("%sif( ", lws);

  for (i = 0; i < nconds; i++)
    {
      c = 1 << i;
      if (i > 0)
	if (m4out)
	  snprintf (sand, sizeof (sand) - strlen (pPrefix) - 10, "%s_SAND()",
		    pPrefix);
	else
	  strcpy (sand, " && ");
      else
	strcpy (sand, "");
      s = ccide.conccideable[i];
      while ((*s != 0) && ((*s == ' ') || (*s == '\t')))
	s++;
      if (ccide.no[0][0] & c)
	{
	  if (m4out)
	    printf ("%s%s_FALSE(%s%s%s)", sand, pPrefix, qt1, s, qt2);
	  else
	    printf ("%s!(%s)", sand, s);
	}
      else
	{
	  if (ccide.yes[0][0] & c)
	    {
	      if (m4out)
		printf ("%s%s_TRUE(%s%s%s)", sand, pPrefix, qt1, s, qt2);
	      else
		printf ("%s(%s)", sand, s);
	    }
	}
    }

  if (m4out)
    printf ("%s_ENDCOND()\n", pPrefix);
  else
    printf (" )  {\n");

  for (i = 0; i < nactions; i++)
    {
      c = 1 << i;
      if ((ccide.actiontable[i] != NULL) && (ccide.act[0][0] & c))
	{
	  if (m4out)
	    printf ("%s   %s_ACTION(%s%s%s)\n",
		    lws, pPrefix, qt1, ccide.actiontable[i], qt2);
	  else
	    printf ("%s   %s\n", lws, ccide.actiontable[i]);
	}
    }

  if (m4out)
    printf
      ("%s%s_ENDIF()\n%s%s%sEND_GENERATED_CODE: FOR TABLE_%i, by ccide-%s-%s %s%s%s",
       lws, pPrefix, lws, pComment, qt1, nbrtables, VERSION, RELEASE,
       GetTimeStamp (), pEcomment, qt2);
  else
    GenEnd ();
}


int showruleorder = 1;
static void
ShowOrder (int nrules, int map[])
{
  int i;

  for (i = 0; i < nrules; i++)
    {
      printf ("%i ", map[i]);
    }
}

static void
ShowRuleOrder (int nrules)
{
  if (showruleorder)
    {
      if (m4out)
	{;
	  printf ("%s%s%s\tTable %i rule order = ", lws, pComment, qt1,
		  nbrtables);
	  ShowOrder (nrules, remap);
	  printf ("%s%s\n", qt2, pEcomment);
	}
      else
	{
	  printf ("%s%s\tTable %i rule order = ", lws, pComment, nbrtables);
	  ShowOrder (nrules, remap);
	  printf ("%s\n", pEcomment);
	}
    }
}

	/* Print the generated C code from the ccide table. */
void
Generate (int nconds, int nactions, int nrules)
{
  int i, ndrop = 0;

  for (i = 0; i <= CCIDE_NRULE;)
    isagoto[i++] = 0;
  assert (ccide.dummy_guard[0] == 19);
  if (donotgenerate)
    return;


  nbrrule = nrules;
  nbrcond = nconds;
  nbractions = nactions;

  if (m4out)
    {
      printf ("%s%s%sGENERATED_CODE: FOR TABLE_%i.%s%s\n",
	      lws, pComment, qt1, nbrtables, qt2, pEcomment);
    }
  else
    {
      printf ("%s%sGENERATED_CODE: FOR TABLE_%i.\n",
	      lws, pComment, nbrtables);
    }
  ncwords = (nbrcond - 1) / INTBITS + 1;
  nawords = (nactions - 1) / INTBITS + 1;
  FixNulls (nrules);
  Reorder (nrules);
  ndrop = DropEmpty (nrules);	/* number rules(at end) to drop */
  CcideCheckRules (ndrop);
  if (m4out)
    {
      printf ("%s%s%s\t%i Rules, %i conditions, and %i actions.%s%s\n",
	      lws, pComment, qt1, nrules - ndrop, nconds, nactions, qt2,
	      pEcomment);
    }
  else
    {
      printf ("%s%s\t%i Rules, %i conditions, and %i actions.%s\n",
	      lws, pComment, nrules - ndrop, nconds, nactions, pEcomment);
    }

#ifdef ThisProgramCanHandleDefaultCases
  /*DECISION_TABLE:                                               */
  /*  Y - - - | nbrcstubs==1                                      */
  /*  Y - - - | nconds<=(nrules-ndrop)                            */
  /*  - - N Y | nconds==1                                         */
  /*  Y - - N | switchable                                        */
  /*  N Y N N | (nrules-ndrop)==1                                 */
  /*  Y - Y Y | (nrules-ndrop)>0                                  */
  /*  - - - Y | (nrules-ndrop)<3                                  */
  /* ------------------------------------------------------------- */
  /*  X - - - | GenerateCases(nactions, nrules-ndrop);            */
  /*  - X - - | GenerateSingleRule(nconds,nactions);              */
  /*  - - - X | GenerateIfElseRule(nrules-ndrop,nconds,nactions); */
  /*  - - X - | ShowRuleOrder(nrules-ndrop);                      */
  /*  - - X - | GenerateFindRule(nconds,nactions,nrules-ndrop);   */
  /*END_TABLE:                                                    */



#else
  /*DECISION_TABLE:                                       */
  /*  Y - - | nbrcstubs==1                                */
  /*  Y - - | nconds==(nrules-ndrop)                      */
  /*  Y - - | CanDoSwitch()                               */
  /*  N Y N | (nrules-ndrop)==1                   */
  /*  Y - Y | (nrules-ndrop)>0                            */
  /* ---------------------                                */
  /*  X - - | GenerateCases(nactions, nrules-ndrop);      */
  /*  - X - | GenerateSingleRule(nconds,nactions);        */
  /*  - - X | ShowRuleOrder(nrules-ndrop);                        */
  /*  - - X | GenerateFindRule(nconds,nactions,nrules-ndrop); */
  /*END_TABLE:                                            */



#endif /* End if defined: ThisProgramCanHandleDefaultCases */
  logLabel = FALSE;
  switchable = 0;		/* Assume unswitchable for next table. */
}

/* End of ccidemain.c < ccidemain.cd */
