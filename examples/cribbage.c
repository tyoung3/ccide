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

//The following C program was used to determine the pone/dealer discard decision tables.
// This is a DOS program, intended to be run from a command-line prompt.


// ?? fix kbhit and fmalloc
#define kbhit() 0
#define _fmalloc malloc

// From geocities.com

//[In the HTML source, symbols &quot;, &lt;, &gt;, and &amp; replace ", <, >, and &,
//respectively. Use the copy text (rather than view source) function of your browser to
// extract the source code.]

//----------------------------------------------------------------------------
// DUMP.C determines 91-entry table of dealer/pone average crib scores by
// discard AA-KK and also 1820-entry frequency tables for dealer/pone held
// cards AAAA-KKKK.  Run program with no argument passed for a day or so until
// level 4 stabilizes, then rerun with any passed argument to dump C tables.
//
// Compile/link:  CL DUMP.C  (default small model)
//
// Summary of 6-card hands by rank needed to understand calculations here:
//
//   Types                 Count                 Weight        Total
//   ------                -----                 ------     --------
//   111111    (13 6) * 1 = 1716     4*4*4*4*4*4 = 4096      7028736
//   11112     (13 5) * 5 = 6435     4*4*4*4*6   = 1536      9884160
//   1122      (13 4) * 6 = 4290     4*4*6*6     =  576      2471040
//   1113      (13 4) * 4 = 2860     4*4*4*4     =  256       732160
//   114       (13 3) * 3 =  858     4*4*1       =   16        13728
//   123       (13 3) * 6 = 1716     4*6*4       =   96       164736
//   222       (13 3) * 1 =  286     6*6*6       =  216        61776
//   24        (13 2) * 2 =  156     6*1         =    6          936
//   33        (13 2) * 1 =   78     4*4         =   16         1248
//   15        (13 2) * 2 =  156     4*0         =    0
//   6         (13 1) * 1 =   13     0           =    0
//                         -----                            --------
//                         18564                            20358520 = (52 6)
//
// Similar charts are computed for (51 6), ..., (45 6) possible hands when
// up to 7 specific cards are known to be unavailable.
//
// In the calculations, flushes are ignored and discard decisions are based
// solely on average hand score plus or minus expected crib score.
//
// Program starts with crib tables zeroed.  That is, first pass makes discard
// decisions based only on best hand scores.  Successive iterations use tables
// output from previous iteration.  The tables converge to a point where the
// expected crib average as pone is the same as that expected as dealer (about
// 4.8 points).
//----------------------------------------------------------------------------

#include <stdio.h>
#include <malloc.h>

#ifndef ORIGINAL_CODE
#define far
#endif

#define UCHAR unsigned char
#define UINT  unsigned int
#define ULONG unsigned long

#define LOBYTE(x) ((x) & 0xFF)
#define HIBYTE(x) LOBYTE((x) >> 8)
#define LOWORD(x) ((x) & 0xFFFF)
#define HIWORD(x) LOWORD((x) >> 16)

#define CUT_OFF  400                // determines when levels change
#define DAMP_FAC 0.50               // change dampening factor

char Cards[] = "A23456789TJQK";

int Wgts[]     = {0,0,0,0,0,0,0,0,  // 0 cards available
                  1,1,0,0,0,0,0,0,
                  1,2,1,0,0,0,0,0,
                  1,3,3,1,0,0,0,0,
                  1,4,6,4,1,0,0,0}; // 4 cards available

int QkWts2[] = {0,1,3,6, 10,15, 21, 28, 36, 45, 55,  66,  78};
int QkWts1[] = {0,1,4,10,20,35, 56, 84,120,165,220, 286, 364};
int QkWts0[] = {0,1,5,15,35,70,126,210,330,495,715,1001,1365};

ULONG LevSum[] = {20358520L, 18009460L, 15890700L, 13983816L,
                  12271512L, 10737573L,  9366819L,  8145060L};

int Level = 0,                    // increases to 4 in main()
    Iter = 0,                     // reset each Level then increases
    WantFreq = 0;                 // final flag for LoadTot()

double TotChg = 0, MaxChg = 0,    // set by Eval()
       PnAve = 0, DlAve = 0;      // set by SetAves()

int    Hash[256];                     // hash table for next
ULONG  RankFreq[13];
ULONG  DlHnTot[1820], PnHnTot[1820];  // weighted totals for AAAA-KKKK
ULONG  DlTot[91], PnTot[91];          // weighted totals for AA-KK
double DlTbl[91], PnTbl[91];          // average crib scores for AA-KK
double DlNew[91], PnNew[91];          // new values for previous

UCHAR Pts[23660];  // scores of all 4-card hands plus cut by rank
UINT far *Dscd;    // 18564 discards for all 6-card hands by rank

//----------------------------------------------------------------------------
// Compute tables for use in cribbage discarding decisions.  Tables give
// expected crib scores for each of 91 possible two-card combinations by rank
// (AA-KK) as dealer and as pone.
//----------------------------------------------------------------------------
int main(int Argc, char *Argv[])
  {int n;

   printf("Calculates cribbage discard/frequency tables--\
pass any arg later for C dump\n");

   // allocate far memory for Dscd array
   if ((Dscd = (UINT far *)_fmalloc(sizeof(UINT) * 18564)) == NULL)
     {printf("Not enough memory\n"); exit(1);}

   // one-time load of quarter point scores for all 4-card hands plus cut
   LoadPts();

   // clear state info, but override if load succeeds
   Level = 0; Iter = 0;
   for (n = 0; n < 91; n++) PnTbl[n] = DlTbl[n] = PnNew[n] = DlNew[n] = 0;
   Dump(LoadBin());

   // check for passed arg to dump data and exit
   if (Argc > 1)
     {WantFreq = 1;
      LoadDscd();
      for (n = 0; n < 1820; n++) PnHnTot[n] = DlHnTot[n] = 0L;
      LoadTot(0, 0, 0, 0, 0, 0, 0);
      LastDump();
      exit(0);
     }

   // keypress exits internally
   while (1)
     {LoadDscd();
      EvalAll();
      Dump(UpdtTbls());
      DumpBin();

      if (MaxChg < (double)(CUT_OFF >> Level) / 1000 && Level < 4)
         (++Level, Iter = 0);
      ++Iter;
     }

   return n;
  }

