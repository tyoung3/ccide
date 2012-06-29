/* A Bison parser, made by GNU Bison 2.3.  */

/* Skeleton implementation for Bison's Yacc-like parsers in C

   Copyright (C) 1984, 1989, 1990, 2000, 2001, 2002, 2003, 2004, 2005, 2006
   Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 51 Franklin Street, Fifth Floor,
   Boston, MA 02110-1301, USA.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "2.3"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Using locations.  */
#define YYLSP_NEEDED 0



/* Tokens.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
   /* Put the tokens into the symbol table, so that GDB and other debuggers
      know about them.  */
   enum yytokentype {
     YES = 258,
     ACT = 259,
     DONT_CARE = 260,
     NO = 261,
     NUMBER = 262,
     PSTUB = 263,
     TEND = 264,
     NEWGROUP = 265,
     START_ACTIONS = 266,
     TSTART = 267
   };
#endif
/* Tokens.  */
#define YES 258
#define ACT 259
#define DONT_CARE 260
#define NO 261
#define NUMBER 262
#define PSTUB 263
#define TEND 264
#define NEWGROUP 265
#define START_ACTIONS 266
#define TSTART 267




/* Copy the first part of user declarations.  */

    /* {(  

**   Decision table compiler  twy 5/9/2002
*/

/*         ccide - C Language Decision Table Code Generator                  */
/* Copyright (C) 2002-2004 Thomas W. Young, e-mail:  ccide@twyoung.com       */
/* This program is free software; you can redistribute it and/or modify      */
/* it under the terms of the GNU General Public License as published by      */
/* the Free Software Foundation.                                             */
/*                                                                           */
/* This program is distributed in the hope that it will be useful,           */
/* but WITHOUT ANY WARRANTY; without even the implied warranty of            */
/* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the             */
/* GNU General Public License for more details.                              */
/*                                                                           */
/* You should have received a copy of the GNU General Public License         */
/* along with this program; if not, write to the Free Software               */
/* Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.                 */
/* ----------------------------------------------- end of legal stuff ------ */ 

#define twy
#define PARSE_STRING_SIZE 4096

#include "ccideconfig.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
#include <assert.h>
#include "ccidemain.h"

	/* Maximum argument string length. */
#define MAXARG 40

static char ctbl[10];
static char xs[81];
static char *xstring=xs;    /* For adding a new rule  */

int substitute=0;       /* 1 - If substitution in row */
int RC=0;		/* main() Return Code */

/* static CCIDE_HANDLE handle; */
static int nrules=0;   /* Number of rules */
static int nbrrules=0;   /* Number of rules */
static int nconds=0;   /* Number of condition statements */

int nactions=0;   /* Number of actions */
int DupeActionIsAnError=1;    /* 0=allow duplicate actions. */

void yyerror( const char *s);
int yylex( void );
void warning2( char *s, char *t);

#undef  LOGE
#undef  LOGP
#undef  syslog		/* Flawfinder: ignore */
#define syslog fprintf	/* Flawfinder: ignore */
#define LOGE   stderr
#define LOGP   stderr

#define YYDEBUG  1     /* Move 1 to yydebug to debug */ 
#define MAXTOKEN 1024

/* #include "cmbt.h"   data declarations, function prototypes */

#define EOL '\n'
#define EOS '\0'

void fatal(char *s);
static int columnsize=2;
static int skelsize=1; 		/* Size of skeleton decision table */
static void SetNbrRules(int n);
static void PrintC(char c);
static inline long int max( long int a, long int b);
static void PrintNum(long int n);
static char pGroup[100];
static int logCond=FALSE;

char *StripTrail(char *s) {
	int l;
	char *s1;

	l = strlen(s);
	s1=s+l-1;
	while(l-- && ( 
			(*s1 == ' ')  
			     ||
			(*s1 == '\t')  
		   )
	     ) { 
		*s1-- = 0; 
	}
	return s;
}



/* Enabling traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* Enabling the token table.  */
#ifndef YYTOKEN_TABLE
# define YYTOKEN_TABLE 0
#endif

#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE

{		/* stack object type	*/
    long int  ival;	/* integer value	*/
    char    *string;	/* A STRING:  "....."  */
    char    *sym;	/* A STRING:  "....."  */
}
/* Line 193 of yacc.c.  */

	YYSTYPE;
# define yystype YYSTYPE /* obsolescent; will be withdrawn */
# define YYSTYPE_IS_DECLARED 1
# define YYSTYPE_IS_TRIVIAL 1
#endif



/* Copy the second part of user declarations.  */


/* Line 216 of yacc.c.  */


