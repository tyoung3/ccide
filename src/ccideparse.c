/* A Bison parser, made by GNU Bison 3.7.6.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

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

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30706

/* Bison version string.  */
#define YYBISON_VERSION "3.7.6"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
    /* {(  

**   Decision table compiler  twy 5/9/2002
*/

/*  	ccide - C Language Decision Table Code Generator 
	Copyright (C) 2002-2004,2010,2012;  Thomas W. Young, e-mail:  ccide@twyoung.com

    	This file is part of ccide, the C Language Decision Table Code Generator.

   	ccide is free software: you can redistribute it and/or modify
   	it under the terms of the GNU General Public License as published by
    	the Free Software Foundation, either version 3 of the License, or
   	(at your option) any later version.

    	cide is distributed in the hope that it will be useful,
    	but WITHOUT ANY WARRANTY; without even the implied warranty of
    	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    	GNU General Public License for more details.

    	You should have received a copy of the GNU General Public License
    	along with cide.  If not, see <http://www.gnu.org/licenses/> or
    	write to the Free Software Foundation, Inc., 51 Franklin St, 
    	Fifth Floor, Boston, MA 02110-1301 USA.
*/

#define PARSE_STRING_SIZE 4096

	/* For gettext: */
#include "ccideconfig.h"
#include <locale.h>
#include "gettext.h"
#define _(string) gettext (string)
#define YYENABLE_NLS 1

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
static char *xstring=xs;    /* For adding a new rule  	*/

int substitute=0;        /* 1 - If substitution in row 	*/
int RC=0;		 /* main() Return Code 		*/

/* static CCIDE_HANDLE handle; */
static int nrules=0;   	 /* Number of rules */
static int nbrrules=0;   /* Number of rules */
static int nconds=0;   	 /* Number of condition statements 	*/

int nactions=0;   	 	/* Number of actions 		*/
int DupeActionIsAnError=1;    	/* 0=allow duplicate actions. 	*/

void yyerror( const char *s);
int yylex( void );
void warning2( char *s, char *t);

#undef  LOGE
#undef  LOGP
#undef  syslog		/* Flawfinder: ignore */
#define syslog fprintf	/* Flawfinder: ignore */
#define LOGE   stderr
#define LOGP   stderr

#define YYDEBUG  1      /* Move 1 to yydebug to debug 	*/ 
#define MAXTOKEN 1024	/* Largest possible token 	*/
#define EOL '\n'	/* End of line			*/
#define EOS '\0'	/* End of string		*/

void fatal(char *s);			/* Fatal error msg string		*/
static int columnsize=3;		/* Decision table spacing		*/
// static int skelsize=1; 		/* Size of skeleton decision table 	*/
static void SetNbrRules(int n);		
static void PrintC(char c);		/* Print a character 				*/
static inline long int max( long int a, long int b);  /* Return max of two values 	*/
static void PrintNum(long int n);	/* Print a number 				*/
static char pGroup[100];
static int logCond=FALSE;

/** Strip trailing whitespace 
 */
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



# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

