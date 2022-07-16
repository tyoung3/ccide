' RQB2HTML - Rapid-Q BASIC source code to HTML converter by William Yu
'
' Requires KEYWORD.LST, which should be included in your Rapid-Q distribution.
' You can modify this file to support other BASIC languages if you want
'
' Command line options:
'      -e   to handle escape characters


$TYPECHECK ON
$OPTIMIZE ON
$INCLUDE "rapidq.inc"
$ESCAPECHARS ON

'CCIDE_INLINE_CODE:

CONST CRLF = "\r\n"

DEFINT useEscapes = FALSE

SUB bas2Html (inFile AS STRING, outFile AS STRING)
    DIM fIn     AS QFILESTREAM
    DIM fOut    AS QFILESTREAM
    DIM sList   AS QSTRINGLIST
    DIM keyList AS QSTRINGLIST
    DIM i       AS LONG
    DIM j       AS LONG
    DIM quote   AS BYTE
    DIM ch      AS STRING * 1
    DIM token   AS STRING

    IF fIn.open(inFile, fmOpenRead) = 0 THEN
        PRINT "ERROR in opening file " + inFile
        END
    END IF
    IF fOut.open(outFile, fmCreate) = 0 THEN
        PRINT "ERROR in creating file " + outFile
        END
    END IF
    IF fileExists("keyword.lst") = 0 THEN
        PRINT "ERROR can't find file keyword.lst"
        END
    ELSE
        keyList.LoadFromFile("keyword.lst")
    END IF

    PRINT "Converting " + inFile + " to " + outFile

    fOut.writeLine("<html>")
    fOut.writeLine("<head>")
    fOut.writeLine("<title>"+inFile+"</title>")
    fOut.writeLine("</head>")
    fOut.writeLine("<body bgcolor=\"FFFFFF\">")
    fOut.writeLine("<pre>")

    sList.text = fIn.readStr(fIn.size)
    FOR i = 0 TO sList.itemCount-1
        quote = FALSE
        token = ""
        FOR j = 1 TO len(sList.item(i))
            ch = sList.item(i)[j]
            IF instr("+-=<>()\\/^&*[]\":;?,'\t ", ch) THEN
                IF ch = "\"" THEN
                    fOut.write(ch)
                    FOR j = j+1 TO len(sList.item(i))
                        ch = sList.item(i)[j]
			'DECISION_TABLE:
			'  Y - - - | useEscapes
			'  Y N - - | ch = "\\"
			'  - Y - - | ch = "\""
			'  - - Y - | ch = "<"
			'  _______ | _________
			'  X - - - | token = token + ch
			'  X - - - | j++
			'  X - - - | ch = sList.item(i)[j]
			'  X - - X | token = token + ch
			'  - X - - | EXIT FOR 
			'  - - X - | token = token + "&lt;"
			'END_TABLE:
			'ORIGINAL_CODE:
                        'IF useEscapes THEN
                        '    IF ch = "\\" THEN
                        '        token = token + ch
                        '        j++
                        '        ch = sList.item(i)[j]
                        '        token = token + ch
                        '    ELSEIF ch = "\"" THEN
                        '        EXIT FOR
                        '    ELSE
                        '        IF ch = "<" THEN
                        '            token = token + "&lt;"
                        '        ELSE
                        '            token = token + ch
                        '        END IF
                        '    END IF
                        'ELSE
                        '    IF ch = "\"" THEN
                        '        EXIT FOR
                        '    ELSE
                        '        IF ch = "<" THEN
                        '            token = token + "&lt;"
                        '        ELSE
                        '            token = token + ch
                        '        END IF
                        '    END IF
                        'END IF
			'END_ORIGINAL_CODE:
                    NEXT
                    fOut.write("<font color=\"990000\">"+token+"</font>")
                ELSEIF ch = "'" THEN
                    IF token <> "" THEN
                        IF keyList.find(ucase$(token)) <> -1 THEN
                            fOut.write("<font color=\"0000AA\"><b>"+token+"</b></font>")
                        ELSE
                            fOut.write(token)
                        END IF
                    END IF
                    token = ""
                    FOR j = j TO len(sList.item(i))
                        ch = sList.item(i)[j]
                        IF ch = "<" THEN
                            token = token + "&lt;"
                        ELSE
                            token = token + ch
                        END IF
                    NEXT
                    fOut.write("<font color=\"007700\"><i>"+token+"</i></font>")
                    ch = ""
                ELSEIF token <> "" THEN
                    IF keyList.find(ucase$(token)) <> -1 THEN
                        fOut.write("<font color=\"0000AA\"><b>"+token+"</b></font>")
                    ELSE
                        fOut.write(token)
                    END IF
                END IF

                IF ch = "<" THEN
                    fOut.write("&lt;")
                ELSEIF ch = "(" OR ch = ")" THEN
                    fOut.write("<b>"+ch+"</b>")
                ELSE
                    fOut.write(ch)
                END IF
                token = ""
            ELSE
                token = token + ch
            END IF
        NEXT
        IF token <> "" THEN
            IF keyList.find(ucase$(token)) <> -1 THEN
                fOut.write("<font color=\"000099\"><b>"+token+"</b></font>")
            ELSE
                fOut.write(token)
            END IF
        END IF
        fOut.write(CRLF)
        $IFDEF WIN32
         LOCATE CSRLIN, 1
         PRINT format$("%3d", i*100 \ (sList.itemCount-1)) + "% complete.    ";
        $ENDIF
    NEXT
    PRINT: PRINT

    fOut.writeLine("</pre>")
    fOut.writeLine("</body>")
    fOut.writeLine("</html>")
END SUB ' bas2Html


DEFSTR inFile = "", outFile = ""
DEFINT i

PRINT "Rapid-Q BASIC code to HTML converter by William Yu"
IF commandCount < 1 THEN
    PRINT "Usage: RQB2HTML [options] filename.BAS [filename.HTML]"
    PRINT
    PRINT "Options:"
    PRINT "  -e     Handle escape characters"
    END
ELSE
    FOR i = 1 TO commandCount
        IF command$(i)[1] = "-" THEN
            IF lcase$(command$(i)[2]) = "e" THEN
                useEscapes = TRUE
            ELSE
                PRINT "Invalid option "; command$(i)
                END
            END IF
        ELSE
            IF inFile = "" THEN
                inFile = command$(i)
            ELSE
                outFile = command$(i)
            END IF
        END IF
    NEXT

    IF fileExists(inFile) THEN
        IF outFile <> "" THEN
            '-- User specified an output file name
            bas2Html(inFile, outFile)
        ELSE
            i = INSTR(inFile, ".")
            IF i THEN
                outFile = left$(inFile, i-1) + ".html"
            ELSE
                '-- No extension found, just append .HTML
                outFile = inFile + ".html"
            END IF
            bas2Html(inFile, outFile)
        END IF
    ELSE
        PRINT format$("ERROR: '%s' not found", inFile)
    END IF
END IF