//----------------------------------------------------------------------------
// Dump PnTbl/DlTbl in hex for use in C program.
//----------------------------------------------------------------------------
int LastDump()
  {int n, m;
   UINT u, v, w, x, z;
   char Buf[128];
   ULONG Mx, Fac, PnSum = 0L, DlSum = 0L;
   FILE *fout;

   if ((fout = fopen("DUMP.TXT","a")) == NULL)
     {printf("\nCan't open DUMP.TXT for output\n"); exit(1);}

   // dump to disk and console
   sprintf(Buf,
     "\nCrib averages for discards AA-KK: dealer/pone is hi/lo\n    {\n    ");
   fprintf(fout, Buf); printf(Buf);

   u = 0;
   for (n = 1; n < 14; n++)
     {
      for (m = 1; m <= n; m++)
        {v = (int)(DlTbl[u] * 16 + .5) << 8 |
             (int)(PnTbl[u] * 16 + .5);
         if (m == 11) {fprintf(fout, "\n      "); printf("\n      ");}
         sprintf(Buf, "0x%04X%c", v, u == 90 ? ' ' : ',');
         fprintf(fout, Buf); printf(Buf);
         u++;
        }
      fprintf(fout, "\n    "); printf("\n    ");
     }
   fprintf(fout, "}\n"); printf("}\n");

   // dump to disk and console
   sprintf(Buf,
     "\nCrib averages less 2 in 1/32ths: dealer/pone is hi/lo\n    {\n    ");
   fprintf(fout, Buf); printf(Buf);

   u = 0;
   for (n = 1; n < 14; n++)
     {
      for (m = 1; m <= n; m++)
        {v = (int)(DlTbl[u] * 32 - 64 + .5) << 8 |
             (int)(PnTbl[u] * 32 - 64 + .5);
         if (m == 11) {fprintf(fout, "\n      "); printf("\n      ");}
         sprintf(Buf, "0x%04X%c", v, u == 90 ? ' ' : ',');
         fprintf(fout, Buf); printf(Buf);
         u++;
        }
      fprintf(fout, "\n    "); printf("\n    ");
     }
   fprintf(fout, "}\n"); printf("}\n");

   // dump to disk and console
   sprintf(Buf,
     "\nCrib decimal averages when pone discards AA-KK:\n    {\n    ");
   fprintf(fout, Buf); printf(Buf);

   u = 0;
   for (n = 1; n < 14; n++)
     {
      for (m = 1; m <= n; m++)
        {v = (int)(PnTbl[u] * 100 + .5);
         sprintf(Buf, "%4.2f,", (float)v / 100);
         fprintf(fout, Buf); printf(Buf);
         u++;
        }
      fprintf(fout, "\n    "); printf("\n    ");
     }
   fprintf(fout, "}\n"); printf("}\n");

   // dump to disk and console
   sprintf(Buf,
     "\nCrib decimal averages when dealer discards AA-KK:\n    {\n    ");
   fprintf(fout, Buf); printf(Buf);

   u = 0;
   for (n = 1; n < 14; n++)
     {
      for (m = 1; m <= n; m++)
        {v = (int)(DlTbl[u] * 100 + .5);
         sprintf(Buf, "%4.2f,", (float)v / 100);
         fprintf(fout, Buf); printf(Buf);
         u++;
        }
      fprintf(fout, "\n    "); printf("\n    ");
     }
   fprintf(fout, "}\n"); printf("}\n");

   // scale arrays so max element is FF7F
   Mx = 1L;
   for (n = 0; n < 1820; n++)
     {if (PnHnTot[n] > Mx) Mx = PnHnTot[n];
      if (DlHnTot[n] > Mx) Mx = DlHnTot[n];
     }
   Fac = (ULONG)0xFF800000 / Mx;
   for (n = 0; n < 1820; n++)
     {z = HIWORD(PnHnTot[n] * Fac);
      PnSum += z;
      PnHnTot[n] = z;
      z = HIWORD(DlHnTot[n] * Fac);
      DlSum += z;
      DlHnTot[n] = z;
     }

   sprintf(Buf, "\nMaximum and scale factor: 0x%lX 0x%lX\n", Mx, Fac);
   fprintf(fout, Buf); printf(Buf);

   sprintf(Buf,
     "\nPone frequency for held AAAA-KKKK: Sum = 0x%lX\n    {\n    ", PnSum);
   fprintf(fout, Buf); printf(Buf);

   for (n = 0; n < 1820; n++)
     {z = PnHnTot[n];
      sprintf(Buf, "0x%04X%c", z, n == 1819 ? ' ' : ',');
      fprintf(fout, Buf); printf(Buf);
      if ((n+1) % 10 == 0) (fprintf(fout, "\n    "), printf("\n    "));
     }
   fprintf(fout, "}\n"); printf("}\n");

   // count and display pone frequencies
   for (n = 0; n < 256; n++) Hash[n] = 0;
   for (n = 0; n < 1820; n++)
     {z = PnHnTot[n];
      z = HIBYTE(z) + ((z & 0x80) ? 1 : 0);
      ++Hash[z];
     }
   sprintf(Buf, "\nPone frequency distribution rounded hi bytes (0-255):\n");
   fprintf(fout, Buf); printf(Buf);
   n = m = z = 0;
   for (u = 0; u < 16; u++)
     {for (v = 0; v < 16; v++)
        {sprintf(Buf, "%3d ", Hash[n]);
         fprintf(fout, Buf); printf(Buf);
         m += Hash[n]; z += n*Hash[n]; n++;
        }
      sprintf(Buf, " %4d %5d\n", m, z);
      fprintf(fout, Buf); printf(Buf);
     }

   // find percentage hands containing specific ranks
   sprintf(Buf, "\nPercent pone hands containing each rank:\n");
   fprintf(fout, Buf); printf(Buf);

   for (n = 0; n < 13; n++) RankFreq[n] = 0L;

   n = 0;
   for (u = 1; u < 14; u++)
   for (v = 1; v <= u;  v++)
   for (w = 1; w <= v;  w++)
   for (x = 1; x <= w;  x++)
     {z = PnHnTot[n];
      for (m = 1; m < 14; m++)
        if (m == u || m == v || m == w || m == x) RankFreq[m-1] += z;
      n++;
     }

   for (n = 0; n < 13; n++)
     {z = 1000 * RankFreq[n] / PnSum;
      sprintf(Buf, "%4.1f ", (float)z/10);
      fprintf(fout, Buf); printf(Buf);
     }
   fprintf(fout, "\n"); printf("\n");

   sprintf(Buf, "\nPone 3-card combos with 4 or fewer non-zero weight 4th cards:\n");
   fprintf(fout, Buf); printf(Buf);

   n = 0;
   for (u = 1; u < 14; u++)
   for (v = 1; v <= u;  v++)
   for (w = 1; w <= v;  w++)
     {z = Count(PnHnTot, u, v, w);
      if (z != 0xFFFF)
        {sprintf(Buf, "%1X%1X%1X-%4X ", u,v,w,z);
         fprintf(fout, Buf); printf(Buf);
         if ((++n) % 8 == 0) (fprintf(fout, "\n"), printf("\n"));
        }
     }
   fprintf(fout, "\n"); printf("\n");

   // prepare for sort by putting value high and hand low
   n = 0;
   for (u = 1; u < 14; u++)
   for (v = 1; v <= u;  v++)
   for (w = 1; w <= v;  w++)
   for (x = 1; x <= w;  x++)
     {PnHnTot[n] = PnHnTot[n] << 16 | u << 12 | v << 8 | w << 4 | x;
      n++;
     }
   Sort(PnHnTot, 1820);

   sprintf(Buf, "\nPone hands sorted by frequency:\n    {\n    ");
   fprintf(fout, Buf); printf(Buf);

   for (n = 0; n < 1820; n++)
     {z = LOWORD(PnHnTot[n]);
      sprintf(Buf, "0x%04X%c", z, n == 1819 ? ' ' : ',');
      fprintf(fout, Buf); printf(Buf);
      if ((n+1) % 10 == 0) (fprintf(fout, "\n    "), printf("\n    "));
     }
   fprintf(fout, "}\n"); printf("}\n");

   sprintf(Buf,
     "\nDealer frequency for held AAAA-KKKK: Sum = 0x%lX\n    {\n    ", DlSum);
   fprintf(fout, Buf); printf(Buf);

   for (n = 0; n < 1820; n++)
     {z = DlHnTot[n];
      sprintf(Buf, "0x%04X%c", z, n == 1819 ? ' ' : ',');
      fprintf(fout, Buf); printf(Buf);
      if ((n+1) % 10 == 0) (fprintf(fout, "\n    "), printf("\n    "));
     }
   fprintf(fout, "}\n"); printf("}\n");

   // count and display dealer frequencies
   for (n = 0; n < 256; n++) Hash[n] = 0;
   for (n = 0; n < 1820; n++)
     {z = DlHnTot[n];
      z = HIBYTE(z) + ((z & 0x80) ? 1 : 0);
      ++Hash[z];
     }
   sprintf(Buf, "\nDealer frequency distribution rounded hi bytes (0-255):\n");
   fprintf(fout, Buf); printf(Buf);
   n = m = z = 0;
   for (u = 0; u < 16; u++)
   for (u = 0; u < 16; u++)
     {for (v = 0; v < 16; v++)
        {sprintf(Buf, "%3d ", Hash[n]);
         fprintf(fout, Buf); printf(Buf);
         m += Hash[n]; z += n*Hash[n]; n++;
        }
      sprintf(Buf, " %4d %5d\n", m, z);
      fprintf(fout, Buf); printf(Buf);
     }

   // find percentage hands containing specific ranks
   sprintf(Buf, "\nPercent dealer hands containing each rank:\n");
   fprintf(fout, Buf); printf(Buf);

   for (n = 0; n < 13; n++) RankFreq[n] = 0L;

   n = 0;
   for (u = 1; u < 14; u++)
   for (v = 1; v <= u;  v++)
   for (w = 1; w <= v;  w++)
   for (x = 1; x <= w;  x++)
     {z = DlHnTot[n];
      for (m = 1; m < 14; m++)
        if (m == u || m == v || m == w || m == x) RankFreq[m-1] += z;
      n++;
     }

   for (n = 0; n < 13; n++)
     {z = 1000 * RankFreq[n] / DlSum;
      sprintf(Buf, "%4.1f ", (float)z/10);
      fprintf(fout, Buf); printf(Buf);
     }
   fprintf(fout, "\n"); printf("\n");

   sprintf(Buf, "\nDealer 3-card combos with 4 or fewer non-zero weight 4th cards:\n");
   fprintf(fout, Buf); printf(Buf);

   n = 0;
   for (u = 1; u < 14; u++)
   for (v = 1; v <= u;  v++)
   for (w = 1; w <= v;  w++)
     {z = Count(DlHnTot, u, v, w);
      if (z != 0xFFFF)
        {sprintf(Buf, "%1X%1X%1X-%4X ", u,v,w,z);
         fprintf(fout, Buf); printf(Buf);
         if ((++n) % 8 == 0) (fprintf(fout, "\n"), printf("\n"));
        }
     }
   fprintf(fout, "\n"); printf("\n");

   // prepare for sort by putting value high and hand low
   n = 0;
   for (u = 1; u < 14; u++)
   for (v = 1; v <= u;  v++)
   for (w = 1; w <= v;  w++)
   for (x = 1; x <= w;  x++)
     {DlHnTot[n] = DlHnTot[n] << 16 | u << 12 | v << 8 | w << 4 | x;
      n++;
     }
   Sort(DlHnTot, 1820);

   sprintf(Buf, "\nDealer hands sorted by frequency:\n    {\n    ");
   fprintf(fout, Buf); printf(Buf);

   for (n = 0; n < 1820; n++)
     {z = LOWORD(DlHnTot[n]);
      sprintf(Buf, "0x%04X%c", z, n == 1819 ? ' ' : ',');
      fprintf(fout, Buf); printf(Buf);
      if ((n+1) % 10 == 0) (fprintf(fout, "\n    "), printf("\n    "));
     }
   fprintf(fout, "}\n"); printf("}\n");

   fclose(fout);

   return 0;
  }