/* Use api.header.include to #include this header
   instead of duplicating it here.  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    YES = 258,                     /* YES  */
    NO = 259,                      /* NO  */
    DONT_CARE = 260,               /* DONT_CARE  */
    ACT = 261,                     /* ACT  */
    NUMBER = 262,                  /* NUMBER  */
    PSTUB = 263,                   /* PSTUB  */
    TEND = 264,                    /* TEND  */
    NEWGROUP = 265,                /* NEWGROUP  */
    START_ACTIONS = 266,           /* START_ACTIONS  */
    TSTART = 267                   /* TSTART  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEMPTY -2
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define YES 258
#define NO 259
#define DONT_CARE 260
#define ACT 261
#define NUMBER 262
#define PSTUB 263
#define TEND 264
#define NEWGROUP 265
#define START_ACTIONS 266
#define TSTART 267

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
		/* stack object type	*/
    long int  ival;	/* integer value	*/
    char    *string;	/* A STRING:  "....."  */
    char    *sym;	/* A STRING:  "....."  */


};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_YES = 3,                        /* YES  */
  YYSYMBOL_NO = 4,                         /* NO  */
  YYSYMBOL_DONT_CARE = 5,                  /* DONT_CARE  */
  YYSYMBOL_ACT = 6,                        /* ACT  */
  YYSYMBOL_NUMBER = 7,                     /* NUMBER  */
  YYSYMBOL_PSTUB = 8,                      /* PSTUB  */
  YYSYMBOL_TEND = 9,                       /* TEND  */
  YYSYMBOL_NEWGROUP = 10,                  /* NEWGROUP  */
  YYSYMBOL_START_ACTIONS = 11,             /* START_ACTIONS  */
  YYSYMBOL_TSTART = 12,                    /* TSTART  */
  YYSYMBOL_YYACCEPT = 13,                  /* $accept  */
  YYSYMBOL_cond = 14,                      /* cond  */
  YYSYMBOL_conds = 15,                     /* conds  */
  YYSYMBOL_act = 16,                       /* act  */
  YYSYMBOL_actions = 17,                   /* actions  */
  YYSYMBOL_condition_statement = 18,       /* condition_statement  */
  YYSYMBOL_action_statement = 19,          /* action_statement  */
  YYSYMBOL_condition_statements = 20,      /* condition_statements  */
  YYSYMBOL_action_statements = 21,         /* action_statements  */
  YYSYMBOL_start = 22,                     /* start  */
  YYSYMBOL_end = 23,                       /* end  */
  YYSYMBOL_DECISION_TABLE = 24             /* DECISION_TABLE  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

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
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
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
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   18

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  13
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  12
/* YYNRULES -- Number of rules.  */
#define YYNRULES  24
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  27

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   267


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
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
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   159,   159,   165,   171,   174,   175,   180,   187,   192,
     195,   196,   201,   208,   218,   234,   249,   257,   258,   261,
     262,   265,   269,   291,   292
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "YES", "NO",
  "DONT_CARE", "ACT", "NUMBER", "PSTUB", "TEND", "NEWGROUP",
  "START_ACTIONS", "TSTART", "$accept", "cond", "conds", "act", "actions",
  "condition_statement", "action_statement", "condition_statements",
  "action_statements", "start", "end", "DECISION_TABLE", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267
};
#endif

#define YYPACT_NINF (-8)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
      -8,     0,    -8,    -8,    -8,    -7,    -8,    -2,    -8,     1,
      -8,    -8,    -8,    -8,    -8,    -8,    -8,    -8,     8,    -8,
      -8,    -8,    -8,    -8,    -8,    -8,    -8
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
      23,     0,     1,    21,    17,     5,    19,     0,    18,    10,
       2,     3,     4,     7,    13,    14,     6,    22,     0,    20,
      24,     9,     8,    12,    16,    15,    11
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
      -8,    -8,    -8,    -8,    -8,    -8,    -8,    -8,    -8,    -8,
      -8,    -8
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,    16,     7,    26,    18,     8,    19,     5,     9,     4,
      20,     1
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
       2,    10,    11,    12,     6,    13,    14,     0,    15,     0,
      17,     0,     3,    21,    22,    23,    24,     0,    25
};