#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#elif (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
typedef signed char yytype_int8;
#else
typedef short int yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(msgid) dgettext ("bison-runtime", msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(msgid) msgid
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(e) ((void) (e))
#else
# define YYUSE(e) /* empty */
#endif

/* Identity function, used to suppress warnings about constant conditions.  */
#ifndef lint
# define YYID(n) (n)
#else
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static int
YYID (int i)
#else
static int
YYID (i)
    int i;
#endif
{
  return i;
}
#endif

#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#     ifndef _STDLIB_H
#      define _STDLIB_H 1
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's `empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (YYID (0))
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined _STDLIB_H \
       && ! ((defined YYMALLOC || defined malloc) \
	     && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef _STDLIB_H
#    define _STDLIB_H 1
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined _STDLIB_H && (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
	 || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss;
  YYSTYPE yyvs;
  };

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

/* Copy COUNT objects from FROM to TO.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(To, From, Count) \
      __builtin_memcpy (To, From, (Count) * sizeof (*(From)))
#  else
#   define YYCOPY(To, From, Count)		\
      do					\
	{					\
	  YYSIZE_T yyi;				\
	  for (yyi = 0; yyi < (Count); yyi++)	\
	    (To)[yyi] = (From)[yyi];		\
	}					\
      while (YYID (0))
#  endif
# endif

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack)					\
    do									\
      {									\
	YYSIZE_T yynewbytes;						\
	YYCOPY (&yyptr->Stack, Stack, yysize);				\
	Stack = &yyptr->Stack;						\
	yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
	yyptr += yynewbytes / sizeof (*yyptr);				\
      }									\
    while (YYID (0))

#endif

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   17

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  13
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  12
/* YYNRULES -- Number of rules.  */
#define YYNRULES  24
/* YYNRULES -- Number of states.  */
#define YYNSTATES  27

/* YYTRANSLATE(YYLEX) -- Bison symbol number corresponding to YYLEX.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   267

#define YYTRANSLATE(YYX)						\
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[YYLEX] -- Bison symbol number corresponding to YYLEX.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12
};

#if YYDEBUG
/* YYPRHS[YYN] -- Index of the first RHS symbol of rule number YYN in
   YYRHS.  */
static const yytype_uint8 yyprhs[] =
{
       0,     0,     3,     5,     7,     9,    10,    13,    16,    18,
      20,    21,    24,    27,    30,    33,    36,    39,    40,    43,
      44,    47,    49,    51,    52
};

/* YYRHS -- A `-1'-separated list of the rules' RHS.  */
static const yytype_int8 yyrhs[] =
{
      24,     0,    -1,     3,    -1,     6,    -1,     5,    -1,    -1,
      15,    14,    -1,    15,     7,    -1,     4,    -1,     5,    -1,
      -1,    17,    16,    -1,    17,     7,    -1,    15,     8,    -1,
      15,    10,    -1,    17,    10,    -1,    17,     8,    -1,    -1,
      20,    18,    -1,    -1,    21,    19,    -1,    12,    -1,     9,
      -1,    -1,    24,    22,    20,    11,    21,    23,    -1
};

/* YYRLINE[YYN] -- source line where rule number YYN was defined.  */
static const yytype_uint8 yyrline[] =
{
       0,   128,   128,   134,   140,   143,   144,   149,   156,   161,
     164,   165,   170,   177,   186,   201,   210,   217,   218,   221,
     222,   225,   229,   254,   255
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || YYTOKEN_TABLE
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "YES", "ACT", "DONT_CARE", "NO",
  "NUMBER", "PSTUB", "TEND", "NEWGROUP", "START_ACTIONS", "TSTART",
  "$accept", "cond", "conds", "act", "actions", "condition_statement",
  "action_statement", "condition_statements", "action_statements", "start",
  "end", "DECISION_TABLE", 0
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[YYLEX-NUM] -- Internal token number corresponding to
   token YYLEX-NUM.  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267
};
# endif

/* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    13,    14,    14,    14,    15,    15,    15,    16,    16,
      17,    17,    17,    18,    18,    19,    19,    20,    20,    21,
      21,    22,    23,    24,    24
};

/* YYR2[YYN] -- Number of symbols composing right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     1,     1,     1,     0,     2,     2,     1,     1,
       0,     2,     2,     2,     2,     2,     2,     0,     2,     0,
       2,     1,     1,     0,     6
};

/* YYDEFACT[STATE-NAME] -- Default rule to reduce with in state
   STATE-NUM when YYTABLE doesn't specify something else to do.  Zero
   means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
      23,     0,     1,    21,    17,     5,    19,     0,    18,    10,
       2,     4,     3,     7,    13,    14,     6,    22,     0,    20,
      24,     8,     9,    12,    16,    15,    11
};

/* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,    16,     7,    26,    18,     8,    19,     5,     9,     4,
      20,     1
};

/* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
   STATE-NUM.  */
#define YYPACT_NINF -10
static const yytype_int8 yypact[] =
{
     -10,     0,   -10,   -10,   -10,    -9,   -10,    -2,   -10,     8,
     -10,   -10,   -10,   -10,   -10,   -10,   -10,   -10,     6,   -10,
     -10,   -10,   -10,   -10,   -10,   -10,   -10
};

/* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -10,   -10,   -10,   -10,   -10,   -10,   -10,   -10,   -10,   -10,
     -10,   -10
};

/* YYTABLE[YYPACT[STATE-NUM]].  What to do in state STATE-NUM.  If
   positive, shift that token.  If negative, reduce the rule which
   number is the opposite.  If zero, do what YYDEFACT says.
   If YYTABLE_NINF, syntax error.  */
#define YYTABLE_NINF -1
static const yytype_uint8 yytable[] =
{
       2,    10,     6,    11,    12,    13,    14,     0,    15,     0,
      21,    22,     3,    23,    24,     0,    25,    17
};

static const yytype_int8 yycheck[] =
{
       0,     3,    11,     5,     6,     7,     8,    -1,    10,    -1,
       4,     5,    12,     7,     8,    -1,    10,     9
};

/* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
   symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    24,     0,    12,    22,    20,    11,    15,    18,    21,
       3,     5,     6,     7,     8,    10,    14,     9,    17,    19,
      23,     4,     5,     7,     8,    10,    16
};

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		(-2)
#define YYEOF		0

#define YYACCEPT	goto yyacceptlab
#define YYABORT		goto yyabortlab
#define YYERROR		goto yyerrorlab


/* Like YYERROR except do call yyerror.  This remains here temporarily
   to ease the transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */

#define YYFAIL		goto yyerrlab

#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)					\
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    {								\
      yychar = (Token);						\
      yylval = (Value);						\
      yytoken = YYTRANSLATE (yychar);				\
      YYPOPSTACK (1);						\
      goto yybackup;						\
    }								\
  else								\
    {								\
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;							\
    }								\
while (YYID (0))


#define YYTERROR	1
#define YYERRCODE	256


/* YYLLOC_DEFAULT -- Set CURRENT to span from RHS[1] to RHS[N].
   If N is 0, then set CURRENT to the empty location which ends
   the previous symbol: RHS[0] (always defined).  */

#define YYRHSLOC(Rhs, K) ((Rhs)[K])
#ifndef YYLLOC_DEFAULT
# define YYLLOC_DEFAULT(Current, Rhs, N)				\
    do									\
      if (YYID (N))                                                    \
	{								\
	  (Current).first_line   = YYRHSLOC (Rhs, 1).first_line;	\
	  (Current).first_column = YYRHSLOC (Rhs, 1).first_column;	\
	  (Current).last_line    = YYRHSLOC (Rhs, N).last_line;		\
	  (Current).last_column  = YYRHSLOC (Rhs, N).last_column;	\
	}								\
      else								\
	{								\
	  (Current).first_line   = (Current).last_line   =		\
	    YYRHSLOC (Rhs, 0).last_line;				\
	  (Current).first_column = (Current).last_column =		\
	    YYRHSLOC (Rhs, 0).last_column;				\
	}								\
    while (YYID (0))
#endif


/* YY_LOCATION_PRINT -- Print the location on the stream.
   This macro was not mandated originally: define only if we know
   we won't break user code: when these are the locations we know.  */

#ifndef YY_LOCATION_PRINT
# if YYLTYPE_IS_TRIVIAL
#  define YY_LOCATION_PRINT(File, Loc)			\
     fprintf (File, "%d.%d-%d.%d",			\
	      (Loc).first_line, (Loc).first_column,	\
	      (Loc).last_line,  (Loc).last_column)
# else
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif
#endif


/* YYLEX -- calling `yylex' with the right arguments.  */

#ifdef YYLEX_PARAM
# define YYLEX yylex (YYLEX_PARAM)
#else
# define YYLEX yylex ()
#endif

/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)			\
do {						\
  if (yydebug)					\
    YYFPRINTF Args;				\
} while (YYID (0))

# define YY_SYMBOL_PRINT(Title, Type, Value, Location)			  \
do {									  \
  if (yydebug)								  \
    {									  \
      YYFPRINTF (stderr, "%s ", Title);					  \
      yy_symbol_print (stderr,						  \
		  Type, Value); \
      YYFPRINTF (stderr, "\n");						  \
    }									  \
} while (YYID (0))


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_value_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# else
  YYUSE (yyoutput);
# endif
  switch (yytype)
    {
      default:
	break;
    }
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
#else
static void
yy_symbol_print (yyoutput, yytype, yyvaluep)
    FILE *yyoutput;
    int yytype;
    YYSTYPE const * const yyvaluep;
#endif
{
  if (yytype < YYNTOKENS)
    YYFPRINTF (yyoutput, "token %s (", yytname[yytype]);
  else
    YYFPRINTF (yyoutput, "nterm %s (", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_stack_print (yytype_int16 *bottom, yytype_int16 *top)
#else
static void
yy_stack_print (bottom, top)
    yytype_int16 *bottom;
    yytype_int16 *top;
#endif
{
  YYFPRINTF (stderr, "Stack now");
  for (; bottom <= top; ++bottom)
    YYFPRINTF (stderr, " %d", *bottom);
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)				\
do {								\
  if (yydebug)							\
    yy_stack_print ((Bottom), (Top));				\
} while (YYID (0))


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yy_reduce_print (YYSTYPE *yyvsp, int yyrule)
#else
static void
yy_reduce_print (yyvsp, yyrule)
    YYSTYPE *yyvsp;
    int yyrule;
#endif
{
  int yynrhs = yyr2[yyrule];
  int yyi;
  unsigned long int yylno = yyrline[yyrule];
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
	     yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      fprintf (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr, yyrhs[yyprhs[yyrule] + yyi],
		       &(yyvsp[(yyi + 1) - (yynrhs)])
		       		       );
      fprintf (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)		\
do {					\
  if (yydebug)				\
    yy_reduce_print (yyvsp, Rule); \
} while (YYID (0))

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef	YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif



#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static YYSIZE_T
yystrlen (const char *yystr)
#else
static YYSIZE_T
yystrlen (yystr)
    const char *yystr;
#endif
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static char *
yystpcpy (char *yydest, const char *yysrc)
#else
static char *
yystpcpy (yydest, yysrc)
    char *yydest;
    const char *yysrc;
#endif
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
	switch (*++yyp)
	  {
	  case '\'':
	  case ',':
	    goto do_not_strip_quotes;

	  case '\\':
	    if (*++yyp != '\\')
	      goto do_not_strip_quotes;
	    /* Fall through.  */
	  default:
	    if (yyres)
	      yyres[yyn] = *yyp;
	    yyn++;
	    break;

	  case '"':
	    if (yyres)
	      yyres[yyn] = '\0';
	    return yyn;
	  }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into YYRESULT an error message about the unexpected token
   YYCHAR while in state YYSTATE.  Return the number of bytes copied,
   including the terminating null byte.  If YYRESULT is null, do not
   copy anything; just return the number of bytes that would be
   copied.  As a special case, return 0 if an ordinary "syntax error"
   message will do.  Return YYSIZE_MAXIMUM if overflow occurs during
   size calculation.  */
static YYSIZE_T
yysyntax_error (char *yyresult, int yystate, int yychar)
{
  int yyn = yypact[yystate];

  if (! (YYPACT_NINF < yyn && yyn <= YYLAST))
    return 0;
  else
    {
      int yytype = YYTRANSLATE (yychar);
      YYSIZE_T yysize0 = yytnamerr (0, yytname[yytype]);
      YYSIZE_T yysize = yysize0;
      YYSIZE_T yysize1;
      int yysize_overflow = 0;
      enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
      char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
      int yyx;

# if 0
      /* This is so xgettext sees the translatable formats that are
	 constructed on the fly.  */
      YY_("syntax error, unexpected %s");
      YY_("syntax error, unexpected %s, expecting %s");
      YY_("syntax error, unexpected %s, expecting %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s");
      YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s");
# endif
      char *yyfmt;
      char const *yyf;
      static char const yyunexpected[] = "syntax error, unexpected %s";
      static char const yyexpecting[] = ", expecting %s";
      static char const yyor[] = " or %s";
      char yyformat[sizeof yyunexpected
		    + sizeof yyexpecting - 1
		    + ((YYERROR_VERBOSE_ARGS_MAXIMUM - 2)
		       * (sizeof yyor - 1))];
      char const *yyprefix = yyexpecting;

      /* Start YYX at -YYN if negative to avoid negative indexes in
	 YYCHECK.  */
      int yyxbegin = yyn < 0 ? -yyn : 0;

      /* Stay within bounds of both yycheck and yytname.  */
      int yychecklim = YYLAST - yyn + 1;
      int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
      int yycount = 1;

      yyarg[0] = yytname[yytype];
      yyfmt = yystpcpy (yyformat, yyunexpected);

      for (yyx = yyxbegin; yyx < yyxend; ++yyx)
	if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR)
	  {
	    if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
	      {
		yycount = 1;
		yysize = yysize0;
		yyformat[sizeof yyunexpected - 1] = '\0';
		break;
	      }
	    yyarg[yycount++] = yytname[yyx];
	    yysize1 = yysize + yytnamerr (0, yytname[yyx]);
	    yysize_overflow |= (yysize1 < yysize);
	    yysize = yysize1;
	    yyfmt = yystpcpy (yyfmt, yyprefix);
	    yyprefix = yyor;
	  }

      yyf = YY_(yyformat);
      yysize1 = yysize + yystrlen (yyf);
      yysize_overflow |= (yysize1 < yysize);
      yysize = yysize1;

      if (yysize_overflow)
	return YYSIZE_MAXIMUM;

      if (yyresult)
	{
	  /* Avoid sprintf, as that infringes on the user's name space.
	     Don't have undefined behavior even if the translation
	     produced a string with the wrong number of "%s"s.  */
	  char *yyp = yyresult;
	  int yyi = 0;
	  while ((*yyp = *yyf) != '\0')
	    {
	      if (*yyp == '%' && yyf[1] == 's' && yyi < yycount)
		{
		  yyp += yytnamerr (yyp, yyarg[yyi++]);
		  yyf += 2;
		}
	      else
		{
		  yyp++;
		  yyf++;
		}
	    }
	}
      return yysize;
    }
}
#endif /* YYERROR_VERBOSE */


/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

/*ARGSUSED*/
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
#else
static void
yydestruct (yymsg, yytype, yyvaluep)
    const char *yymsg;
    int yytype;
    YYSTYPE *yyvaluep;
#endif
{
  YYUSE (yyvaluep);

  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  switch (yytype)
    {

      default:
	break;
    }
}


/* Prevent warnings from -Wmissing-prototypes.  */

#ifdef YYPARSE_PARAM
#if defined __STDC__ || defined __cplusplus
int yyparse (void *YYPARSE_PARAM);
#else
int yyparse ();
#endif
#else /* ! YYPARSE_PARAM */
#if defined __STDC__ || defined __cplusplus
int yyparse (void);
#else
int yyparse ();
#endif
#endif /* ! YYPARSE_PARAM */



/* The look-ahead symbol.  */
int yychar;

/* The semantic value of the look-ahead symbol.  */
YYSTYPE yylval;

/* Number of syntax errors so far.  */
int yynerrs;



/*----------.
| yyparse.  |
`----------*/

#ifdef YYPARSE_PARAM
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void *YYPARSE_PARAM)
#else
int
yyparse (YYPARSE_PARAM)
    void *YYPARSE_PARAM;
#endif
#else /* ! YYPARSE_PARAM */
#if (defined __STDC__ || defined __C99__FUNC__ \
     || defined __cplusplus || defined _MSC_VER)
int
yyparse (void)
#else
int
yyparse ()

#endif
#endif
{
  
  int yystate;
  int yyn;
  int yyresult;
  /* Number of tokens to shift before error messages enabled.  */
  int yyerrstatus;
  /* Look-ahead token as an internal (translated) token number.  */
  int yytoken = 0;
#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

  /* Three stacks and their tools:
     `yyss': related to states,
     `yyvs': related to semantic values,
     `yyls': related to locations.

     Refer to the stacks thru separate pointers, to allow yyoverflow
     to reallocate them elsewhere.  */

  /* The state stack.  */
  yytype_int16 yyssa[YYINITDEPTH];
  yytype_int16 *yyss = yyssa;
  yytype_int16 *yyssp;

  /* The semantic value stack.  */
  YYSTYPE yyvsa[YYINITDEPTH];
  YYSTYPE *yyvs = yyvsa;
  YYSTYPE *yyvsp;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  YYSIZE_T yystacksize = YYINITDEPTH;

  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;


  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss;
  yyvsp = yyvs;

  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
	/* Give user a chance to reallocate the stack.  Use copies of
	   these so that the &'s don't force the real ones into
	   memory.  */
	YYSTYPE *yyvs1 = yyvs;
	yytype_int16 *yyss1 = yyss;


	/* Each stack pointer address is followed by the size of the
	   data in use in that stack, in bytes.  This used to be a
	   conditional around just the two extra args, but that might
	   be undefined if yyoverflow is a macro.  */
	yyoverflow (YY_("memory exhausted"),
		    &yyss1, yysize * sizeof (*yyssp),
		    &yyvs1, yysize * sizeof (*yyvsp),

		    &yystacksize);

	yyss = yyss1;
	yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
	goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
	yystacksize = YYMAXDEPTH;

      {
	yytype_int16 *yyss1 = yyss;
	union yyalloc *yyptr =
	  (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
	if (! yyptr)
	  goto yyexhaustedlab;
	YYSTACK_RELOCATE (yyss);
	YYSTACK_RELOCATE (yyvs);

#  undef YYSTACK_RELOCATE
	if (yyss1 != yyssa)
	  YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;


      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
		  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
	YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     look-ahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to look-ahead token.  */
  yyn = yypact[yystate];
  if (yyn == YYPACT_NINF)
    goto yydefault;

  /* Not known => get a look-ahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid look-ahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = YYLEX;
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yyn == 0 || yyn == YYTABLE_NINF)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the look-ahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  yystate = yyn;
  *++yyvsp = yylval;

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     `$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 2:

    {
		SetYes( nrules, nconds );
		assert(substitute == 0);
		logCond = TRUE;
		(yyval.ival)=YES;
	}
    break;

  case 3:

    {
		assert(substitute == 0);
		SetNo( nrules, nconds );
		logCond = TRUE;
		(yyval.ival)=NO;
	}
    break;

  case 4:

    {(yyval.ival)=DONT_CARE;}
    break;

  case 6:

    {  
		assert( (yyvsp[(2) - (2)].ival) >= YES );
		PrintC(ctbl[(yyvsp[(2) - (2)].ival)-YES]);
		nrules++; 
	}
    break;

  case 7:

    {  
		substitute = SetNumber(nconds, nrules, (yyvsp[(2) - (2)].ival));
		PrintNum( (long) (yyvsp[(2) - (2)].ival));
		logCond = TRUE;
		nrules++; 
	}
    break;

  case 8:

    {
		/* printf(" "); */
		SetAct( nrules, nactions );
		(yyval.ival) = ACT; 
	}
    break;

  case 9:

    {(yyval.ival) = DONT_CARE;}
    break;

  case 11:

    { 
		assert( (yyvsp[(2) - (2)].ival) >= YES );
		PrintC(  ctbl[(yyvsp[(2) - (2)].ival) - YES]);
		nrules++; 
	}
    break;

  case 12:

    { 
		substitute = SetANumber(nactions, nrules, (yyvsp[(2) - (2)].ival));
		PrintNum( (long) (yyvsp[(2) - (2)].ival)); 
		nrules++; 
	}
    break;

  case 13:

    {
		printf(" %s|%s%s", xstring, (yyvsp[(2) - (2)].string), pEcomment);
	    if(logCond) {
		nconds+=SetCSTUBscan( nconds, StripTrail((yyvsp[(2) - (2)].string)) );
		logCond = FALSE;
	    }	
	    SetNbrRules(nrules);
	    substitute=0; 
	}
    break;

  case 14:

    {
		printf(" %s|NEWGROUP\t\t%s", xstring, pEcomment);
	    if(logCond) {
		if(lang==EX)
			sprintf(pGroup, "%s_group = $$", pPrefixLc);
		else
			sprintf(pGroup, "%s_group == $$", pPrefixLc);
		nconds+=SetCSTUBscan( nconds, pGroup );
		logCond = FALSE;
	    }
	    SetNbrRules(nrules);
	    substitute=0; 
	}
    break;

  case 15:

    {
		ccide_newgroup=1;
		printf(" %s|NEWGROUP\t\t%s", xstring,  pEcomment);
		SetASTUBn( nactions, nrules );
		SetNbrRules(nrules);
		nactions += (substitute+1);
		substitute=0;
	}
    break;

  case 16:

    {
		printf(" %s|%s%s", xstring, (yyvsp[(2) - (2)].string),pEcomment);
		nactions += SetASTUBscan( nactions, ExpVar2(StripTrail((yyvsp[(2) - (2)].string))) );
		substitute=0;
		SetNbrRules(nrules);
	}
    break;

  case 21:

    {
	UnSetNumbers();
	}
    break;

  case 22:

    {
	  if(nbrrules > CCIDE_NRULE) {
		/* yyerror( "Excessive number of rules.");  */
		ERROR3("%i exceeds the maximum number of rules  %i.", 
			 nbrrules, CCIDE_NRULE);
		nbrrules = CCIDE_NRULE;
	  }
	  if(nactions > CCIDE_NACTION) {
		/* yyerror( "Excessive number of actions.");  */
		ERROR3("%i exceeds the maximum number of actions %i.", 
			 nactions, CCIDE_NACTION);
		nactions = CCIDE_NACTION;
	  }
	  if(nconds > CCIDE_NCOND) {
		/* yyerror( "Excessive number of conditions.");  */
		ERROR3("%i exceeds the maximum number of conditions %i.", 
			 nconds, CCIDE_NCOND);
		nconds = CCIDE_NCOND;
	  }
	  Generate(nconds, nactions, nbrrules );
	  nbrcstubs = nbrrules = nactions = nconds=0;
	  ClearTable();
	  nbrtables++;
	}
    break;


/* Line 1267 of yacc.c.  */

      default: break;
    }
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;


  /* Now `shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*------------------------------------.
| yyerrlab -- here on detecting error |
`------------------------------------*/
yyerrlab:
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
      {
	YYSIZE_T yysize = yysyntax_error (0, yystate, yychar);
	if (yymsg_alloc < yysize && yymsg_alloc < YYSTACK_ALLOC_MAXIMUM)
	  {
	    YYSIZE_T yyalloc = 2 * yysize;
	    if (! (yysize <= yyalloc && yyalloc <= YYSTACK_ALLOC_MAXIMUM))
	      yyalloc = YYSTACK_ALLOC_MAXIMUM;
	    if (yymsg != yymsgbuf)
	      YYSTACK_FREE (yymsg);
	    yymsg = (char *) YYSTACK_ALLOC (yyalloc);
	    if (yymsg)
	      yymsg_alloc = yyalloc;
	    else
	      {
		yymsg = yymsgbuf;
		yymsg_alloc = sizeof yymsgbuf;
	      }
	  }

	if (0 < yysize && yysize <= yymsg_alloc)
	  {
	    (void) yysyntax_error (yymsg, yystate, yychar);
	    yyerror (yymsg);
	  }
	else
	  {
	    yyerror (YY_("syntax error"));
	    if (yysize != 0)
	      goto yyexhaustedlab;
	  }
      }
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse look-ahead token after an
	 error, discard it.  */

      if (yychar <= YYEOF)
	{
	  /* Return failure if at end of input.  */
	  if (yychar == YYEOF)
	    YYABORT;
	}
      else
	{
	  yydestruct ("Error: discarding",
		      yytoken, &yylval);
	  yychar = YYEMPTY;
	}
    }

  /* Else will try to reuse look-ahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule which action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;	/* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (yyn != YYPACT_NINF)
	{
	  yyn += YYTERROR;
	  if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
	    {
	      yyn = yytable[yyn];
	      if (0 < yyn)
		break;
	    }
	}

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
	YYABORT;


      yydestruct ("Error: popping",
		  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  if (yyn == YYFINAL)
    YYACCEPT;

  *++yyvsp = yylval;


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#ifndef yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEOF && yychar != YYEMPTY)
     yydestruct ("Cleanup: discarding lookahead",
		 yytoken, &yylval);
  /* Do not reclaim the symbols of the rule which action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
		  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  /* Make sure YYID is used.  */
  return YYID (yyresult);
}