//----------------------------------------------------------------------------
// Sort double word array highest to lowest in high word, but lowest to
// highest in low word.
//----------------------------------------------------------------------------
int Sort(ULONG Ary[], int Length)
  {int n, m;
   ULONG Temp;

   for (n = 0; n < Length-1; n++)
   for (m = n+1; m < Length; m++)
   if (HIWORD(Ary[n]) < HIWORD(Ary[m]) ||
      (HIWORD(Ary[n]) == HIWORD(Ary[m]) && LOWORD(Ary[n]) > LOWORD(Ary[m])))
     {Temp = Ary[n]; Ary[n] = Ary[m]; Ary[m] = Temp;
     }

   return 0;
  }

//----------------------------------------------------------------------------
// Count ranks (of 13) that would fill out hand with non-zero frequency.
// Assume r1 >= r2 >= r3.
//----------------------------------------------------------------------------
int Count(ULONG Ary[], int r1, int r2, int r3)
  {int n, Cnt = 0, Ndx, Ranks = 0;

   for (n = 1; n < 14; n++)
     {if      (n >= r1) Ndx = QkWts0[ n-1]+QkWts1[r1-1]+QkWts2[r2-1]+r3-1;
      else if (n >= r2) Ndx = QkWts0[r1-1]+QkWts1[ n-1]+QkWts2[r2-1]+r3-1;
      else if (n >= r3) Ndx = QkWts0[r1-1]+QkWts1[r2-1]+QkWts2[ n-1]+r3-1;
      else              Ndx = QkWts0[r1-1]+QkWts1[r2-1]+QkWts2[r3-1]+ n-1;
      if (Ary[Ndx]) (++Cnt, Ranks = Ranks << 4 | n);
     }

   return Cnt > 4 ? -1 : Ranks;
  }