static const yytype_int8 yycheck[] =
{
       0,     3,     4,     5,    11,     7,     8,    -1,    10,    -1,
       9,    -1,    12,     5,     6,     7,     8,    -1,    10
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    24,     0,    12,    22,    20,    11,    15,    18,    21,
       3,     4,     5,     7,     8,    10,    14,     9,    17,    19,
      23,     5,     6,     7,     8,    10,    16
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    13,    14,    14,    14,    15,    15,    15,    16,    16,
      17,    17,    17,    18,    18,    19,    19,    20,    20,    21,
      21,    22,    23,    24,    24
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     1,     1,     1,     0,     2,     2,     1,     1,
       0,     2,     2,     2,     2,     2,     2,     0,     2,     0,
       2,     1,     1,     0,     6
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
# ifndef YY_LOCATION_PRINT
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif


# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yykind < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yykind], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)]);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
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






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep)
{
  YY_USE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
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
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
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
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 2: /* cond: YES  */
              {
		SetYes( nrules, nconds );
		assert(substitute == 0);
		logCond = TRUE;
		(yyval.ival)=YES;
	}
    break;

  case 3: /* cond: NO  */
                {
		assert(substitute == 0);
		SetNo( nrules, nconds );
		logCond = TRUE;
		(yyval.ival)=NO;
	}
    break;

  case 4: /* cond: DONT_CARE  */
                    {(yyval.ival)=DONT_CARE;}
    break;

  case 6: /* conds: conds cond  */
                       {  
		assert( (yyvsp[0].ival) >= YES );
	 	PrintC(ctbl[(yyvsp[0].ival)-YES]);
		nrules++; 
	}
    break;

  case 7: /* conds: conds NUMBER  */
                       {  
		substitute = SetNumber(nconds, nrules, (yyvsp[0].ival));
		PrintNum( (long) (yyvsp[0].ival));
		logCond = TRUE;
		nrules++; 
	}
    break;

  case 8: /* act: ACT  */
          {
		/* printf(" "); */
		SetAct( nrules, nactions );
		(yyval.ival) = ACT; 
	}
    break;

  case 9: /* act: DONT_CARE  */
                    {(yyval.ival) = DONT_CARE;}
    break;

  case 11: /* actions: actions act  */
                         { 
		assert( (yyvsp[0].ival) >= YES );
		PrintC(  ctbl[(yyvsp[0].ival) - YES]);
		nrules++; 
	}
    break;

  case 12: /* actions: actions NUMBER  */
                         { 
		substitute = SetANumber(nactions, nrules, (yyvsp[0].ival));
		PrintNum( (long) (yyvsp[0].ival)); 
		nrules++; 
	}
    break;

  case 13: /* condition_statement: conds PSTUB  */
        {
	    printf(" %s|%s%s", xstring, (yyvsp[0].string),pEcomment);
	    if(logCond) {
		nconds+=SetCSTUBscan( nconds, StripTrail((yyvsp[0].string)) );
		logCond = FALSE;
	    }	
	    SetNbrRules(nrules);
	    substitute=0; 
	}
    break;

  case 14: /* condition_statement: conds NEWGROUP  */
                         {
	    //printf(" %s|NEWGROUP\t\t", xstring );
	    printf(" %s|NEWGROUP\t\t%s", xstring,pEcomment );
	    if(logCond) {
		if(lang==EX)
			sprintf(pGroup, "%s_group = %s", pPrefixLc, svar1);
		else
			sprintf(pGroup, "%s_group == %s", pPrefixLc, svar1);
		nconds+=SetCSTUBscan( nconds, pGroup );
		logCond = FALSE;
	    }
	    SetNbrRules(nrules);
	    substitute=0; 
	}
    break;

  case 15: /* action_statement: actions NEWGROUP  */
                         {
	    // printf(" %s|NEWGROUP", xstring); 
	    printf(" %s|NEWGROUP\t\t%s", xstring,pEcomment);
	    if(usegoto) {
		ccide_newgroup=1;
		SetASTUBn( nactions, nrules );
		SetNbrRules(nrules);
		nactions += (substitute+1);
		substitute=0;
	    } else {
		printf("\n");
		ERROR1(_("NEWGROUP not supported for GOTOless languages."));
	    }
	}
    break;

  case 16: /* action_statement: actions PSTUB  */
                      {
	        printf(" %s|%s%s", xstring, (yyvsp[0].string),pEcomment);
		// printf(" %s|%s", xstring, $2);
		nactions += SetASTUBscan( nactions, ExpVar2(StripTrail((yyvsp[0].string))) );
		substitute=0;
		SetNbrRules(nrules);
	}
    break;

  case 21: /* start: TSTART  */
               {
	UnSetNumbers();
	}
    break;

  case 22: /* end: TEND  */
             {
	  if(nbrrules > CCIDE_NRULE) {
		ERROR3(_("%i exceeds the maximum number of rules  %i."), 
			 nbrrules, CCIDE_NRULE);
		nbrrules = CCIDE_NRULE;
	  }
	  if(nactions > CCIDE_NACTION) {
		ERROR3(_("%i exceeds the maximum number of actions %i."), 
			 nactions, CCIDE_NACTION);
		nactions = CCIDE_NACTION;
	  }
	  if(nconds > CCIDE_NCOND) {
		ERROR3(_("%i exceeds the maximum number of conditions %i."), 
			 nconds, CCIDE_NCOND);
		nconds = CCIDE_NCOND;
	  }
	  Generate(nconds, nactions, nbrrules );
	  nbrcstubs = nbrrules = nactions = nconds=0;
	  ClearTable();
	  nbrtables++;
	}
    break;



      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
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

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
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
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
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
                  YY_ACCESSING_SYMBOL (yystate), yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

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


#if !defined yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturn;
#endif


/*-------------------------------------------------------.
| yyreturn -- parsing is finished, clean up and return.  |
`-------------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}



/*  ---------------   */

char *progname ;
int lineno = 0 ;

/*  ---------------   */

/*-------------------------------------------------------------------
**  WARNING
*/
void warning2( char *s, char *t)
{
    if(quiet) return;
    syslog( LOGP, "%s: %s", progname, s) ;

    if (t)
	syslog( LOGP, " %s", t) ;

    syslog( LOGP, " near line %d\n", lineno) ;
}

	/* ?? Move this to ...?.h  */
#ifndef UINT_MAX
#include <limits.h>
#endif /* End if not defined UINT_MAX */

/** Check number of rules equal to number in the first D/T statement.
 */ 
static void SetNbrRules(int n) {

	DISPLAY(SetNbrRules);
	if( nbrrules == 0 ) {
		nbrrules=n;
	} else {
		if( nbrrules != n ) {
			/* yyerror( "Inconsistent number of rules."); */
			ERROR3(_("%i rules, instead of %i."), 
				n, nbrrules);
		}
	}

	nrules=0;
	DISPLAY(End SetNbrRules);
}

	/** Set Prefix for D/T output.
        */
static void SetPrefix(char *s) {
	char *s1, *s2;

	if(strlen(s) > MAXPREFIX) {
		fprintf(stderr,_("Prefix longer than space allows."));
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
			fprintf(stderr,_("Prefix contains invalid characters."));
			return;
		}
	}

	strcpy(pPrefix,s);
	s1 = s2 = Strdup(s);
	
	while(*s1) {	
		*s1 = tolower(*s1);
		s1++;
	}
	strcpy(pPrefixLc,s1);
	free(s2);
}

	/* Set Column size */