/*  ---------------   */

char *progname ;
int lineno = 0 ;

/*  ---------------   */

/*
** #ifndef  twy
** int yylex( void ) {
**        int c;
** 
**     c = lex();
**     return c;
** }
** #endif
*/
/*  ---------------   */

/*-------------------------------------------------------------------
**  WARNING
*/
void warning2( char *s, char *t)
{
    syslog( LOGP, "%s: %s", progname, s) ;

    if (t)
	syslog( LOGP, " %s", t) ;

    syslog( LOGP, " near line %d\n", lineno) ;
}

	/* ?? Move this to ...?.h  */
#ifndef UINT_MAX
#include <limits.h>
#endif

static void SetNbrRules(int n) {

	DISPLAY(SetNbrRules);
	if( nbrrules == 0 ) {
		nbrrules=n;
	} else {
		if( nbrrules != n ) {
			/* yyerror( "Inconsistent number of rules."); */
			ERROR3("%i rules, instead of %i.", 
				n, nbrrules);
		}
	}

	nrules=0;
	DISPLAY(End SetNbrRules);
}

	/* Set Prefix */
static void SetPrefix(char *s) {
	char *s1;
	const char *const_1={"Prefix longer than 30 bytes."};
	if(strlen(s) > 30) {
		fprintf(stderr,const_1);
		return;
	}

	s1 = s;
	
	while(*s1) {
		if(  
			 ( (*s1 >= '0') && (*s1 <= '9') )
					||
			 ( (*s1 >= 'a') && (*s1 <= 'z') )
					||
			 ( (*s1 >= 'A') && (*s1 <= 'Z') )
					||
			 	   (*s1 == '_')
		  ) { 
			s1++;
		} else {
			fprintf(stderr,"Prefix contains illegal characters bytes.");
			return;
		}
	}

	pPrefix = s;
	pPrefixLc = s1 = strdup(s);
	
	while(*s1) {	
		*s1 = tolower(*s1);
		s1++;
	}
}

	/* Set Column size */