//----------------------------------------------------------------------------
// Load DlTbl/PnTbl arrays from binary file.
//----------------------------------------------------------------------------
int LoadBin()
  {FILE *fin;

   if ((fin = fopen("DUMP.BIN","rb")) == NULL)
     {printf("Can't open DUMP.BIN for input--using startup defaults\n");
      return -2;
     }

   fread(&Level, sizeof(int),     1, fin);
   fread(&Iter,  sizeof(int),     1, fin);
   fread(DlTbl,  sizeof(double), 91, fin);
   fread(PnTbl,  sizeof(double), 91, fin);
   fread(DlNew,  sizeof(double), 91, fin);
   fread(PnNew,  sizeof(double), 91, fin);

   fclose(fin);
   return -1;
  }

//----------------------------------------------------------------------------
// Dump state to disk as binary output.
//----------------------------------------------------------------------------
int DumpBin()
  {FILE *fout;

   if ((fout = fopen("DUMP.BIN","wb")) == NULL)
     {printf("\nCan't open DUMP.BIN for output\n"); exit(1);}

   fwrite(&Level, sizeof(int),     1, fout);
   fwrite(&Iter,  sizeof(int),     1, fout);
   fwrite(DlTbl,  sizeof(double), 91, fout);
   fwrite(PnTbl,  sizeof(double), 91, fout);
   fwrite(DlNew,  sizeof(double), 91, fout);
   fwrite(PnNew,  sizeof(double), 91, fout);

   fclose(fout);
   return 0;
  }

//----------------------------------------------------------------------------
// Load Pts array with scores of all 4-card hands plus cuts.  Called once.
//----------------------------------------------------------------------------
int LoadPts()
  {int u, v, w, x, y, n = 0;
   char Hn[5];

   // illegal hands (5-of-a-kind) are ignored later
   for (u = 1; (Hn[0] = u) < 14; u++)
   for (v = 1; (Hn[1] = v) <= u; v++)
   for (w = 1; (Hn[2] = w) <= v; w++)
   for (x = 1; (Hn[3] = x) <= w; x++)
   for (y = 1; (Hn[4] = y) < 14; y++)
     {Pts[n] = Score5(Hn);
      if (Pts[n] != Quick5(Hn)) {printf("LoadPts error\n"); exit(1);}
      ++n;
     }
   if (n != 23660) {printf("LoadPts index error: %d\n", n); exit(1);}
   return n;
  }