static void SetColumn(char *s) {
	
	columnsize=atoi(s);
	if(columnsize > 4)
		columnsize = 4;
}

/** Ensure delimiters are orthogonal. 
 */ 
int DelimitCheck(char *s1, char *s2) {
	if( (strcmp(s1,s2)==0) && checkequal) {
		fprintf(stderr,_("CCIDE/FATAL: Delimiter %s cannot equal a QUOTE=(%s,%s) or a SUBSTITUTION=(%s,%s) \n"),
			s1,qt1,qt2,svar1,svar2); 
		return 1;
	}
	return 0;
}

	/* Check delimiters 
	 */
static int DelimitEq(char *s1, char *s2) {

	if( (s1==NULL) || (s2==NULL) ) {
		fprintf(stderr,_("NULL Delimiter\n")); 
		return 1;
	}

	if (
		DelimitCheck(s1,s2)
		|| DelimitCheck(s1,svar1)
		|| DelimitCheck(s2,svar2)
		|| DelimitCheck(s1,qt1)
		|| DelimitCheck(s2,qt2)
	)
 		return 1;

	return 0;
}

	/* Set stub substition strings. 
         */
static void SetDelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	svar1=s1; 
	lsvar1=strlen(s1);
	lsvar2=strlen(s2);
	svar2=s2;
}

	/* Set m4 delimiters 
	 */
static void SetQdelimit(char *s1, char *s2) {

	if(DelimitEq(s1, s2))
		return;

	qt1=s1; 
	lqt1=strlen(s1);
	lqt2=strlen(s2);
	qt2=s2;
	changequote=1;
}


static char *AddPfx(char *s1, char *s2) {
	char *s;

	s=malloc (strlen(s1) + strlen(s2) + 1);
	strcpy(s,s1);
	strcat(s,s2);
	return s;
}	
	/* Set computer language 
         */
