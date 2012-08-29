REM Taken from http://www.romankoch.ch/capslock/vbdectable.htm

;CCIDE_INLINE_CODE:

;DECISION_TABLE:
; Y Y Y Y Y Y Y Y N N | bNetwork
; Y Y Y Y N N N N - - | bFast
; Y Y N N Y Y N N - - | bNewer
; Y N Y N Y N Y N Y N | bLocal
;____________________ | ______
; X - - X X - - - - - | rem ask if user wants to download
; - X - - - - - X - - | rem how can the original be newer than the copy if there is no copy?
; - - X - - - X - x - | rem continue with local copy
; - - - - - X - - - - | rem tell user that program can only continue after download
; - - - - - - - - - X | rem inform user that program cannot continue
;END_TABLE:


