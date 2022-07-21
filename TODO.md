# CCIDE TODO:
 * The config.sub and other such infrastructure files are stale. Get the latest versions.
 * Fix ../check.sh errors to work on mingw.
 * Make RPM depend on gettext if, and only if, so configured.
 * Fix ccide.spec file for gettext.
 * Add .po files to rpm 
   * Issue: rsync -Lrtvz  translationproject.org::tp/latest/ccide/  po   
			for new dist.
   * Add translations from Translation Project
 * Change from man page to info. 
 * Web pages to http://www.gnu.org/software/ccide
 * Expand/test  > 32 conditions/table w/test case(s).
 * Create maintainence guidelines.make 
 * Fix mingw link.
 * See:  http://www.gnu.org/software/gettext/FAQ.html#integrating_undefined
 * Internationalize ccide script or (better) issue ccidew messages from the script.
 * Windows/mingw/cygwin.
    * Create ccide[.BAT] file for Windows.
    * ZIP file for Windows.  -- 'make dist-zip'
    * Fix ex1.bash test case.
 * Additional programming languages
    * Javascript
    * Ruby
    * PHP
    * Perl
    * Python
    * RUST
 * Fix lexer for variable string for comments.
 * Tutorial on adding a new programming language
    * Language requirements
    * M4 requirements
    * Creating test case(s).
 * Additional program checks.  Increase testing coverage.
    * If the corresponding compiler is present
		   otherwise issue a compiler missing warning.
 * Implement extended tables: allow for symbols instead of numbers in condition entries.   
		Ex. // RED YELLOW GREEN | color==$$;  but not necessarily:  //  <0  >3   ==7  | A$$  
 * Optimizations:
    * Eliminate a goto to another goto action; just goto the second goto target.
 * Table editting:
    * Option to reorganize rules -- i.e.  move decision table columns around.
    * Create editor program/GUI
    * Option to delete a rule. Can be multiple rules.
    * Fix number of spaces for -x option. 
 * Change ccide script to accept multiple file names and if the -L language option is ommitted,
		    convert according to suffixes: (using an intermediate file if the output file name 
		    would duplicate the input filename).  Default to C language.
    * Ex.  'ccide foobar.LANG.d' will execute ccide -L LANG < foobar.LANG.d > foobar.LANG
			where LANG=cpp, qb, java, etc.