static void SetLang(char *s) {
	int onone=1;

    if(onone) {     /* Disallow multiple language settings. LANG=C is default */
    onone=0;
        //DECISION_TABLE:
        //   N  -  -  -  -  -  Y  -  -  -  -  - | strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0
        //   N  -  -  -  -  -  -  -  -  -  -  - | strcmp(s,"CC")==0    || strcmp(s,"cc")==0 
        //   N  -  Y  -  -  -  -  -  -  -  -  - | strcmp(s,"BASH")==0  || strcmp(s,"bash")==0
        //   N  -  -  Y  -  -  -  -  -  -  -  - | strcmp(s,"QB")==0    || strcmp(s,"qb")==0
        //   N  -  -  -  -  -  -  -  -  Y  -  - | strcmp(s,"cs")==0    || strcmp(s,"CS")==0 || strcmp(s,"C#")==0 
        //   N  -  -  -  -  -  -  -  Y  -  -  - | strcmp(s,"JAVA")==0  || strcmp(s,"java")==0
        //   N  -  -  -  Y  -  -  -  -  -  -  - | strcmp(s,"VB")==0    || strcmp(s,"vb")==0
        //   N  -  -  -  -  Y  -  -  -  -  -  - | (strcmp(s,"EX")==0)  || (strcmp(s,"ex")==0)
        //   N  -  -  -  -  -  -  Y  -  -  -  - | strcmp(s,"C")==0     || strcmp(s,"c")==0
        //   N  -  -  -  -  -  -  -  -  -  Y  - | strcmp(s,"C++")==0   || strcmp(s,"c++")==0 
        //   N  -  -  -  -  -  -  -  -  -  -  Y | strcmp(s,"JS")==0    || strcmp(s,"js")==0 || strcmp(s,"JAVASCRIPT")==0   
        //  __________________________________________________________________________________________
        //   -  X  -  -  -  -  -  -  -  -  -  - | printf(_("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n"), s); Usage();exit(1);
        //   -  -  X  -  -  -  -  -  -  -  -  - | lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");usegoto=0;
        //   -  -  -  X  -  -  -  -  -  -  -  - | lang=QB; 
        //   -  -  -  -  X  -  -  -  -  -  -  - | lang=VB; 
        //   -  -  -  -  -  X  -  -  -  -  -  - | lang=EX;	 // euphoria 
        //   -  -  -  -  -  -  X  -  -  -  -  - | lang=BASIC; 
        //   -  -  -  -  -  -  -  -  X  -  -  - | lang=JAVA; 
        //   -  -  -  -  -  -  -  -  -  X  -  - | lang=CS;  
        //   -  -  -  -  -  -  -  -  -  -  -  X | lang=JS;  
        //   -  -  X  -  -  -  -  -  X  -  -  X | usegoto=0; // For GOTOless languages
        //   -  -  -  -  -  -  -  -  -  -  -  - | lang=CC;  
        //   X  -  -  -  -  X  -  -  X  X  -  - | SetQdelimit("`","\'");     
        //   X  -  X  X  X  X  -  -  X  -  -  - | m4out=1;     
        //   X  -  X  X  X  X  -  -  -  -  -  - | pComment=AddPfx(pPrefix,"_COMMENT(");  
        //   -  -  X  X  X  X  -  -  X  -  -  - | pEcomment=""; 
        //   -  -  -  -  -  -  -  -  -  -  -  - | pEcomment=")"; 
        //   -  -  -  -  -  -  -  -  X  -  -  - | pComment="//"; 
        //   X  -  X  X  X  X  -  -  X  -  -  - | M4Comment=AddPfx(pPrefix,"_COMMENT("); 
        //   X  -  X  X  X  X  -  -  X  -  -  - | M4Ecomment=")";
        //   -  -  -  -  -  -  -  -  -  -  -  - | M4Ecomment="";
        //END_TABLE:
        //GENERATED_CODE: FOR TABLE_1.
        //	12 Rules, 11 conditions, and 20 actions.
        //	Table 1 rule order = 1 7 3 4 10 9 5 6 8 11 12 2 
         {	unsigned long CCIDE_table1_yes[12]={   0UL,   1UL,   4UL,   8UL,  16UL,  32UL,  64UL, 128UL, 256UL, 512UL,1024UL,   0UL};
        	unsigned long CCIDE_table1_no[12]= {2047UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL,   0UL};


        	switch(CCIDEFindRule(12,
        		  (strcmp(s,"BASIC")==0 || strcmp(s,"basic")==0)
        		| (strcmp(s,"CC")==0    || strcmp(s,"cc")==0)<<1
        		| (strcmp(s,"BASH")==0  || strcmp(s,"bash")==0)<<2
        		| (strcmp(s,"QB")==0    || strcmp(s,"qb")==0)<<3
        		| (strcmp(s,"cs")==0    || strcmp(s,"CS")==0 || strcmp(s,"C#")==0)<<4
        		| (strcmp(s,"JAVA")==0  || strcmp(s,"java")==0)<<5
        		| (strcmp(s,"VB")==0    || strcmp(s,"vb")==0)<<6
        		| ((strcmp(s,"EX")==0)  || (strcmp(s,"ex")==0))<<7
        		| (strcmp(s,"C")==0     || strcmp(s,"c")==0)<<8
        		| (strcmp(s,"C++")==0   || strcmp(s,"c++")==0)<<9
        		| (strcmp(s,"JS")==0    || strcmp(s,"js")==0 || strcmp(s,"JAVASCRIPT")==0)<<10
        		  ,CCIDE_table1_yes, CCIDE_table1_no)) {
        	case  5:	//	Rule  9 
        	    lang=JAVA;
        	    usegoto=0; // For GOTOless languages
        	    SetQdelimit("`","\'");
        	    m4out=1;
        	    pEcomment="";
        	    pComment="//";
        	    M4Comment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Ecomment=")";
        	    break;
        	case  7:	//	Rule  6 
        	    lang=EX;	 // euphoria
        	    SetQdelimit("`","\'");
        	    m4out=1;
        	    pComment=AddPfx(pPrefix,"_COMMENT(");
        	    pEcomment="";
        	    M4Comment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Ecomment=")";
        	    break;
        	case  2:	//	Rule  3 
        	    lang=BASH; slang=s;SetQdelimit("^^^", "%%%");SetDelimit("/::","@@/");usegoto=0;
        	    usegoto=0; // For GOTOless languages
        	    m4out=1;
        	    pComment=AddPfx(pPrefix,"_COMMENT(");
        	    pEcomment="";
        	    M4Comment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Ecomment=")";
        	    break;
        	case  6:	//	Rule  5 
        	    lang=VB;
        	    m4out=1;
        	    pComment=AddPfx(pPrefix,"_COMMENT(");
        	    pEcomment="";
        	    M4Comment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Ecomment=")";
        	    break;
        	case  3:	//	Rule  4 
        	    lang=QB;
        	    m4out=1;
        	    pComment=AddPfx(pPrefix,"_COMMENT(");
        	    pEcomment="";
        	    M4Comment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Ecomment=")";
        	    break;
        	case  0:	//	Rule  1 
        	    SetQdelimit("`","\'");
        	    m4out=1;
        	    pComment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Comment=AddPfx(pPrefix,"_COMMENT(");
        	    M4Ecomment=")";
        	    break;
        	case  4:	//	Rule 10 
        	    lang=CS;
        	    SetQdelimit("`","\'");
        	    break;
        	case 10:	//	Rule 12 
        	    lang=JS;
        	    usegoto=0; // For GOTOless languages
        	    break;
        	case  1:	//	Rule  7 
        	    lang=BASIC;
        	    break;
        	case 11:	//	Rule  2 
        	    printf(_("CCIDE/PARSE: Sorry, %s programming language is not supported, yet.\n"), s); Usage();exit(1);
        	    break;
        	case  8:	//	Rule  8 
        	    break;
        	case  9:	//	Rule 11 
        	    break;
        	} // End Switch
        }
        //END_GENERATED_CODE: FOR TABLE_1, by ccide-0.6.4-1 Mon 03 Sep 2012 10:52:33 AM EDT 

    }  /* End if onone */
}

