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
#ifndef PARSE__H
#define PARSE__H

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

#endif // PARSE__H