//----------------------------------------------------------------------------
// Dump PnTbl/DlTbl rounded to 1/1000ths to log and console.
//----------------------------------------------------------------------------
int Dump(int DispChg)
  {int u, v, n, m;
   char Buf[128];
   FILE *fout;

   if ((fout = fopen("DUMP.TXT","a")) == NULL)
     {printf("\nCan't open DUMP.TXT for output\n"); exit(1);}

   // dump to disk and console
   if (DispChg < 0)
     {sprintf(Buf, "\nLevel: %d  Iter: %d  %s...\n",
         Level, Iter, DispChg == -2 ? "Start" : "Restart");
      fprintf(fout, Buf); printf(Buf);
     }
   else
     {sprintf(Buf,
        "\nLevel: %d  Iter: %d  TotChg: %.2f  MaxChg: %.2f  DispChg: %d\n",
          Level, Iter, TotChg * 1000, MaxChg * 1000, DispChg);
      fprintf(fout, Buf); printf(Buf);
      sprintf(Buf,"PnAve: %.5f  DlAve: %.5f\n", PnAve, DlAve);
      fprintf(fout, Buf); printf(Buf);
     }

   u = 0; v = 90;
   for (n = 1; n < 14; n++)
     {
      for (m = 1; m <= n; m++)
        {sprintf(Buf, "%04d ", (int)(DlTbl[u++] * 1000 + .5));
         fprintf(fout, Buf); printf(Buf);
        }
      fprintf(fout, "     "); printf("     ");
      for (m = 14 - n; m; m--)
        {sprintf(Buf, "%04d ", (int)(PnTbl[v--] * 1000 + .5));
         fprintf(fout, Buf); printf(Buf);
        }
      fprintf(fout, "\n"); printf("\n");
     }

   fclose(fout);

   return 0;
  }

//----------------------------------------------------------------------------
// Update PnTbl/DlTbl from PnNew/DlNew and return count of display changes.
//----------------------------------------------------------------------------
int UpdtTbls()
  {int n, DispChg = 0;

   for (n = 0; n < 91; n++)
     {
      // update DispChg to count display changes--see Dump()
      if ((int)(PnTbl[n] * 1000 + .5) != (int)(PnNew[n] * 1000 + .5)) ++DispChg;
      if ((int)(DlTbl[n] * 1000 + .5) != (int)(DlNew[n] * 1000 + .5)) ++DispChg;

      PnTbl[n] = PnNew[n];
      DlTbl[n] = DlNew[n];
      PnNew[n] = DlNew[n] = 0;
     }

   UpdtAves();
   return DispChg;
  }

//----------------------------------------------------------------------------
// Update global averages.
//----------------------------------------------------------------------------
int UpdtAves()
  {int n;

   // reload totals
   LoadTot(0, 0, 0, 0, 0, 0, 0);

   PnAve = DlAve = 0;
   for (n = 0; n < 91; n++)
     {PnAve += PnTbl[n] * DlTot[n];
      DlAve += DlTbl[n] * PnTot[n];
     }
   PnAve /= LevSum[0];
   DlAve /= LevSum[0];

   return 1;
  }

//----------------------------------------------------------------------------
// Return quarter point score of 4-card hand plus cut from pre-computed array.
// This is about 3x faster than Score5.
//----------------------------------------------------------------------------
int Quick5(char Hand[])
  {int n, m;
   char Hn[5], Card;

   // copy hand then sort first four cards
   for (n = 0; n < 5; n++) Hn[n] = Hand[n] - 1;
   for (n = 0; n < 3; n++) for (m = n+1; m < 4; m++)
      if (Hn[n] < Hn[m]) (Card = Hn[n], Hn[n] = Hn[m], Hn[m] = Card);

   // construct index into pre-computed array using fixed weights
   n = 13 * (QkWts0[Hn[0]] + QkWts1[Hn[1]] + QkWts2[Hn[2]] + Hn[3]) + Hn[4];

   if (n < 0 || n >= 23660) {printf("Quick5 index error\n"); exit(1);}
   return Pts[n];
  }

//----------------------------------------------------------------------------
// From 6 ranks sorted high to low and discard index 0-90, return corresponding
// 4-card index 0-1819.  Called only by final hand frequency dump.
//----------------------------------------------------------------------------
int GetNdx4(int Cd1, int Cd2, int Cd3, int Cd4, int Cd5, int Cd6, int Ndx)
  {int n, m, Hi, Lo;
   char Hn[6], Cd[4];

   // copy sorted cards to array, one-based
   Hn[0] = Cd1; Hn[1] = Cd2; Hn[2] = Cd3;
   Hn[3] = Cd4; Hn[4] = Cd5; Hn[5] = Cd6;

   // convert discard index to Hi/Lo cards, one-based
   for (Hi = 12; Hi >= 0; Hi--) if ((Lo = Ndx - QkWts2[Hi]) >= 0) break;
   ++Hi; ++Lo;

   if (Hi < 1 || Hi > 13 || Lo < 1 || Lo > 13 || Hi < Lo)
        {printf("GetNdx4 hi/lo error\n"); exit(1);}

   // kill Hi/Lo cards in array on first pass
   for (n = 0; n < 6; n++)
     {if (Hi == Hn[n]) Hi = Hn[n] = 0;
      if (Lo == Hn[n]) Lo = Hn[n] = 0;
     }

   // copy held 4 cards, zero-based
   m = 0;
   for (n = 0; n < 6; n++) if (Hn[n]) Cd[m++] = Hn[n] - 1;

   // construct index from four cards
   n = QkWts0[Cd[0]] + QkWts1[Cd[1]] + QkWts2[Cd[2]] + Cd[3];

   if (n < 0 || n >= 1820 || m != 4) {printf("GetNdx4 index error\n"); exit(1);}
   return n;
  }

//----------------------------------------------------------------------------
// Evaluate discards from all 6-card hands and save to Dscd array.
//----------------------------------------------------------------------------
int LoadDscd()
  {int u, v, w, x, y, z, n = 0, Ties = 0, Matches = 0;
   char Hn[6];

   // illegal hands (5-and 6-of-a-kind) are ignored later
   for (u = 1; (Hn[0] = u, u < 14); u++)
   for (v = 1; (Hn[1] = v, v <= u); v++)
   for (w = 1; (Hn[2] = w, w <= v); w++)
   for (x = 1; (Hn[3] = x, x <= w); x++)
   for (y = 1; (Hn[4] = y, y <= x); y++)
   for (z = 1; (Hn[5] = z, z <= y); z++)
     {Dscd[n] = PickDis(Hn, &Ties, &Matches);
      if (n % 1000 == 0) {printf("\rLoadDscd: %d", n); if (kbhit()) exit(0);}
      ++n;
     }
   printf("\rLoadDscd: %d  Matches: %d  Ties: %d\n", n, Matches, Ties);

   if (n != 18564) {printf("LoadDscd index error: %d\n", n); exit(1);}
   return Ties;
  }