/** Print a character,  adjusting for column width.
 */
static void PrintC(char c) {
	//DECISION_TABLE:
	//   1  3  4  5  6  -  -  - | columnsize==$$
	//   ____________________________________
	//   X  -  -  -  -  -  -  - | printf("%c",c);
	//   -  -  -  -  -  X  -  - | printf(" %c",c);
	//   -  X  -  -  -  -  -  - | printf("  %c",c);
	//   -  -  X  -  -  -  -  - | printf("   %c",c);
	//   -  -  -  X  -  -  -  - | printf("    %c",c);
	//   -  -  -  -  X  -  -  - | printf("     %c",c);
	//END_TABLE:
	//GENERATED_CODE: FOR TABLE_2.
	//WARNING: Dropping rule 8 in table 2. 
	//WARNING: Dropping rule 7 in table 2. 
	//	6 Rules, 5 conditions, and 6 actions.
	 { CCIDE_TABLE_2: switch(columnsize) {	
		case 6:		//  Rule  5  
		    printf("     %c",c);
		    break;
		case 5:		//  Rule  4  
		    printf("    %c",c);
		    break;
		case 4:		//  Rule  3  
		    printf("   %c",c);
		    break;
		case 3:		//  Rule  2  
		    printf("  %c",c);
		    break;
		case 1:		//  Rule  1  
		    printf("%c",c);
		    break;
		 default:		//  Rule  6  
		    printf(" %c",c);
		    break;
	 }
	}
	//END_GENERATED_CODE: FOR TABLE_2, by ccide-0.6.4-1 Mon 03 Sep 2012 10:52:33 AM EDT 

}

/** Compute maximum of two values.
 */
static inline long int max( long int a, long int b) {

	if( b > a) 
		return b;
	return a;
}

/** Print number adjusting for column width.
 */