static void SetColumn(char *s) {
	
	columnsize=atoi(s);
	if(columnsize > 4)
		columnsize = 4;
}

	/* Check delimiters */
static int DelimitEq(char *s1, char *s2) {

	if( (s1==NULL) || (s2==NULL) ) {
		fprintf(stderr,"NULL Delimiter"); 
		return 1;
	}

	if( strcmp(s1,s2) == 0 ) {
		fprintf(stderr,"Delimiters cannot be equal."); 
		return 1;
	}


	if( strcmp(s1,qt1) == 0 ) {
		fprintf(stderr,"Delimiters cannot be equal."); 
		return 1;
	}

	if( strcmp(s2,qt2) == 0 ) {
		fprintf(stderr,"Delimiters cannot be equal."); 
		return 1;
	}

	if( strcmp(s1,svar1) == 0 ) {
		fprintf(stderr,"Delimiters cannot be equal."); 
		return 1;
	}

	if( strcmp(s2,svar2) == 0 ) {
		fprintf(stderr,"Delimiters cannot be equal."); 
		return 1;
	}

	return 0;
}

	/* Set stub substition strings. */
static void SetDelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	svar1=s1; 
	lsvar1=strlen(s1);
	lsvar2=strlen(s2);
	svar2=s2;
}

	/* Set m4 delimiters */