//----------------------------------------------------------------------------
// Load PnTot/DlTot arrays with weights for discards to all 6-card hands out
// 52-card deck with up to 7 cards missing.  Supply dummy 0's as needed.
// This is innermost routine at level 4.
//----------------------------------------------------------------------------
int LoadTot(int Cd1, int Cd2, int Cd3, int Cd4, int Cd5, int Cd6, int Cd7)
  {int u, v, w, x, y, z, n, Wt, Ndx = 0, k = 0, Missing = 0, Ct[6], WtRow[16];
   long Sum = 0L;

   // clear sum arrays and initialize weight counts
   for (n = 0; n < 91; n++) DlTot[n] = PnTot[n] = 0L;
   for (n = 1; n < 14; n++) WtRow[n] = 33;
   for (n = 0; n < 6; n++)  Ct[n] = 32;

   if (Cd1) {++Missing; if (WtRow[Cd1] > 1) WtRow[Cd1] -= 8;};
   if (Cd2) {++Missing; if (WtRow[Cd2] > 1) WtRow[Cd2] -= 8;};
   if (Cd3) {++Missing; if (WtRow[Cd3] > 1) WtRow[Cd3] -= 8;};
   if (Cd4) {++Missing; if (WtRow[Cd4] > 1) WtRow[Cd4] -= 8;};
   if (Cd5) {++Missing; if (WtRow[Cd5] > 1) WtRow[Cd5] -= 8;};
   if (Cd6) {++Missing; if (WtRow[Cd6] > 1) WtRow[Cd6] -= 8;};
   if (Cd7) {++Missing; if (WtRow[Cd7] > 1) WtRow[Cd7] -= 8;};

   // update sum arrays
   for (u = 1; u < 14 ?          (Ct[k]   = WtRow[u])            | 1 : 0;
        u++)
   for (v = 1; v <= u ? (v < u ? (Ct[++k] = WtRow[v]) : ++Ct[k]) | 1 : 0;
        v++ < u ? (Ct[k--] = 32) : --Ct[k])
   for (w = 1; w <= v ? (w < v ? (Ct[++k] = WtRow[w]) : ++Ct[k]) | 1 : 0;
        w++ < v ? (Ct[k--] = 32) : --Ct[k])
   for (x = 1; x <= w ? (x < w ? (Ct[++k] = WtRow[x]) : ++Ct[k]) | 1 : 0;
        x++ < w ? (Ct[k--] = 32) : --Ct[k])
   for (y = 1; y <= x ? (y < x ? (Ct[++k] = WtRow[y]) : ++Ct[k]) | 1 : 0;
        y++ < x ? (Ct[k--] = 32) : --Ct[k])
   for (z = 1; z <= y ? (z < y ? (Ct[++k] = WtRow[z]) : ++Ct[k]) | 1 : 0;
        z++ < y ? (Ct[k--] = 32) : --Ct[k])
     {
      // weight is zero for illegal hands--also Wgts[32] is 1
      Wt = Wgts[Ct[0]] * Wgts[Ct[1]] * Wgts[Ct[2]] *
           Wgts[Ct[3]] * Wgts[Ct[4]] * Wgts[Ct[5]];

      // bump pone and dealer totals by weights
      n = Dscd[Ndx];
      PnTot[HIBYTE(n)] += Wt;
      DlTot[LOBYTE(n)] += Wt;
      if (WantFreq)  // late patch to get final hand frequencies
        {PnHnTot[GetNdx4(u, v, w, x, y, z, LOBYTE(n))] += Wt;
         DlHnTot[GetNdx4(u, v, w, x, y, z, HIBYTE(n))] += Wt;
        }
      Sum += Wt;
      ++Ndx;
     }

   if (Ndx != 18564) {printf("LoadTot Ndx error\n"); exit(1);}
   if (Sum != LevSum[Missing]) {printf("LoadTot Sum error\n"), exit(1);}

   return Ndx;
  }

//----------------------------------------------------------------------------
// Set all 91 PnNew/DlNew entries, updating global MaxChg/TotChg.  Note that
// at level 4, there will be about 28,500 LoadTot() calls inside LongEval().
// Could reduce to about 18,500 by doing all 91 evaluations in one pass.
//----------------------------------------------------------------------------
int EvalAll()
  {int u, v, n = 0;
   double Diff;

   MaxChg = TotChg = 0;

   // initial trial uses same PnTot/DlTot for all 91 evaluations
   if (Level == 0) LoadTot(0, 0, 0, 0, 0, 0, 0);
   for (u = 1; u < 14; u++)
     {if (Level == 1) LoadTot(u, 0, 0, 0, 0, 0, 0);
      for (v = 1; v <= u; v++)
        {if (Level == 2) LoadTot(u, v, 0, 0, 0, 0, 0);

         // evaluate then halve change to dampen oscillation afterward
         if (PnNew[n] == 0 && DlNew[n] == 0)
           {if (Level < 4) Eval(u, v, n);
            else           LongEval(u, v, n);

            PnNew[n] = PnTbl[n] + DAMP_FAC * (PnNew[n] - PnTbl[n]);
            DlNew[n] = DlTbl[n] + DAMP_FAC * (DlNew[n] - DlTbl[n]);
            if (Level > 3) DumpBin();
           }

         // update global MaxChg and TotChg
         Diff = PnNew[n] - PnTbl[n];
         if (Diff < 0) Diff = -Diff;
         TotChg += Diff;
         if (Diff > MaxChg) MaxChg = Diff;

         Diff = DlNew[n] - DlTbl[n];
         if (Diff < 0) Diff = -Diff;
         TotChg += Diff;
         if (Diff > MaxChg) MaxChg = Diff;

         printf(
 "\rNdx: %02d  Cds: %c%c  Dl: %.3f  Pn: %.3f  TotChg: %.2f  MaxChg: %.2f",
 n, Cards[u-1], Cards[v-1], DlNew[n], PnNew[n], TotChg * 1000, MaxChg * 1000);
         if (Level > 3) printf("\n");
         ++n;         if (kbhit()) exit(0);
        }
     }

   printf("\n");
   return 0;
  }