static void PrintNum(long n) {

	//DECISION_TABLE:
	//   2  3  4  5  -  -  -  -  -  -  - | columnsize==$$
	//   Y  -  -  -  Y  N  N  N  N  -  - | n<10
	//   -  Y  -  -  N  Y  N  N  N  -  - | n<100
	//   -  -  Y  -  -  -  Y  N  N  -  - | n<1000
	//   -  -  -  Y  -  -  -  Y  N  -  - | n<10000
	//   ______________________________________
	//   2  3  4  5  2  3  4  5  6  -  - | printf("%$$li", n);
	//END_TABLE:     
	//GENERATED_CODE: FOR TABLE_3.
	//WARNING: Dropping rule 11 in table 3. 
	//WARNING: Dropping rule 10 in table 3. 
	//	9 Rules, 8 conditions, and 5 actions.
	//	Table 3 rule order = 8 9 7 1 2 3 4 5 6 
	 {	unsigned long CCIDE_table3_yes[9]={ 128UL,   0UL,  64UL,  17UL,  34UL,  68UL, 136UL,  16UL,  32UL};
		unsigned long CCIDE_table3_no[9]= { 112UL, 240UL,  48UL,   0UL,   0UL,   0UL,   0UL,  32UL,  16UL};


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
		case  1:	//	Rule  9 
		    printf("%6li", n);
		    break;
		case  0:	//	Rule  8 
		case  6:	//	Rule  4 
		    printf("%5li", n);
		    break;
		case  2:	//	Rule  7 
		case  5:	//	Rule  3 
		    printf("%4li", n);
		    break;
		case  4:	//	Rule  2 
		case  8:	//	Rule  6 
		    printf("%3li", n);
		    break;
		case  3:	//	Rule  1 
		case  7:	//	Rule  5 
		    printf("%2li", n);
		    break;
		} // End Switch
	}
	//END_GENERATED_CODE: FOR TABLE_3, by ccide-0.6.4-1 Mon 03 Sep 2012 10:52:33 AM EDT 

}

/* Define condition for D/T. */
#define Argis(P) strcmp( #P, argv[narg]) == 0 

/** ccide main entry point. 
 */
