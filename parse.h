#ifndef PARSE_H
#define PARSE_H

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

/* ccidelex.c */
extern int nbrcstubs;  /* Number of condition stubs */
 
/* ccideparse.c */
extern char bfr[4096];
extern int substitute;
extern int RC;
extern int nactions;
extern int yydebug;
extern int yychar;
extern YYSTYPE yylval;
extern int yynerrs;
extern int yyparse(void);
extern char *progname;
extern int lineno;
extern void warning2(char *s, char *t);
extern int main(int argc, char **argv);

#endif // PARSE_H