//----------------------------------------------------------------------------
// Set one PnNew/DlNew entry.
//----------------------------------------------------------------------------
int Eval(int Rank1, int Rank2, int Ndx)
  {int u, v, n, Cut, Wt;
   ULONG  DlSum, PnSum;
   double DlSm,  PnSm;
   char Hn[5];

   DlSm = PnSm = 0;
   Hn[2] = Rank1; Hn[3] = Rank2;
   for (Cut = 1; (Hn[4] = Cut, Cut < 14); Cut++)
     {
      // Level 3 uses 13 refined PnTot/DlTot for each evaluation
      if (Level == 3) LoadTot(Rank1, Rank2, Cut, 0, 0, 0, 0);

      DlSum = PnSum = 0L;
      n = 0;
      for (u = 1; (Hn[0] = u, u < 14); u++)
      for (v = 1; (Hn[1] = v, v <= u); v++)
        {Wt  = Quick5(Hn);
         PnSum += PnTot[n] * Wt;
         DlSum += DlTot[n] * Wt;
         ++n;
        }

      // PnSum and DlSum can reach billion, so switch to double
      Wt = 4 - (Cut == Rank1 ? 1 : 0) - (Cut == Rank2 ? 1 : 0);
      PnSm += (double)PnSum * Wt;
      DlSm += (double)DlSum * Wt;
     }

   // 50 is 52 cards less the 2 being evaluated
   PnNew[Ndx] = PnSm / 4 / (50 * LevSum[Level]);
   DlNew[Ndx] = DlSm / 4 / (50 * LevSum[Level]);

   return 0;
  }

//----------------------------------------------------------------------------
// Set one PnNew/DlNew entry--lengthy evaluation.
//----------------------------------------------------------------------------
int LongEval(int Rank1, int Rank2, int Ndx)
  {int u, v, w, x, y, z, n, Wt, m = 0, k = 0, Ct[6], PnMatch, DlMatch,
       Cut, i, j, t, QtWt, CutWt, PnCnt = 0, DlCnt = 0, OrCnt = 0;
   char Hn[5];
   ULONG PnWtSum = 0L, DlWtSum = 0L, DlSum, PnSum;
   double PnValSum = 0L, DlValSum = 0L, PnSm, DlSm;

   // initialize weight counts
   for (n = 0; n < 6; n++)  Ct[n] = 32;

   // update sum arrays
   for (u = 1; u < 14 ?          (Ct[k]   = 33)            | 1 : 0;
        u++)
   for (v = 1; v <= u ? (v < u ? (Ct[++k] = 33) : ++Ct[k]) | 1 : 0;
        v++ < u ? (Ct[k--] = 32) : --Ct[k])
   for (w = 1; w <= v ? (w < v ? (Ct[++k] = 33) : ++Ct[k]) | 1 : 0;
        w++ < v ? (Ct[k--] = 32) : --Ct[k])
   for (x = 1; x <= w ? (x < w ? (Ct[++k] = 33) : ++Ct[k]) | 1 : 0;
        x++ < w ? (Ct[k--] = 32) : --Ct[k])
   for (y = 1; y <= x ? (y < x ? (Ct[++k] = 33) : ++Ct[k]) | 1 : 0;
        y++ < x ? (Ct[k--] = 32) : --Ct[k])
   for (z = 1; z <= y ? (z < y ? (Ct[++k] = 33) : ++Ct[k]) | 1 : 0;
        z++ < y ? (Ct[k--] = 32) : --Ct[k])
     {
      // weight is zero for illegal hands--also Wgts[32] is 1
      Wt = Wgts[Ct[0]] * Wgts[Ct[1]] * Wgts[Ct[2]] *
           Wgts[Ct[3]] * Wgts[Ct[4]] * Wgts[Ct[5]];

      n = Dscd[m];
      DlMatch = (HIBYTE(n) == Ndx); PnMatch = (LOBYTE(n) == Ndx);

      if ((DlMatch || PnMatch) && Wt > 0)
        {
         DlSm = PnSm = 0;
         Hn[2] = Rank1; Hn[3] = Rank2;
         for (Cut = 1; (Hn[4] = Cut, Cut < 14); Cut++)
           {
            CutWt = 4 - (Cut == u ? 1 : 0) - (Cut == v ? 1 : 0)
                      - (Cut == w ? 1 : 0) - (Cut == x ? 1 : 0)
                      - (Cut == y ? 1 : 0) - (Cut == z ? 1 : 0);
            if (CutWt > 0)
              {LoadTot(u, v, w, x, y, z, Cut);

               DlSum = PnSum = 0L;
               t = 0;
               for (i = 1; (Hn[0] = i, i < 14); i++)
               for (j = 1; (Hn[1] = j, j <= i); j++)
                 {QtWt  = Quick5(Hn);
                  if (PnMatch) PnSum += PnTot[t] * QtWt;
                  if (DlMatch) DlSum += DlTot[t] * QtWt;
                  ++t;
                 }

               // PnSum and DlSum can get large, so switch to double
               if (PnMatch) PnSm += (double)PnSum * CutWt;
               if (DlMatch) DlSm += (double)DlSum * CutWt;
              }
           }

         // 46 is 52 cards less the 6 missing cards
         if (PnMatch)
           {PnSm = PnSm / 4 / (46 * LevSum[7]);
            PnValSum += PnSm * Wt;
            PnWtSum  += Wt;
            ++PnCnt;
           }
         if (DlMatch)
           {DlSm = DlSm / 4 / (46 * LevSum[7]);
            DlValSum += DlSm * Wt;
            DlWtSum  += Wt;
            ++DlCnt;
           }
         ++OrCnt;

         printf(
"\rNdx: %02d  Dscd: %c%c  Cards: %c%c%c%c%c%c  DlCnt: %d  PnCnt: %d  OrCnt: %d",
      Ndx, Cards[Rank1-1], Cards[Rank2-1],
      Cards[u-1], Cards[v-1], Cards[w-1], Cards[x-1], Cards[y-1], Cards[z-1],
      DlCnt, PnCnt, OrCnt);

         if (kbhit()) exit(0);
        }
      ++m;
     }

   PnNew[Ndx] = PnValSum / PnWtSum;
   DlNew[Ndx] = DlValSum / DlWtSum;

   if (m != 18564) {printf("LongEval index error\n"); exit(1);}

   return m;
  }