static void SetQdelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	qt1=s1; 
	lqt1=strlen(s1);
	lqt2=strlen(s2);
	qt2=s2;
	changequote=1;
}


	/* Set computer language */
static void SetLang(char *s) {

        //DECISION_TABLE:
        //  - N - - - - - - Y - - - | strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0
        //  - N - - - - - - - - - - | strcmp(s,"CC")==0    || strcmp(s,"cc")==0
        //  - N - - - - - - - - - - | strcmp(s,"C++")==0   || strcmp(s,"c++")==0
        //  N N - - - - - - - Y - - | strcmp(s,"C")==0     || strcmp(s,"c")==0
        //  - - Y - - - - - - - - - | strcmp(s,"BASH")==0
        //  - - - Y - - - - - - - - | strcmp(s,"bash")==0
        //  - - - - Y - - - - - - - | strcmp(s,"QB")==0
        //  - - - - - Y - - - - - - | strcmp(s,"qb")==0
        //  - - - - - - - - - - - Y | strcmp(s,"cs")==0   || strcmp(s,"CS")==0 || strcmp(s,"C#")==0 
        //  - N - - - - - - - - Y - | strcmp(s,"JAVA")==0 || strcmp(s,"java")==0
        //  - N - - - - Y - - - - - | strcmp(s,"VB")==0   || strcmp(s,"vb")==0
        //  - N - - - - - Y - - - - | (strcmp(s,"EX")==0) || (strcmp(s,"ex")==0)
        //  _______________________ |_________________________ ___________________
        //  - X - - - - - - - - - - | printf("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n", s); Usage();
        //  - - X X - - - - - - - - | lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");
        //  - - - - X X - - - - - - | lang=QB; 
        //  - - - - - - X - - - - - | lang=VB; 
        //  - - - - - - - X - - - - | lang=EX;	 // euphoria 
        //  - - - - - - - - X - - - | lang=BASIC; 
        //  - - - - - - - - - - X - | lang=JAVA; 
        //  - - - - - - - - - - - X | lang=CS;  
        //  - - - - - - - X - - X X | SetQdelimit("`","\'");     
        //  X - X X X X X X X - X - | m4out=1; pComment="CCIDE_COMMENT()";pEcomment="";
        //END_TABLE:
        //GENERATED_CODE: FOR TABLE_1.	12 Rules, 12 conditions, and 10 actions.
         {	unsigned long CCIDE_table1_yes[12]={2048UL,1024UL, 512UL, 256UL, 128UL,  64UL,  32UL,  16UL,   8UL,   1UL,   0UL,   0UL};
        	unsigned long CCIDE_table1_no[12]= {   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,3599UL,   8UL};


        	switch(CCIDEFindRule(12,
        		  (strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0)
        		| (strcmp(s,"CC")==0    || strcmp(s,"cc")==0)<<1
        		| (strcmp(s,"C++")==0   || strcmp(s,"c++")==0)<<2
        		| (strcmp(s,"C")==0     || strcmp(s,"c")==0)<<3
        		| (strcmp(s,"BASH")==0)<<4
        		| (strcmp(s,"bash")==0)<<5
        		| (strcmp(s,"QB")==0)<<6
        		| (strcmp(s,"qb")==0)<<7
        		| (strcmp(s,"cs")==0   || strcmp(s,"CS")==0 || strcmp(s,"C#")==0)<<8
        		| (strcmp(s,"JAVA")==0 || strcmp(s,"java")==0)<<9
        		| (strcmp(s,"VB")==0   || strcmp(s,"vb")==0)<<10
        		| ((strcmp(s,"EX")==0) || (strcmp(s,"ex")==0))<<11
        		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
        	case 2:	//	Rule 11 
        	    lang=JAVA;
        	    SetQdelimit("`","\'");
        	    goto CCIDE_case1_11;
        	case 0:	//	Rule 8 
        	    lang=EX;	 // euphoria
        	    SetQdelimit("`","\'");
        	    goto CCIDE_case1_11;
        	case 9:	//	Rule 9 
        	    lang=BASIC;
        	    goto CCIDE_case1_11;
        	case 1:	//	Rule 7 
        	    lang=VB;
        	    goto CCIDE_case1_11;
        	case 4:	//	Rule 6 
        	case 5:	//	Rule 5 
        	    lang=QB;
        	    goto CCIDE_case1_11;
        	case 6:	//	Rule 4 
        	case 7:	//	Rule 3 
        	    lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");
        	CCIDE_case1_11: case 11:	//	Rule 1 
        	    m4out=1; pComment="CCIDE_COMMENT()";pEcomment="";
        	    break;
        	case 3:	//	Rule 12 
        	    lang=CS;
        	    SetQdelimit("`","\'");
        	    break;
        	case 10:	//	Rule 2 
        	    printf("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n", s); Usage();
        	    break;
        	case 8:	//	Rule 10 
        	    break;
        	} // End Switch
        }
        //END_GENERATED_CODE: FOR TABLE_1, by ccide-0.4.0-1 Thu Sep 30 06:41:56 2010 

}

static void PrintC(char c) {
	//DECISION_TABLE:
	//  1 3 4 5 6 - | columnsize==$$
	// ------------ | --------------
	//  X - - - - - | printf("%c",c);
	//  - - - - - X | printf(" %c",c);
	//  - X - - - - | printf("  %c",c);
	//  - - X - - - | printf("   %c",c);
	//  - - - X - - | printf("    %c",c);
	//  - - - - X - | printf("     %c",c);
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_2.	6 Rules, 5 conditions, and 6 actions.
	 {	unsigned long CCIDE_table2_yes[6]={  16UL,   8UL,   4UL,   2UL,   1UL,   0UL};


		switch(CCIDEFindRuleYes(6,
			  (columnsize==1)
			| (columnsize==3)<<1
			| (columnsize==4)<<2
			| (columnsize==5)<<3
			| (columnsize==6)<<4
			  ,CCIDE_table2_yes)) {
		case 0:	//	Rule 5 
		    printf("     %c",c);
		    break;
		case 1:	//	Rule 4 
		    printf("    %c",c);
		    break;
		case 2:	//	Rule 3 
		    printf("   %c",c);
		    break;
		case 3:	//	Rule 2 
		    printf("  %c",c);
		    break;
		case 5:	//	Rule 6 
		    printf(" %c",c);
		    break;
		case 4:	//	Rule 1 
		    printf("%c",c);
		    break;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.4.0-1 Thu Sep 30 06:41:56 2010 



}

static inline long int max( long int a, long int b) {

	if( b > a) 
		return b;
	return a;
}

static void PrintNum(long n) {

	//DECISION_TABLE:
	//  2 3 4 5 - - - - - | columnsize==$$
	//  Y - - - Y N N N N | n<10
	//  - Y - - - Y N N N | n<100
	//  - - Y - - - Y N N | n<1000
	//  - - - Y - - - Y N | n<10000
	// -------------------| ------
	//  2 3 4 5 2 3 4 5 6 | printf("%$$li", n);
	//END_TABLE:     
	//GENERATED_CODE: FOR TABLE_3.	9 Rules, 8 conditions, and 5 actions.
	 {	unsigned long CCIDE_table3_yes[9]={ 136UL, 128UL,  68UL,  64UL,  34UL,  32UL,  17UL,  16UL,   0UL};
		unsigned long CCIDE_table3_no[9]= {   0UL, 112UL,   0UL,  48UL,   0UL,  16UL,   0UL,   0UL, 240UL};


		switch(CCIDEFindRule(9,
			  (columnsize==2)
			| (columnsize==3)<<1
			| (columnsize==4)<<2
			| (columnsize==5)<<3
			| (n<10)<<4
			| (n<100)<<5
			| (n<1000)<<6
			| (n<10000)<<7
			  ,CCIDE_table3_yes, CCIDE_table3_no)) {
		case 8:	//	Rule 9 
		    printf("%6li", n);
		    break;
		case 0:	//	Rule 4 
		case 1:	//	Rule 8 
		    printf("%5li", n);
		    break;
		case 2:	//	Rule 3 
		case 3:	//	Rule 7 
		    printf("%4li", n);
		    break;
		case 4:	//	Rule 2 
		case 5:	//	Rule 6 
		    printf("%3li", n);
		    break;
		case 6:	//	Rule 1 
		case 7:	//	Rule 5 
		    printf("%2li", n);
		    break;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_3, by ccide-0.4.0-1 Thu Sep 30 06:41:56 2010 



}

#define Argis(P) strcmp( #P, argv[narg]) == 0 

int main( int argc, char **argv) {
	int narg=1;
	char *s1;
	int ls1;

        assert( UINT_MAX == 4294967295UL);
	lws = Strdup("");

    while( argc>narg ) { 
	s1=argv[narg]; ls1=0;
	while(*s1 && ( ls1 < MAXARG ) ) {
		s1++; ls1++;
		if( *s1 == '|') {
			*s1 = '.';
		}
	}

	if( ls1 >= MAXARG) {
		argv[narg+MAXARG] = 0;
		fprintf(stderr, "Parameter %i is too long.\n", narg);
		exit(1);
	}

  	//DECISION_TABLE:
  	//  - - - - - - - - - - Y - - - - - - | Argis(-a)
  	//  Y - - - - - - - - - - - - - - - - | Argis(-b)
  	//  - - - - - - - - - - - - Y - - - - | Argis(-c)
  	//  - - - - - - - - - - - - - - Y - - | Argis(-d)
  	//  - Y - - - - - - - - - - - - - - - | Argis(-l)
  	//  - - - - - - - - - - - Y - - - - - | Argis(-L)
  	//  - - - - - - - - Y - - - - - - - - | Argis(-e)
  	//  - - - - - - - - - - - - - Y - - - | Argis(-m4)
  	//  - - Y - - - - - - - - - - - - - - | Argis(-n)
  	//  - - - - - - - - - - - - - - - - Y | Argis(-p)
  	//  - - - - - - - - - - - - - - - Y - | Argis(-q)
  	//  - - - Y - - - - - - - - - - - - - | Argis(-s)
  	//  - - - - Y - - - - - - - - - - - - | Argis(-t)
  	//  - - - - - Y - - - - - - - - - - - | Argis(-u)
  	//  - - - - - - Y - - - - - - - - - - | Argis(-V)
  	//  - - - - - - - - - Y - - - - - - - | Argis(-x)
  	//  _________________________________ | _________
  	//  X - - - - - - - - - - - - - - - - | notimestamp=1;
  	//  - X - - - - - - - - - - - - - - - | uselocaltime=1;
  	//  - - X - - X - - - - - - - - - - - | noinline=1;
  	//  - - - X - - - - - - - - - - - - - | if(GenSkeleton(argv[narg+1])) narg++;
  	//  - - - - X - - - - - - - - - - - - | yydebug=1;
  	//  - - - - - X - - - - - - - - - - - | donotgenerate=1;
  	//  - - - - - - X - - - - - - - - - - | ShowCopyright(); 
  	//  - - - - - - - X - - - - - - - - - | Usage();
  	//  - - - - - - - - X - - - - - - - - | checkequal=0;     // Do Not check for '='.
  	//  - - - - - - - - - X - - - - - - - | strcat(xstring, "- ");
  	//  - - - - - - - - - - X - - - - - - | DupeActionIsAnError=0;
  	//  - - - - - - - - - - - X - - - - - | SetLang(argv[narg+1]); narg++;
  	//  - - - - - - - - - - - - X - - - - | SetColumn(argv[narg+1]); narg++;
  	//  - - - - - - - - - - - - - X - - - | m4out=1; pComment="CCIDE_COMMENT()";pEcomment="";
  	//  - - - - - - - - - - - - - - X - - | SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//  - - - - - - - - - - - - - - - X - | SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//  - - - - - - - - - - - - - - - - X | SetPrefix(argv[narg+1]); narg++;
  	//  - - - X - - X X - - - - - - - - - | exit(0); 
  	//END_TABLE:  	
  	//GENERATED_CODE: FOR TABLE_4.	17 Rules, 16 conditions, and 18 actions.
  	 {	unsigned long CCIDE_table4_yes[17]={32768UL,16384UL,8192UL,4096UL,2048UL,1024UL, 512UL, 256UL, 128UL,  64UL,  32UL,  16UL,   8UL,   4UL,   2UL,   1UL,   0UL};


  		switch(CCIDEFindRuleYes(17,
  			  (Argis(-a))
  			| (Argis(-b))<<1
  			| (Argis(-c))<<2
  			| (Argis(-d))<<3
  			| (Argis(-l))<<4
  			| (Argis(-L))<<5
  			| (Argis(-e))<<6
  			| (Argis(-m4))<<7
  			| (Argis(-n))<<8
  			| (Argis(-p))<<9
  			| (Argis(-q))<<10
  			| (Argis(-s))<<11
  			| (Argis(-t))<<12
  			| (Argis(-u))<<13
  			| (Argis(-V))<<14
  			| (Argis(-x))<<15
  			  ,CCIDE_table4_yes)) {
  		case 16:	//	Rule 8 
  		    Usage();
  		    exit(0);
  		    break;
  		case 1:	//	Rule 7 
  		    ShowCopyright();
  		    exit(0);
  		    break;
  		case 4:	//	Rule 4 
  		    if(GenSkeleton(argv[narg+1])) narg++;
  		    exit(0);
  		    break;
  		case 6:	//	Rule 17 
  		    SetPrefix(argv[narg+1]); narg++;
  		    break;
  		case 5:	//	Rule 16 
  		    SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  		    break;
  		case 12:	//	Rule 15 
  		    SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  		    break;
  		case 8:	//	Rule 14 
  		    m4out=1; pComment="CCIDE_COMMENT()";pEcomment="";
  		    break;
  		case 13:	//	Rule 13 
  		    SetColumn(argv[narg+1]); narg++;
  		    break;
  		case 10:	//	Rule 12 
  		    SetLang(argv[narg+1]); narg++;
  		    break;
  		case 15:	//	Rule 11 
  		    DupeActionIsAnError=0;
  		    break;
  		case 0:	//	Rule 10 
  		    strcat(xstring, "- ");
  		    break;
  		case 9:	//	Rule 9 
  		    checkequal=0;     // Do Not check for '='.
  		    break;
  		case 2:	//	Rule 6 
  		    noinline=1;
  		    donotgenerate=1;
  		    break;
  		case 3:	//	Rule 5 
  		    yydebug=1;
  		    break;
  		case 7:	//	Rule 3 
  		    noinline=1;
  		    break;
  		case 11:	//	Rule 2 
  		    uselocaltime=1;
  		    break;
  		case 14:	//	Rule 1 
  		    notimestamp=1;
  		    break;
  		} // End Switch
  	}
  	//END_GENERATED_CODE: FOR TABLE_4, by ccide-0.4.0-1 Thu Sep 30 06:41:56 2010 



	narg++;
    }

	assert(NO>YES); assert(DONT_CARE>YES);
	ctbl[NO-YES]='N'; ctbl[YES-YES]='Y'; 
	ctbl[ACT-YES]='X'; ctbl[DONT_CARE-YES] ='-';
	yyparse();
	return RC;
}

/*--)}------------------------------------------------------------*/