int main( int argc, char **argv) {
	int narg=1;
	char *s1, *tdomain, *tdir;
	int ls1;

        assert( UINT_MAX == 4294967295UL);
	lws = Strdup("");

/* ENABLE_NLS is set (or not) in ccideconfig.h by configure. */
#ifdef  ENABLE_NLS
   	setlocale (LC_ALL, "");
	if(  (tdir=bindtextdomain (PACKAGE, LOCALEDIR)) == NULL) {
		perror(_("Binding gettext"));    
	};
	if(  (tdomain=textdomain (PACKAGE)) == NULL) {
		perror(_("Getting textdomain"));  
	}
#endif

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
		fprintf(stderr, _("Parameter %i is too long.\n"), narg);
		exit(1);
	}

  	//DECISION_TABLE:
  	//   -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  -  - | Argis(-a)||Argis(--actiondupes)
  	//   Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-b)||Argis(--blanktime)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  - | Argis(-c)||Argis(--columnsize)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  - | Argis(-d)||Argis(--delimiter)
  	//   -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  - | Argis(-e)||Argis(--equalok)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  - | Argis(-g)||Argis(--gotoless)
  	//   -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-l)||Argis(--localtime)
  	//   -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  - | Argis(-L)||Argis(--language) 
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  -  -  - | Argis(-m4)||Argis(--m4output)
  	//   -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-n)||Argis(--noinlinecode)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  - | Argis(-p)||Argis(--prefix)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y  -  -  - | Argis(-q)||Argis(--quote)
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  Y | Argis(-k)||Argis(--quiet)
  	//   -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-s)||Argis(--skeleton)
  	//   -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-t)||Argis(--trace)
  	//   -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-u)||Argis(--undo)
  	//   -  -  -  -  -  -  Y  -  -  -  -  -  -  -  -  -  -  -  - | Argis(-V)||Argis(--version)
  	//   -  -  -  -  -  -  -  -  -  Y  -  -  -  -  -  -  -  -  - | Argis(-x)||Argis(--extrarule)
  	//  ________________________________________________________________
  	//   X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | notimestamp=1;
  	//   -  X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | uselocaltime=1;
  	//   -  -  X  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  - | noinline=1;
  	//   -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  -  -  - | if(GenSkeleton(argv[narg+1])) narg++;
  	//   -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  -  - | yydebug=1;
  	//   -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  -  - | donotgenerate=1;
  	//   -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  -  - | ShowCopyright(); 
  	//   -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  -  - | Usage();
  	//   -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  -  - | checkequal=0;     // Do Not check for '='.
  	//   -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  -  - | strcat(xstring, "- ");
  	//   -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  -  - | DupeActionIsAnError=0;
  	//   -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  -  - | SetLang(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  -  - | SetColumn(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  -  - | m4out=1; pComment=AddPfx(pPrefix,"_COMMENT()");  ;pEcomment="";
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  -  - | SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  -  - | SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  -  - | SetPrefix(argv[narg+1]); narg++;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X  - | usegoto=0;
  	//   -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  -  X | quiet=1;
  	//   -  -  -  X  -  -  X  X  -  -  -  -  -  -  -  -  -  -  - | exit(0); 
  	//END_TABLE:  	
  	//GENERATED_CODE: FOR TABLE_4.
  	//	19 Rules, 18 conditions, and 20 actions.
  	//	Table 4 rule order = 11 1 13 15 9 18 2 12 14 3 17 16 19 4 5 6 7 10 8 
  	 {	unsigned long CCIDE_table4_yes[19]={   1UL,   2UL,   4UL,   8UL,  16UL,  32UL,  64UL, 128UL, 256UL, 512UL,1024UL,2048UL,4096UL,8192UL,16384UL,32768UL,65536UL,131072UL,   0UL};


  		switch(CCIDEFindRuleYes(19,
  			  (Argis(-a)||Argis(--actiondupes))
  			| (Argis(-b)||Argis(--blanktime))<<1
  			| (Argis(-c)||Argis(--columnsize))<<2
  			| (Argis(-d)||Argis(--delimiter))<<3
  			| (Argis(-e)||Argis(--equalok))<<4
  			| (Argis(-g)||Argis(--gotoless))<<5
  			| (Argis(-l)||Argis(--localtime))<<6
  			| (Argis(-L)||Argis(--language))<<7
  			| (Argis(-m4)||Argis(--m4output))<<8
  			| (Argis(-n)||Argis(--noinlinecode))<<9
  			| (Argis(-p)||Argis(--prefix))<<10
  			| (Argis(-q)||Argis(--quote))<<11
  			| (Argis(-k)||Argis(--quiet))<<12
  			| (Argis(-s)||Argis(--skeleton))<<13
  			| (Argis(-t)||Argis(--trace))<<14
  			| (Argis(-u)||Argis(--undo))<<15
  			| (Argis(-V)||Argis(--version))<<16
  			| (Argis(-x)||Argis(--extrarule))<<17
  			  ,CCIDE_table4_yes)) {
  		case 18:	//	Rule  8 
  		    Usage();
  		    exit(0);
  		    break;
  		case 16:	//	Rule  7 
  		    ShowCopyright();
  		    exit(0);
  		    break;
  		case 13:	//	Rule  4 
  		    if(GenSkeleton(argv[narg+1])) narg++;
  		    exit(0);
  		    break;
  		case 12:	//	Rule 19 
  		    quiet=1;
  		    break;
  		case  5:	//	Rule 18 
  		    usegoto=0;
  		    break;
  		case 10:	//	Rule 17 
  		    SetPrefix(argv[narg+1]); narg++;
  		    break;
  		case 11:	//	Rule 16 
  		    SetQdelimit(argv[narg+1],argv[narg+2]); narg+=2;
  		    break;
  		case  3:	//	Rule 15 
  		    SetDelimit(argv[narg+1],argv[narg+2]); narg+=2;
  		    break;
  		case  8:	//	Rule 14 
  		    m4out=1; pComment=AddPfx(pPrefix,"_COMMENT()");  ;pEcomment="";
  		    break;
  		case  2:	//	Rule 13 
  		    SetColumn(argv[narg+1]); narg++;
  		    break;
  		case  7:	//	Rule 12 
  		    SetLang(argv[narg+1]); narg++;
  		    break;
  		case  0:	//	Rule 11 
  		    DupeActionIsAnError=0;
  		    break;
  		case 17:	//	Rule 10 
  		    strcat(xstring, "- ");
  		    break;
  		case  4:	//	Rule  9 
  		    checkequal=0;     // Do Not check for '='.
  		    break;
  		case 15:	//	Rule  6 
  		    noinline=1;
  		    donotgenerate=1;
  		    break;
  		case 14:	//	Rule  5 
  		    yydebug=1;
  		    break;
  		case  9:	//	Rule  3 
  		    noinline=1;
  		    break;
  		case  6:	//	Rule  2 
  		    uselocaltime=1;
  		    break;
  		case  1:	//	Rule  1 
  		    notimestamp=1;
  		    break;
  		} // End Switch
  	}
  	//END_GENERATED_CODE: FOR TABLE_4, by ccide-0.6.4-1 Mon 03 Sep 2012 10:52:33 AM EDT 


	narg++;
    }

	assert(NO>YES); assert(DONT_CARE>YES);
	ctbl[NO-YES]='N'; ctbl[YES-YES]='Y'; 
	ctbl[ACT-YES]='X'; ctbl[DONT_CARE-YES] ='-';
	yyparse();
	return RC;
}

/*--)}------------------------------------------------------------*/