//----------------------------------------------------------------------------
// Return quarter point score of 5-card hand by rank.  Flushes ignored.
//----------------------------------------------------------------------------
int Score5(char Hand[])
  {int  n, m, Sum = 0, Tot = 0;
   char Cnt[16];

   // check 15-counts
   for (n = 0; n < 5; n++)
      Sum += Cnt[n] = (m = Hand[n] & 0x0F) < 10 ? m : 10;

   if (Sum == 15) Tot += 2;
   for (n = 0; n < 5; n++)
     {if (Sum - Cnt[n] == 15) Tot += 2;
      for (m = n+1; m < 5; m++)
        {if (Cnt[n] + Cnt[m] == 15) Tot += 2;
         if (Sum - Cnt[n] - Cnt[m] == 15) Tot += 2;
        }
      }

   // check pairs/trips/quads
   for (n = 0; n < 14; n++) Cnt[n] = 0;
   for (n = 0; n < 5; n++) Tot += Cnt[Hand[n] & 0x0F]++ << 1;

   // check runs
   Sum = 0; m = 1;
   for (n = 1; n < 14; n++)
     {if (Cnt[n]) (++Sum, m *= Cnt[n]);
      else if (Sum < 3) (Sum = 0, m = 1);
      else break;
     }
   if (Sum >= 3) Tot += Sum * m;

   // convert to quarter points with nobs adjustment
   Tot = (Tot << 2) + (((Hand[4] & 0x0F) == 11) ? 0 : Cnt[11]);

   // return Tot unless bad hand (5-of-a-kind)
   return Cnt[Hand[0] & 0x0F] == 5 ? 0 : Tot;
  }

//----------------------------------------------------------------------------
// Return quarter point total for first 4 of 6 cards over 46 cuts.  Illegal
// hands have more than 46 cuts, but are ignored later.
//----------------------------------------------------------------------------
int Score4(char Hand[])
  {int  n, Tot = 0, Wt[16];
   char Hn[5];

   // make temp copy of first 4 cards
   for (n = 0; n < 4; n++) Hn[n] = Hand[n];

   // count outstanding cards to Wt[] array
   for (n = 1; n < 14; n++) Wt[n] = 4;
   for (n = 0; n < 6; n++) --Wt[Hand[n] & 0x0F];

   // evaluate 13 ranks as cuts, weighed by Wt[]
   for (n = 1; (Hn[4] = n, n < 14); n++)
     if (Wt[n] > 0) Tot += Wt[n] * Quick5(Hn);

   return Tot;
  }

//----------------------------------------------------------------------------
// From 6-card hand, return dealer/pone discards in hi/lo bytes of return word.
// Discards are indexes 0 - 90.  Assume hand sorted high to low.
//----------------------------------------------------------------------------
int PickDis(char Hand[], int *Ties, int *Matches)
  {int n, m, k, DlPicks = 0, PnPicks = 0;
   double HnAve, DlComb, PnComb, DlMxAve = -128, PnMxAve = -128;
   char Hn[6];

   // loop through 15 possible hands, ignoring repetitions
   for (n = 0; n < 5; n++)   if (n == 0   || Hand[n] != Hand[n-1])
   for (m = n+1; m < 6; m++) if (m == n+1 || Hand[m] != Hand[m-1])
     {
      // copy hand, then swap discards to end positions
      for (k = 0; k < 6; k++) Hn[k] = Hand[k];
      k = Hn[m]; Hn[m] = Hn[5]; Hn[5] = k;
      k = Hn[n]; Hn[n] = Hn[4]; Hn[4] = k;

      // get discard index 0-90 from ranks 1-13
      k = ((k * (k - 1)) >> 1) + Hn[5] - 1;

      // get hand average from quarter point total for 46 cuts
      HnAve = Score4(Hn);
      HnAve /= (4 * 46);

      // get combined scores for normal evaluation at neutral risk
      DlComb = HnAve + DlTbl[k];
      PnComb = HnAve - PnTbl[k];

      // on ties, higher rank cards discarded since Hn[] sorted, but
      // due to double precision, ties only arise on first iteration
      if      (DlComb > DlMxAve) (DlMxAve = DlComb, DlPicks = k);
      else if (DlComb == DlMxAve) ++(*Ties);
      if      (PnComb > PnMxAve) (PnMxAve = PnComb, PnPicks = k);
      else if (PnComb == PnMxAve) ++(*Ties);
     }

   if (DlPicks == PnPicks) ++(*Matches);

   // pack indexes into return value
   return DlPicks << 8 | PnPicks;
  }

// End cribbage.c  (was DUMP.C)
