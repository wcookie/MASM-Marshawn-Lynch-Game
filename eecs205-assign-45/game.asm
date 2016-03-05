; #########################################################################
;
;   game.asm - Assembly file for EECS205 Assignment 4/5
;
;	Wyatt Cook
;	2827797
;	wsc147
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include blit.inc
include game.inc
include keys.inc
include \masm32\include\windows.inc
include \masm32\include\winmm.inc
includelib \masm32\lib\winmm.lib 	
include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib 

	
.DATA


SndPath BYTE "MUSIC.wav",0 


lynch2small EECS205BITMAP <118, 111, 255,, offset lynch2small + sizeof lynch2small>
	BYTE 0beh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh
	BYTE 07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh
	BYTE 07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh
	BYTE 07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07eh,07eh,09eh
	BYTE 09eh,0bah,0bbh,0dbh,0bbh,0bah,09eh,09eh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh
	BYTE 07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh
	BYTE 07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh,07dh
	BYTE 07dh,07dh,07dh,07dh,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,038h,079h,096h,096h,0b6h,0b6h,0b7h,0dbh,0dbh,0dbh,0dbh,0bah,0bah,09ah,059h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,038h,075h,0b6h,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0bbh,09ah,05dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,059h,096h,0d7h,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0d7h,0bah,07ah,03ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,075h,0b6h
	BYTE 0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0d7h,092h,0b7h
	BYTE 0dbh,0dbh,0dbh,0d7h,0dbh,0bah,05dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,059h,096h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0b6h,049h,049h,0b2h,0dbh,0dbh,0dbh,0dbh,0d7h,0bah,059h,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,059h,0b6h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,049h,049h,049h,08eh,0b7h,0dbh
	BYTE 0dbh,0dbh,0dbh,0bbh,059h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,0b6h,0dbh,0dbh
	BYTE 0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 06dh,092h,0b6h,06dh,049h,0b6h,0dbh,0dbh,0bbh,0b7h,0b7h,05dh,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,09ah,0dbh,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0b6h,092h,0b6h,0dbh,092h,049h,092h,0dbh,0dbh,0dbh
	BYTE 0b7h,0bah,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,059h,0bah,0d7h,0dbh,0dbh,0dbh,0d7h,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,08eh,049h,092h
	BYTE 092h,024h,049h,0b6h,0dbh,0dbh,0bbh,0b7h,079h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,076h,0d7h,0d7h
	BYTE 0dbh,0dbh,0d7h,0dbh,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,092h,06dh,0b6h,06dh,092h,0b6h,0dbh,0dbh,0dbh,0bbh,0d7h,0bah,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,039h,0b6h,0dbh,0dbh,0dbh,0d7h,0dbh,0dbh,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,06eh,06dh,092h,049h,092h,0dbh,0dbh
	BYTE 0dbh,0dbh,0d7h,0b7h,0bbh,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,079h,0d7h,0d7h,0dbh,0dbh,0d7h,0d7h,0d7h
	BYTE 0d7h,0d7h,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,092h,092h
	BYTE 0dbh,0dbh,092h,049h,092h,0dbh,0dbh,0dbh,0dbh,0b7h,0bbh,03ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,096h,0d7h
	BYTE 0dbh,0dbh,0dbh,0dbh,0d7h,0dbh,0d7h,0d7h,0d7h,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,024h,092h,0b6h,06eh,049h,049h,092h,0dbh,0dbh,0dbh,0dbh,0b7h
	BYTE 0bah,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,03ch,0b6h,0d7h,0dbh,0dbh,0d7h,0d7h,0d7h,0dbh,0d7h,0d7h,0d7h,0d7h
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0d7h,024h,049h,049h,06dh,0b6h,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0b7h,0bah,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,039h,0d7h,0dbh,0d7h,0d7h,0d7h,0d6h
	BYTE 0d7h,0d7h,0d7h,0d7h,0d7h,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0b6h
	BYTE 049h,06dh,0b6h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0bbh,0bah,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,059h
	BYTE 0d6h,0d7h,0b6h,0dbh,0dbh,0dbh,0dbh,0d7h,0d7h,0dbh,0d7h,0b6h,0b6h,08dh,06dh,06dh
	BYTE 06dh,06dh,06dh,06dh,092h,092h,06dh,092h,096h,0b6h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0bbh,0b7h,0bah,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,018h,018h,018h,038h,096h,0b6h,0b2h,0b6h,0dbh,0dbh,0dbh,0dbh,0dbh,0b6h,08eh
	BYTE 049h,024h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,000h,024h
	BYTE 049h,049h,06dh,06dh,092h,0b6h,0b6h,0b6h,09ah,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,030h,004h,004h,028h,092h,0b2h,0b6h,0d7h,0d7h
	BYTE 0dbh,0d7h,0b6h,06dh,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,020h,024h,024h,024h,049h,06dh,06eh,06eh,051h
	BYTE 038h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,00ch,000h,000h
	BYTE 000h,092h,0d7h,0d7h,0b6h,0b2h,092h,049h,024h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,044h,044h,044h,044h
	BYTE 044h,044h,024h,048h,024h,024h,024h,049h,02ch,030h,038h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,014h,004h,000h,000h,0b2h,08eh,049h,024h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,020h,020h,024h,044h,044h,044h,044h,044h,044h,020h,020h,020h,000h
	BYTE 000h,000h,000h,000h,000h,000h,020h,024h,024h,024h,000h,000h,000h,000h,000h,000h
	BYTE 004h,02ch,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,010h,029h,069h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,044h,069h,089h,089h,089h,089h,089h,0a9h,089h
	BYTE 0adh,0adh,089h,089h,089h,089h,069h,068h,044h,020h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,00ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,038h,024h,000h,000h,000h,000h,000h,000h,020h,044h,044h,088h,0a9h,0adh
	BYTE 0adh,0adh,0adh,0a9h,0adh,0adh,0adh,0d1h,0d1h,0cdh,0adh,0cdh,0d1h,0b1h,0adh,08dh
	BYTE 069h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,004h,000h,000h,000h,000h,000h,000h
	BYTE 024h,068h,088h,0adh,0adh,0adh,0adh,089h,089h,064h,069h,08dh,08dh,08dh,08dh,08dh
	BYTE 08dh,091h,0b1h,0b1h,091h,08dh,06dh,069h,048h,044h,020h,000h,000h,000h,000h,000h
	BYTE 000h,008h,010h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,02ch,000h
	BYTE 000h,000h,000h,000h,000h,000h,064h,088h,0adh,0adh,0adh,0adh,069h,064h,044h,024h
	BYTE 020h,020h,024h,048h,049h,069h,08dh,08dh,08dh,091h,08dh,06dh,08dh,06dh,069h,049h
	BYTE 069h,06dh,029h,030h,010h,014h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,038h,004h,000h,000h,000h,000h,000h,000h,020h,089h,088h,08dh,0adh
	BYTE 0adh,08dh,044h,044h,020h,020h,000h,020h,000h,000h,020h,024h,08dh,0b2h,08dh,08dh
	BYTE 069h,045h,045h,024h,020h,020h,044h,069h,049h,031h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,02ch,000h,000h,000h,000h,000h,000h
	BYTE 000h,044h,088h,088h,064h,068h,069h,044h,020h,020h,020h,000h,000h,000h,000h,000h
	BYTE 000h,020h,044h,08dh,068h,044h,069h,065h,040h,020h,020h,020h,024h,049h,045h,045h
	BYTE 051h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,004h
	BYTE 000h,000h,000h,000h,000h,000h,020h,088h,0adh,0adh,0adh,089h,068h,020h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,044h,08dh,08dh,044h,044h,040h,020h,000h
	BYTE 000h,000h,020h,024h,024h,045h,051h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,010h,000h,000h,000h,000h,000h,000h,000h,020h,088h,0adh,0adh
	BYTE 0adh,0a8h,064h,020h,020h,000h,000h,000h,000h,000h,000h,000h,000h,000h,044h,0adh
	BYTE 08dh,044h,065h,040h,020h,020h,000h,000h,000h,020h,020h,049h,055h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,004h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,088h,0adh,0adh,0adh,0adh,068h,020h,020h,020h,000h,000h,000h,000h
	BYTE 000h,000h,000h,024h,069h,0adh,0adh,064h,069h,044h,020h,020h,000h,000h,000h,000h
	BYTE 000h,049h,034h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,030h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,020h,068h,0adh,0adh,0adh,0adh,089h,020h
	BYTE 020h,020h,000h,000h,000h,000h,000h,000h,000h,044h,0adh,0d1h,0cdh,089h,064h,040h
	BYTE 020h,000h,000h,000h,000h,020h,020h,044h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,028h,000h,000h,000h,000h,000h,000h,000h,000h,020h,064h
	BYTE 0a9h,0adh,0d1h,0cdh,0adh,044h,020h,020h,000h,000h,000h,000h,000h,000h,044h,0adh
	BYTE 0d2h,0d1h,0d1h,0adh,089h,044h,000h,000h,000h,000h,020h,020h,020h,049h,03ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,020h,044h,064h,088h,0adh,0adh,0adh,0adh,089h,020h,020h,000h,000h
	BYTE 000h,000h,000h,044h,089h,0d2h,0d2h,0d1h,0d1h,0cdh,0adh,068h,044h,020h,020h,020h
	BYTE 044h,020h,020h,044h,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 02ch,000h,000h,000h,000h,000h,000h,000h,000h,024h,040h,064h,088h,0adh,0cdh,0cdh
	BYTE 0d1h,0adh,068h,020h,000h,000h,000h,000h,044h,069h,0adh,0d2h,0d2h,0d1h,0d1h,0d1h
	BYTE 0adh,089h,065h,069h,064h,044h,044h,065h,024h,000h,010h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,014h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h
	BYTE 044h,064h,088h,0a9h,0adh,0cdh,0d1h,0d2h,0adh,089h,064h,044h,044h,064h,089h,0adh
	BYTE 0b1h,0d1h,0d1h,0d1h,0d1h,0d1h,0adh,0adh,08dh,089h,069h,089h,089h,069h,000h,000h
	BYTE 008h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,02ch,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,020h,044h,064h,088h,0adh,0b1h,0d1h,0d2h,0d2h,0d1h
	BYTE 0cdh,0adh,0adh,0adh,0adh,0d1h,0d2h,0d1h,0d2h,0d2h,0d2h,0d2h,0d2h,0b1h,0b1h,0b1h
	BYTE 0adh,0b1h,0adh,08dh,020h,000h,000h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 018h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,044h,064h,088h
	BYTE 0adh,0adh,0d1h,0d2h,0d2h,0d2h,0d2h,0d1h,0cdh,0adh,0adh,0adh,0d1h,0adh,0adh,0adh
	BYTE 0d1h,0d2h,0d1h,08dh,0b1h,0d2h,0d1h,0b1h,0b1h,08dh,020h,000h,000h,00ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,014h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,044h,064h,088h,0a9h,0adh,0adh,0d1h,0d2h,0d2h,0d2h,0d1h,0cdh,0adh
	BYTE 0adh,0adh,088h,040h,064h,088h,0a9h,0adh,089h,064h,089h,0d6h,0d6h,0b1h,0b1h,08dh
	BYTE 000h,000h,000h,004h,010h,014h,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,00ch,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,044h,064h,088h,088h,0adh,0adh,0adh
	BYTE 0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0adh,0adh,08dh,08dh,0adh,0adh,0adh,0adh,08dh,08dh
	BYTE 0adh,0d2h,0d2h,0d2h,0b1h,069h,000h,000h,000h,000h,004h,004h,000h,010h,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,008h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,044h
	BYTE 068h,088h,088h,0adh,0adh,0adh,0adh,0cdh,0cdh,0d1h,0b1h,0d1h,0adh,0adh,089h,089h
	BYTE 089h,0adh,0b1h,0adh,069h,088h,0adh,0b1h,0d2h,0b2h,0adh,048h,000h,000h,000h,000h
	BYTE 000h,000h,000h,004h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,020h,020h,044h,088h,088h,088h,0adh,0adh,0adh,0adh,0adh,0adh,0adh
	BYTE 0adh,0adh,08dh,089h,068h,068h,068h,08dh,0adh,08dh,068h,044h,068h,0adh,0b1h,0b1h
	BYTE 0adh,044h,000h,000h,000h,000h,000h,000h,000h,000h,014h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,00ch,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,000h,044h,088h,088h,0a9h,0a9h
	BYTE 0a9h,0adh,0adh,0adh,0adh,08dh,08dh,069h,064h,068h,068h,089h,08dh,0adh,0adh,0adh
	BYTE 08dh,069h,044h,044h,08dh,0adh,08dh,024h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 010h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,018h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h
	BYTE 000h,020h,064h,088h,0a9h,0a9h,0a9h,0adh,0adh,0adh,089h,068h,064h,044h,044h,089h
	BYTE 08dh,0adh,0a9h,0a9h,0adh,0adh,0adh,08dh,069h,044h,048h,08dh,089h,020h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,010h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,010h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,020h,020h,020h,064h,088h,0a8h,0a9h,0a9h,0adh,0adh,0a9h
	BYTE 089h,044h,044h,044h,068h,089h,088h,089h,089h,089h,069h,089h,089h,089h,089h,044h
	BYTE 024h,069h,069h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,030h,004h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,020h,020h,064h,088h
	BYTE 0a8h,0a9h,0a9h,0a8h,0a8h,0adh,089h,044h,064h,068h,064h,064h,089h,089h,089h,089h
	BYTE 08dh,089h,069h,068h,068h,048h,024h,069h,048h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,00ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,028h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,020h,044h,088h,088h,0a8h,0a8h,0a8h,0adh,0adh,089h,064h,068h,08dh
	BYTE 089h,089h,0adh,0adh,0ceh,0ceh,0adh,0adh,0adh,0adh,069h,069h,044h,069h,024h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,008h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,020h,020h,044h,064h,088h,088h,0a8h,0a8h
	BYTE 0adh,0adh,089h,088h,089h,0adh,089h,0a9h,0adh,0adh,0adh,0cdh,0cdh,0d2h,0d2h,0adh
	BYTE 08dh,089h,068h,068h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,018h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,020h
	BYTE 020h,064h,084h,088h,088h,0a8h,088h,088h,088h,088h,089h,08dh,089h,089h,088h,088h
	BYTE 088h,068h,068h,089h,08dh,089h,089h,089h,068h,044h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,02dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,020h,020h,020h,020h,040h,064h,088h,088h,0a8h,0a8h,088h,088h,088h
	BYTE 089h,0a9h,089h,088h,088h,064h,044h,044h,024h,044h,044h,068h,08dh,088h,068h,020h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,024h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,020h,020h,044h,040h,044h,064h
	BYTE 088h,088h,088h,088h,088h,088h,089h,0a9h,0a9h,0adh,08dh,089h,068h,044h,044h,068h
	BYTE 069h,089h,089h,068h,044h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,004h,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,051h,024h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,000h,000h,000h,020h
	BYTE 020h,000h,044h,040h,044h,044h,064h,088h,088h,088h,088h,088h,0adh,0adh,0adh,0adh
	BYTE 0adh,0adh,08dh,069h,069h,08dh,08dh,0adh,08dh,044h,020h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,00ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,034h,071h,04dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,020h,000h,020h,020h,044h,044h,044h,064h,064h,064h
	BYTE 064h,088h,089h,0adh,0adh,0adh,0adh,08dh,089h,069h,068h,08dh,08dh,08dh,069h,024h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,014h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,035h,096h,0b9h,051h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,000h,000h,020h
	BYTE 040h,044h,044h,044h,044h,040h,040h,044h,064h,089h,089h,089h,089h,069h,068h,044h
	BYTE 044h,069h,069h,069h,044h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,008h,010h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,031h,04dh,095h,0b9h
	BYTE 051h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,020h,000h,000h,020h,044h,044h,044h,024h,020h,020h,020h,020h,044h
	BYTE 044h,044h,044h,044h,044h,024h,020h,024h,024h,024h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,00ch,018h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 03ch,059h,024h,028h,095h,0b9h,04dh,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,020h,020h,000h,020h,020h,040h,044h,040h
	BYTE 020h,020h,000h,000h,000h,000h,000h,020h,020h,020h,020h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,004h,00ch,014h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,03ch,079h,0b9h,075h,099h,0b9h,095h,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,020h
	BYTE 020h,020h,020h,040h,044h,044h,044h,020h,020h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,004h,000h,000h,008h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,075h,099h,099h,095h,071h
	BYTE 071h,048h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,020h,040h,040h,040h,040h,044h,064h,064h,044h,044h,044h
	BYTE 024h,020h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,04dh,04dh,025h,02dh,010h,018h
	BYTE 018h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,034h
	BYTE 04dh,049h,049h,04dh,04dh,049h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,020h,020h,040h,040h
	BYTE 044h,064h,064h,064h,064h,064h,068h,064h,024h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 029h,06eh,06eh,0b6h,049h,029h,029h,009h,00dh,014h,018h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,038h,051h,04dh,06eh,092h,072h,06eh,092h,0b6h,0b6h,06eh,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,000h,020h,040h,040h,064h,064h,068h,064h,064h,084h,064h,020h,020h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,020h,024h,049h,049h,049h,029h,025h,06eh,072h,029h,029h
	BYTE 029h,00dh,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,054h,072h,092h,0b6h,0b7h,0d7h,0b6h,0d7h,0d7h
	BYTE 0b6h,0b6h,092h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,044h,08dh,044h,000h,000h,000h,000h,020h,044h,040h,064h,064h,064h
	BYTE 088h,068h,064h,044h,020h,084h,020h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,029h,029h
	BYTE 04dh,096h,0deh,0deh,096h,02dh,029h,029h,02dh,018h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,079h,0b2h,092h,0b6h
	BYTE 0b6h,0b6h,0b7h,0b7h,0b7h,0b7h,0b6h,0b6h,06dh,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,020h,044h,069h,0b1h,0d2h,08dh,020h,000h,000h,000h
	BYTE 020h,020h,020h,040h,044h,064h,044h,044h,020h,020h,004h,044h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,024h,025h,029h,04dh,072h,0bah,0deh,0deh,0deh,0deh,09ah,051h,029h,029h,00dh
	BYTE 018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,055h,0b2h,0b6h,0b6h,0b7h,0b6h,0d7h,0d7h,0dbh,0b7h,0b6h,0b6h,06dh,020h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,064h,089h,0adh,0cdh,0cdh
	BYTE 0d1h,089h,000h,000h,000h,000h,000h,000h,000h,000h,020h,024h,020h,000h,024h,089h
	BYTE 024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,025h,029h,092h,0bah,0deh,0deh,0beh,0deh,0deh
	BYTE 0deh,0deh,09ah,0bah,0bah,051h,010h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,035h,04dh,092h,0b6h,0b6h,0b6h,0b6h,0d7h,0d7h,0dbh
	BYTE 0b7h,0b7h,0b2h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,069h
	BYTE 0adh,0adh,0adh,0adh,0adh,0adh,089h,024h,000h,020h,068h,089h,000h,000h,000h,000h
	BYTE 024h,049h,024h,000h,069h,088h,044h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,04dh,0bah
	BYTE 0deh,0deh,0deh,096h,0deh,0deh,0beh,072h,04dh,0beh,0beh,099h,02dh,018h,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,031h,049h,025h,025h,049h
	BYTE 06eh,08eh,0b6h,0d7h,0dbh,0d7h,0b6h,0b6h,049h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,068h,0adh,0d1h,0adh,0adh,0a9h,0a9h,068h,044h,020h,000h,020h,044h
	BYTE 0adh,0adh,020h,000h,000h,000h,000h,024h,020h,024h,0b1h,0a8h,0a4h,020h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,024h,004h,028h,02ch,071h,095h,0deh,0bah,04dh,096h,096h,04dh,029h,096h,0deh
	BYTE 0beh,0beh,071h,010h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h
	BYTE 02dh,004h,001h,001h,000h,005h,001h,005h,045h,049h,06eh,092h,0b2h,08eh,024h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,044h,089h,0d1h,0d1h,0d1h,0d1h,0adh,088h,044h
	BYTE 020h,000h,000h,020h,044h,088h,0adh,069h,000h,000h,000h,000h,000h,000h,000h,069h
	BYTE 0adh,049h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,004h,095h,0b9h,0beh,099h,0beh,0bah,02dh
	BYTE 005h,005h,029h,096h,0deh,0deh,0beh,0beh,09ah,02dh,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,018h,02dh,004h,000h,001h,000h,000h,004h,005h,001h,005h,000h
	BYTE 000h,024h,049h,025h,000h,000h,000h,000h,000h,000h,000h,000h,044h,089h,0adh,0adh
	BYTE 0d1h,0cdh,0adh,089h,044h,000h,000h,020h,040h,064h,089h,08dh,068h,020h,000h,000h
	BYTE 000h,000h,000h,000h,024h,0b1h,048h,024h,025h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,051h,0beh
	BYTE 0beh,0deh,0deh,0deh,0deh,071h,029h,029h,096h,0deh,0deh,0deh,0deh,0deh,0beh,04dh
	BYTE 014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,02ch,025h,001h,000h,000h,000h
	BYTE 000h,000h,005h,001h,005h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,044h,089h,0a9h,0adh,0cdh,0adh,088h,064h,020h,020h,020h,044h,068h,088h,0a9h
	BYTE 08dh,044h,020h,000h,000h,000h,000h,000h,000h,000h,049h,0b1h,060h,065h,08eh,049h
	BYTE 045h,024h,000h,000h,000h,000h,06dh,06eh,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,04dh,095h,0bah,0deh,0deh,0deh,0deh,0deh,0bah,0bah,0deh,0deh
	BYTE 0deh,0deh,0deh,0beh,0deh,06dh,00dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,030h
	BYTE 000h,000h,001h,004h,000h,000h,021h,001h,005h,025h,005h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,044h,0adh,0a9h,0adh,0adh,0adh,088h,044h,020h,020h
	BYTE 044h,068h,0adh,0adh,0a9h,064h,044h,024h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 069h,064h,064h,069h,06dh,049h,06dh,06dh,049h,024h,024h,06dh,0dbh,0b7h,024h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,024h,024h,025h,025h,049h,071h,0bah,0deh
	BYTE 0deh,0deh,0deh,0deh,0deh,0deh,0deh,0deh,0deh,0deh,0deh,06dh,029h,018h,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,018h,025h,000h,000h,000h,004h,000h,001h,001h,001h,001h,005h
	BYTE 001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,044h,0adh,0adh,0adh,0d2h
	BYTE 0d1h,08dh,044h,020h,044h,064h,088h,0adh,0adh,08dh,068h,020h,025h,092h,045h,000h
	BYTE 000h,000h,000h,000h,000h,000h,068h,024h,004h,049h,024h,024h,069h,049h,06dh,045h
	BYTE 08eh,0dbh,0dbh,092h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,092h,06eh
	BYTE 049h,025h,025h,025h,029h,071h,096h,0deh,0deh,0deh,0deh,0deh,0deh,0deh,0deh,0deh
	BYTE 0beh,04dh,029h,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,02dh,005h,000h,000h,000h,001h
	BYTE 001h,000h,000h,004h,000h,001h,005h,000h,000h,000h,000h,000h,000h,000h,000h,020h
	BYTE 044h,08dh,0adh,0d1h,0d2h,0d2h,0b1h,068h,040h,064h,089h,0a9h,088h,088h,064h,044h
	BYTE 020h,000h,049h,0b7h,092h,049h,024h,000h,000h,000h,000h,044h,068h,020h,024h,024h
	BYTE 024h,045h,045h,049h,06dh,049h,092h,0b7h,0dbh,049h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,024h,06dh,0b6h,0b6h,0b7h,092h,049h,025h,025h,025h,029h,04dh,072h,096h
	BYTE 0deh,0deh,0deh,0deh,0deh,0deh,0bah,029h,029h,030h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,030h
	BYTE 004h,000h,000h,000h,000h,001h,001h,000h,000h,004h,000h,005h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,020h,064h,089h,0adh,0adh,0adh,0adh,0adh,088h,064h,064h,0adh
	BYTE 0adh,0adh,068h,044h,064h,068h,020h,024h,06dh,0b7h,06eh,049h,024h,000h,000h,000h
	BYTE 020h,089h,064h,060h,024h,044h,024h,06dh,092h,092h,092h,092h,092h,06eh,06eh,004h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,024h,092h,0b6h,0b7h,0d7h,0dbh,0b6h,092h
	BYTE 049h,025h,029h,029h,029h,029h,04dh,092h,0bah,0deh,0deh,0deh,0b6h,029h,049h,051h
	BYTE 018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,030h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h
	BYTE 001h,000h,000h,000h,000h,000h,000h,000h,020h,044h,068h,089h,0adh,089h,089h,089h
	BYTE 088h,08dh,089h,088h,0adh,0adh,0adh,0adh,044h,020h,040h,08dh,020h,020h,08dh,0fbh
	BYTE 092h,049h,000h,000h,000h,000h,044h,068h,064h,060h,044h,020h,049h,092h,0b6h,0b7h
	BYTE 0b6h,0b7h,092h,06eh,025h,000h,000h,000h,000h,000h,000h,000h,000h,004h,024h,092h
	BYTE 0b7h,0dbh,0dbh,0dbh,0dbh,0dbh,0b7h,092h,06eh,049h,029h,029h,029h,029h,04dh,096h
	BYTE 0deh,0deh,096h,029h,049h,092h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 07dh,01ch,01ch,01ch,01ch,014h,008h,004h,028h,029h,025h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,044h,064h,089h,089h
	BYTE 0adh,0adh,0adh,0adh,0adh,0adh,0adh,0b1h,0adh,0adh,0adh,0adh,089h,044h,000h,000h
	BYTE 024h,08dh,000h,044h,06dh,0d6h,0b6h,045h,000h,000h,000h,000h,08dh,069h,028h,000h
	BYTE 000h,000h,092h,0b6h,0b6h,0b6h,0b6h,0b6h,08eh,06dh,024h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,024h,024h,092h,0d7h,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 092h,06eh,049h,029h,029h,029h,096h,0deh,072h,049h,06eh,0dbh,075h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch,034h,004h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 020h,044h,069h,089h,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0b1h,0b1h,0adh
	BYTE 089h,044h,020h,000h,000h,000h,004h,069h,024h,069h,024h,069h,092h,000h,000h,000h
	BYTE 000h,044h,0adh,044h,004h,000h,000h,024h,049h,049h,025h,049h,092h,0dbh,08eh,049h
	BYTE 024h,000h,000h,000h,000h,000h,000h,000h,000h,024h,025h,0b6h,0d7h,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,0dbh,0dbh,092h,04eh,02ah,029h,096h,092h,029h
	BYTE 06eh,0dbh,0bah,01ch,01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,07dh,01ch,014h,029h
	BYTE 004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,024h,044h,068h,089h,089h,0adh,0adh,0a9h,0adh,0a9h,0adh
	BYTE 0a9h,0adh,0d1h,0d2h,0b1h,0b1h,044h,000h,000h,000h,000h,000h,000h,044h,024h,08eh
	BYTE 025h,020h,024h,000h,000h,000h,000h,08dh,0adh,0a4h,044h,024h,000h,000h,000h,000h
	BYTE 005h,025h,025h,06eh,049h,025h,024h,000h,000h,000h,000h,000h,000h,000h,020h,024h
	BYTE 049h,0b7h,0b7h,0b7h,0b7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0fbh,0dbh,0ffh
	BYTE 0b7h,072h,029h,049h,04dh,029h,072h,0dbh,0dbh,059h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 0ffh,0ffh,079h,00ch,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,044h,069h,088h,088h,089h
	BYTE 089h,088h,089h,0a9h,084h,084h,088h,0a9h,0d1h,0d2h,0d2h,0adh,020h,000h,000h,000h
	BYTE 000h,020h,020h,024h,000h,000h,000h,000h,000h,000h,000h,000h,024h,0b1h,069h,069h
	BYTE 044h,024h,049h,049h,000h,000h,005h,005h,025h,000h,004h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,024h,069h,0b7h,0b7h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0ffh,0fbh,0ffh,0dbh,072h,029h,04eh,029h,072h,0dbh,0dbh,09ah
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,071h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,044h
	BYTE 064h,089h,08dh,0adh,089h,089h,089h,088h,089h,089h,088h,064h,089h,0a9h,0cdh,0d2h
	BYTE 0d2h,0b1h,024h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,020h,089h,0b2h,049h,029h,024h,049h,08eh,06dh,000h,005h,025h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,024h,025h,06dh,092h,0b7h
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,0ffh,0ffh,0ffh,0dfh,0dbh,06eh
	BYTE 029h,029h,06eh,0dbh,0dbh,0bbh,018h,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,06dh,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,024h,064h,068h,08dh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,089h
	BYTE 089h,089h,0adh,0adh,0adh,0d1h,0d2h,0b1h,044h,000h,000h,000h,000h,000h,000h,024h
	BYTE 000h,000h,000h,000h,000h,000h,000h,044h,08dh,08dh,044h,048h,049h,06dh,069h,049h
	BYTE 004h,025h,025h,000h,000h,000h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,024h,000h,024h,024h,025h,06eh,0b6h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0b7h,06eh,029h,06eh,0dbh,0dbh,0dbh,035h,01ch,01ch,01ch
	BYTE 01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,064h,068h,089h,0adh,0b1h,0adh
	BYTE 0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0a9h,0adh,0cdh,0b1h,0b1h,044h,000h
	BYTE 000h,000h,000h,000h,020h,044h,000h,000h,000h,000h,000h,000h,024h,068h,08dh,0a8h
	BYTE 0a4h,044h,045h,06dh,06eh,049h,025h,005h,000h,000h,000h,025h,025h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,025h,025h,025h,049h,06eh
	BYTE 092h,0b7h,0dbh,0dbh,0ffh,0dfh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0b6h,029h,04eh,0dbh
	BYTE 0dbh,0dbh,051h,01ch,01ch,01ch,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,044h,068h
	BYTE 068h,068h,0adh,0adh,0d2h,0adh,0adh,0a9h,0adh,0adh,0adh,0adh,0adh,0b1h,0adh,0adh
	BYTE 0a9h,0adh,0adh,089h,024h,000h,000h,000h,000h,000h,000h,024h,000h,000h,000h,000h
	BYTE 024h,024h,024h,068h,048h,044h,064h,020h,06dh,092h,049h,025h,025h,000h,000h,005h
	BYTE 005h,025h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,000h,000h,025h
	BYTE 025h,005h,025h,025h,025h,025h,025h,029h,049h,06eh,092h,0dbh,0ffh,0ffh,0ffh,0dfh
	BYTE 0dfh,0dfh,0ffh,092h,029h,092h,0dbh,0dbh,072h,018h,01ch,01ch,01ch,01ch,0ffh,0ffh
	BYTE 06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,020h,064h,088h,088h,088h,088h,0adh,0adh,0d2h,0adh,0a9h,088h,089h,089h
	BYTE 088h,0adh,0adh,0d1h,0d1h,0adh,064h,089h,088h,088h,044h,004h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,044h,069h,020h,024h,089h,024h,008h,029h,06dh,06dh,024h
	BYTE 000h,025h,025h,025h,025h,025h,025h,025h,025h,025h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h,029h
	BYTE 029h,049h,06eh,096h,0dfh,0dfh,0ffh,0ffh,0dfh,0dbh,049h,06eh,0dbh,0dbh,072h,031h
	BYTE 01ch,01ch,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,044h,088h,088h,088h,088h,088h,0adh,0adh
	BYTE 0adh,0adh,089h,064h,040h,068h,068h,089h,0adh,0d1h,0d2h,0b1h,088h,088h,084h,084h
	BYTE 089h,069h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,068h,068h
	BYTE 000h,000h,024h,025h,024h,004h,005h,005h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,005h,005h,025h,025h
	BYTE 025h,025h,025h,025h,029h,029h,029h,029h,029h,049h,092h,0dbh,0ffh,0ffh,0dbh,0b7h
	BYTE 04eh,04ah,06eh,04eh,04ah,02dh,01ch,01ch,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,088h,088h
	BYTE 088h,088h,088h,088h,0a9h,0adh,089h,044h,044h,020h,020h,044h,020h,044h,089h,0adh
	BYTE 0d1h,0b1h,089h,064h,064h,089h,0d2h,0adh,024h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,028h,06dh,06dh,08dh,044h,060h,084h,049h,091h,071h,06dh,04dh,04dh,049h,049h
	BYTE 049h,029h,029h,029h,029h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,005h,005h,025h,025h,025h,025h,025h,025h,025h,029h,029h,029h,029h,02ah,029h
	BYTE 025h,06eh,092h,092h,04eh,049h,029h,029h,029h,02ah,04ah,029h,018h,01ch,01ch,01ch
	BYTE 0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,064h,088h,088h,088h,088h,088h,088h,088h,088h,064h,020h,020h,000h
	BYTE 000h,000h,020h,040h,084h,0a9h,0adh,0adh,0adh,089h,088h,0adh,0d2h,0adh,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,004h,024h,06dh,06dh,08dh,020h,040h,064h,06dh,0bah
	BYTE 0bah,0bah,0bah,0bah,0bah,0bah,0dah,0dbh,0dbh,096h,025h,024h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,025h,005h,025h,025h,025h,025h,025h,025h,025h
	BYTE 025h,029h,029h,029h,029h,029h,025h,029h,029h,029h,029h,029h,029h,029h,02ah,029h
	BYTE 029h,04ah,014h,01ch,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,064h,084h,088h,088h,088h,088h,088h
	BYTE 084h,044h,020h,020h,000h,000h,000h,040h,064h,089h,0a9h,089h,089h,0adh,0adh,068h
	BYTE 040h,088h,08dh,064h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,069h,089h
	BYTE 089h,000h,009h,029h,072h,0bah,0b7h,0b7h,0b7h,0b7h,0dbh,0b7h,0b6h,0dbh,0dfh,0b6h
	BYTE 025h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,005h,025h
	BYTE 025h,025h,025h,025h,025h,025h,025h,029h,029h,025h,025h,029h,029h,029h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,02ah,04ah,034h,01ch,01ch,01ch,0ffh,0ffh,06dh,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,044h
	BYTE 064h,064h,084h,088h,088h,064h,064h,020h,020h,020h,000h,000h,040h,064h,089h,0adh
	BYTE 0adh,0a9h,088h,0a9h,0a9h,064h,020h,064h,044h,020h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,044h,069h,08dh,068h,000h,004h,004h,096h,0bah,0d7h,0d7h,0b7h,0bbh
	BYTE 0b7h,0b7h,0d7h,0bbh,0bah,096h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,005h,005h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,04ah,04ah,035h,01ch
	BYTE 01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,020h,044h,064h,064h,064h,064h,064h,040h,020h,044h,044h
	BYTE 020h,040h,064h,084h,0adh,0adh,0adh,0a9h,088h,0adh,08dh,044h,020h,024h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,06dh,08dh,044h,000h,060h,040h
	BYTE 0b6h,0bah,0d7h,0dbh,0dbh,0d7h,0dbh,0dbh,0dbh,0dbh,0dbh,096h,025h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,005h,005h,005h
	BYTE 005h,025h,025h,025h,025h,025h,029h,029h,025h,029h,029h,029h,029h,029h,029h,029h
	BYTE 029h,029h,04ah,04ah,031h,01ch,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,040h,044h,064h
	BYTE 044h,040h,020h,020h,069h,068h,064h,064h,064h,088h,0adh,0adh,0adh,0adh,089h,0adh
	BYTE 0adh,069h,020h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,024h
	BYTE 06dh,0adh,044h,020h,0a4h,064h,0bah,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,096h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,005h,025h,025h,025h,025h,025h,025h,029h,029h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,029h,029h,02ah,02ah,02dh,01ch,01ch,01ch,0ffh,0ffh
	BYTE 06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,020h,040h,020h,020h,020h,048h,068h,020h,020h,040h,064h,064h
	BYTE 089h,0adh,0adh,089h,08dh,08dh,08dh,049h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,024h,049h,08dh,08dh,024h,000h,029h,049h,0bah,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,092h,005h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,025h,025h,025h,025h,025h,029h
	BYTE 025h,025h,025h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,04ah
	BYTE 029h,018h,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,020h,020h,000h,020h,020h
	BYTE 000h,000h,000h,020h,020h,020h,044h,044h,044h,024h,04dh,04dh,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,049h,08eh,0adh,08dh,000h,000h
	BYTE 004h,029h,0bah,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,072h,005h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,000h,001h,005h
	BYTE 025h,025h,025h,025h,025h,025h,025h,025h,025h,029h,029h,029h,029h,029h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,029h,035h,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h
	BYTE 044h,044h,020h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 02dh,008h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,024h,06dh
	BYTE 0b6h,0b7h,0b2h,08dh,000h,024h,024h,049h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dfh,071h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,025h,025h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,02dh,01ch,01ch
	BYTE 0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,024h,044h,044h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,004h,051h,028h,000h,000h,000h,004h,020h,024h,049h,024h
	BYTE 000h,044h,040h,049h,069h,06dh,0d7h,0b7h,0b2h,068h,000h,064h,0a4h,069h,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,06dh,025h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,025h,025h,025h,025h,025h,025h
	BYTE 025h,025h,025h,025h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h
	BYTE 029h,029h,02ah,029h,034h,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,048h,071h,049h,045h,024h
	BYTE 049h,069h,06dh,08dh,06dh,06dh,044h,0adh,044h,069h,08eh,08eh,0b7h,0b6h,0b1h,069h
	BYTE 000h,044h,064h,06dh,0dfh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,04dh
	BYTE 025h,005h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h
	BYTE 025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,029h,029h,029h,02ah,02dh,018h,0ffh,0ffh,06dh,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,004h,000h,000h,000h,000h,000h,000h,000h
	BYTE 04dh,071h,091h,08dh,08dh,06dh,08dh,08dh,08dh,08dh,091h,06ch,024h,0b1h,029h,049h
	BYTE 092h,08dh,0b6h,0d6h,0b1h,048h,004h,009h,009h,04dh,0dfh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dfh,04dh,025h,025h,025h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,005h,005h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 025h,025h,025h,025h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,049h,02ah
	BYTE 029h,031h,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h,014h,004h
	BYTE 000h,000h,000h,000h,000h,04dh,095h,092h,08eh,08dh,08dh,08dh,08dh,08dh,08eh,091h
	BYTE 091h,048h,024h,0b2h,049h,044h,092h,08dh,0b2h,0d6h,0b1h,024h,004h,024h,024h,06dh
	BYTE 0deh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dfh,04dh,025h,025h,025h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,005h,005h,025h,025h,025h
	BYTE 025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,029h,029h,029h,029h,029h,029h
	BYTE 029h,029h,029h,029h,02ah,02ah,029h,02dh,0ffh,0ffh,06dh,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,008h,018h,01ch,004h,000h,000h,000h,000h,028h,071h,092h,08eh,08dh,08dh
	BYTE 08dh,08dh,08dh,08dh,092h,091h,071h,004h,045h,0d6h,088h,080h,08dh,08eh,092h,0d6h
	BYTE 0b2h,024h,020h,064h,040h,071h,0dfh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0deh,049h,025h,025h,025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h
	BYTE 005h,005h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,029h,049h,04ah,031h,0ffh,0ffh
	BYTE 06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,004h,018h,01ch,01ch,004h,000h,000h,004h,028h
	BYTE 06dh,08dh,092h,08eh,08eh,08dh,08eh,08dh,08eh,091h,0b2h,091h,04dh,000h,044h,0b1h
	BYTE 089h,06dh,04dh,08eh,092h,0d6h,08dh,000h,020h,084h,060h,092h,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0bah,049h,025h,025h,025h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,005h,005h,005h,005h,025h,025h,025h,025h,025h,025h,025h
	BYTE 025h,025h,025h,025h,025h,025h,029h,029h,029h,025h,029h,029h,029h,029h,029h,029h
	BYTE 029h,04ah,031h,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,014h,01ch,01ch
	BYTE 01ch,004h,004h,02ch,096h,092h,092h,092h,0b2h,0b2h,0b2h,092h,092h,08eh,092h,092h
	BYTE 091h,091h,028h,000h,06dh,0d2h,08dh,08eh,024h,069h,08dh,0d2h,048h,000h,005h,029h
	BYTE 029h,096h,0dfh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0bah,029h,025h,025h
	BYTE 025h,001h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h,005h,001h,005h,025h
	BYTE 025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,029h,029h,029h,029h,029h
	BYTE 029h,029h,029h,029h,029h,029h,029h,031h,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,00ch,01ch,01ch,01ch,01ch,008h,048h,06dh,092h,0b2h,0b2h,0b2h,0b2h,092h
	BYTE 092h,0b2h,092h,092h,092h,092h,092h,071h,024h,024h,091h,0d6h,089h,0b6h,089h,0a9h
	BYTE 0adh,0b1h,024h,004h,000h,004h,004h,096h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh
	BYTE 0dbh,0dbh,0bah,029h,025h,025h,025h,005h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 005h,001h,005h,005h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 025h,025h,029h,025h,025h,029h,029h,029h,029h,029h,029h,025h,025h,014h,01ch,01ch
	BYTE 0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,008h,01ch,01ch,01ch,01ch,01ch,02ch,048h,06eh
	BYTE 0b2h,0b6h,0b6h,0b6h,0b6h,0b6h,092h,0b2h,0b2h,092h,092h,092h,091h,071h,000h,049h
	BYTE 0b6h,0d6h,08dh,0b2h,0b2h,069h,06dh,08dh,020h,020h,040h,020h,004h,096h,0bbh,0dbh
	BYTE 0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0bbh,0bah,029h,025h,025h,025h,025h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,025h,001h,005h,005h,005h,025h,025h,025h,025h,025h
	BYTE 025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 004h,004h,004h,010h,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,00ch,018h,01ch,01ch
	BYTE 01ch,01ch,01ch,02ch,029h,08eh,0b2h,0b2h,0b6h,0b7h,0b7h,0b6h,0b2h,092h,0b2h,092h
	BYTE 091h,095h,091h,049h,004h,071h,0b6h,0d6h,0adh,092h,0d7h,06eh,024h,044h,044h,085h
	BYTE 0c4h,060h,024h,096h,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0dbh,0bbh,09ah,029h
	BYTE 025h,025h,005h,025h,000h,000h,000h,000h,000h,000h,000h,000h,025h,001h,001h,005h
	BYTE 025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 025h,025h,000h,000h,000h,004h,004h,024h,024h,010h,01ch,01ch,0ffh,0ffh,06dh,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h
	BYTE 00ch,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,00ch,024h,069h,08eh,092h,0b6h,0b7h
	BYTE 0b6h,0b6h,0b6h,092h,092h,091h,091h,04dh,028h,000h,029h,096h,0b6h,0d6h,0b1h,08dh
	BYTE 0d7h,0d7h,08dh,084h,0a4h,0e9h,080h,064h,045h,096h,0bbh,0dbh,0dbh,0d7h,0dbh,0d7h
	BYTE 0d7h,0d7h,0dbh,0bbh,096h,025h,025h,025h,025h,025h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,005h,001h,001h,005h,025h,025h,025h,025h,025h,025h,025h,025h,025h,025h
	BYTE 025h,025h,025h,025h,005h,004h,004h,024h,004h,000h,000h,000h,004h,024h,024h,00ch
	BYTE 01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,008h
	BYTE 014h,00ch,000h,008h,010h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,00ch
	BYTE 000h,024h,069h,092h,092h,0b7h,0d7h,0b6h,096h,096h,091h,04dh,024h,000h,000h,004h
	BYTE 06dh,0bah,0d7h,0d7h,0d6h,0adh,0d6h,0d2h,0d1h,0a8h,088h,0c9h,0a8h,0c8h,0c9h,0b1h
	BYTE 0b6h,0b7h,0d7h,0d7h,0b7h,0d7h,0d7h,0d7h,0b7h,0bah,096h,025h,025h,025h,025h,025h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,001h,001h,001h,025h,025h,025h,025h
	BYTE 025h,025h,025h,025h,025h,025h,005h,004h,000h,000h,000h,004h,024h,024h,024h,000h
	BYTE 000h,000h,004h,024h,024h,02ch,01ch,01ch,0ffh,0ffh,06dh,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,004h,010h,018h,01ch,01ch,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,010h,000h,000h,049h,06eh,092h,0b2h,0b6h,0b6h,095h,04dh
	BYTE 028h,000h,000h,000h,004h,024h,096h,0b7h,0d7h,0d7h,0d6h,0b1h,0fah,0adh,0cdh,0c9h
	BYTE 0c9h,0c8h,0e9h,0c8h,0e9h,0e9h,0cdh,0b2h,0d2h,0b2h,0b6h,0b7h,0d7h,0d7h,0b7h,0bah
	BYTE 096h,025h,025h,025h,025h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,005h
	BYTE 005h,001h,025h,025h,025h,025h,025h,005h,005h,000h,000h,000h,000h,000h,004h,004h
	BYTE 024h,024h,024h,024h,004h,000h,000h,000h,000h,004h,004h,00ch,01ch,01ch,0ffh,0ffh
	BYTE 06dh,000h,000h,000h,000h,004h,008h,010h,018h,018h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,014h,000h,000h,04dh,092h
	BYTE 092h,092h,096h,071h,028h,000h,000h,000h,000h,000h,005h,025h,0b6h,0b7h,0d7h,0d7h
	BYTE 0d2h,089h,0f6h,0adh,0c9h,0e9h,0c9h,0e9h,0e9h,0e9h,0c9h,0e9h,0e9h,0edh,0c9h,08eh
	BYTE 0b2h,0b6h,0b7h,0b7h,0dbh,0bah,096h,005h,025h,025h,025h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,004h,004h,024h,000h,000h,004h,024h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,004h,024h,024h,024h,024h,024h,004h,004h,000h,000h,000h,004h,024h
	BYTE 024h,00ch,01ch,01ch,0ffh,0ffh,079h,014h,018h,018h,018h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,014h,000h,004h,096h,0b6h,0b6h,0b6h,071h,004h,000h,000h,000h,000h,000h,000h
	BYTE 005h,029h,0bah,0d6h,0f6h,0f6h,0d6h,08dh,0f6h,0d1h,0e9h,0e9h,0c8h,0e9h,0e9h,0c8h
	BYTE 0c9h,0e9h,0e9h,0edh,0a9h,06eh,092h,0b6h,0dbh,0b7h,0b7h,0bah,076h,025h,025h,025h
	BYTE 025h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,004h,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,024h,024h,024h,024h,004h,004h
	BYTE 000h,000h,000h,000h,004h,024h,004h,008h,01ch,01ch,0ffh,0ffh,07dh,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,034h,029h,000h,04dh,0b6h,0b6h,0b6h,0b6h,092h,024h
	BYTE 000h,000h,000h,000h,000h,004h,001h,025h,0b6h,0dah,0f6h,0f6h,0f6h,0f6h,0f6h,0d1h
	BYTE 0e9h,0e9h,0c9h,0e9h,0e9h,0e9h,0e9h,0e9h,0e9h,0e9h,089h,08eh,092h,0b6h,0b7h,0b7h
	BYTE 0b7h,0bah,072h,025h,005h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h
	BYTE 004h,004h,004h,004h,004h,000h,000h,000h,004h,004h,024h,024h,024h,028h,01ch,01ch
	BYTE 0ffh,0ffh,07dh,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,014h,004h,000h,024h,072h
	BYTE 0b6h,0b7h,0b6h,0b6h,071h,004h,000h,000h,000h,000h,001h,005h,025h,049h,0d6h,0fah
	BYTE 0f6h,0f6h,0f6h,0f6h,0d2h,0d1h,0c9h,0e9h,0c9h,0c9h,0e9h,0e9h,0c8h,0c9h,0c9h,0e9h
	BYTE 0a9h,06dh,092h,092h,0b6h,0b7h,0b6h,096h,04dh,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,004h,004h,004h,004h,004h,004h,004h,000h,000h,004h,004h
	BYTE 024h,024h,024h,028h,01ch,01ch,0ffh,0ffh,09ah,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,00ch,000h,000h,049h,0b6h,0b6h,0b6h,0b2h,0b6h,0b6h,071h,04dh,004h,000h,000h
	BYTE 000h,004h,025h,092h,0fbh,0fbh,0d6h,0f6h,0f6h,0f6h,0f6h,0f2h,0c9h,0c9h,0c9h,084h
	BYTE 084h,0c9h,0c4h,0c9h,0e9h,0e9h,0e9h,089h,06eh,06eh,092h,08eh,06dh,071h,028h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,004h,004h,004h,000h
	BYTE 004h,004h,004h,004h,004h,024h,024h,024h,024h,028h,01ch,01ch,0ffh,0ffh,09ah,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,018h,025h,000h,000h,029h,092h,0b6h,0b6h,0b2h,0b6h
	BYTE 0b6h,0bah,0b6h,071h,024h,000h,000h,000h,000h,0b2h,0fah,0f6h,0d6h,0d1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d1h,0cdh,088h,089h,069h,089h,0c9h,0c9h,0c9h,0e9h,0c9h,069h,049h,049h
	BYTE 049h,025h,049h,029h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 004h,024h,024h,024h,004h,004h,004h,004h,004h,004h,024h,024h,024h,024h,024h,008h
	BYTE 01ch,01ch,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh
	BYTE 0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh,0ffh

	brady2small EECS205BITMAP <71, 124, 255,, offset brady2small + sizeof brady2small>
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,038h,035h,02dh,028h,000h,000h,000h,024h,02ch,035h,038h,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,010h,008h,004h,000h,000h,000h,000h,000h
	BYTE 000h,004h,010h,014h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,00ch,004h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,00ch,038h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,038h,010h,004h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 000h,000h,004h,00ch,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,014h,004h,000h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,004h,010h,038h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 018h,008h,000h,000h,000h,020h,020h,000h,000h,000h,000h,000h,000h,024h,024h,000h
	BYTE 000h,000h,008h,034h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,014h,004h,000h,000h,000h,020h,000h,000h,004h
	BYTE 020h,000h,020h,000h,024h,020h,000h,000h,000h,004h,010h,038h,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,010h,004h
	BYTE 000h,000h,000h,000h,000h,000h,020h,024h,020h,020h,000h,020h,020h,020h,000h,000h
	BYTE 000h,00ch,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,038h,008h,004h,000h,000h,000h,000h,000h,000h,020h,020h,020h
	BYTE 000h,020h,000h,020h,020h,020h,020h,004h,00ch,038h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,008h,000h,020h,024h
	BYTE 024h,020h,020h,020h,020h,020h,044h,024h,024h,024h,044h,044h,064h,044h,028h,02ch
	BYTE 038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,034h,004h,000h,044h,064h,068h,064h,044h,044h,044h,044h,068h,044h,068h
	BYTE 089h,08dh,0adh,0adh,069h,048h,02ch,034h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,004h,000h,044h,069h,089h,089h
	BYTE 089h,08dh,089h,08dh,0adh,0adh,0b1h,0d1h,0d1h,0d1h,0d1h,08dh,024h,008h,034h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 034h,004h,000h,044h,069h,089h,08dh,0adh,0adh,0adh,0b1h,0d1h,0d1h,0d1h,0d5h,0d1h
	BYTE 0d1h,0d1h,08dh,024h,004h,034h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,004h,000h,024h,068h,068h,088h,0adh,0adh
	BYTE 0adh,0b1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d5h,0d1h,08dh,044h,004h,034h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,008h
	BYTE 000h,020h,064h,089h,08dh,0adh,0b1h,0b1h,0d1h,0d1h,0d1h,0f6h,0d5h,0d5h,0d5h,0b1h
	BYTE 0adh,044h,004h,030h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,038h,008h,000h,020h,044h,089h,08dh,0adh,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d5h,0d5h,0d1h,0d1h,0b1h,0adh,064h,024h,02ch,038h,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,00ch,000h,024h
	BYTE 044h,068h,08dh,0adh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h,0adh,068h
	BYTE 044h,04ch,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,034h,008h,000h,024h,044h,069h,08dh,08dh,0adh,0b1h,0b1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0b1h,0b1h,0adh,089h,068h,071h,058h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,008h,000h,024h,024h,024h
	BYTE 044h,044h,068h,088h,08dh,08dh,08dh,088h,068h,068h,088h,08dh,0adh,0adh,089h,091h
	BYTE 038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,034h,008h,004h,044h,024h,020h,020h,020h,020h,044h,089h,089h,064h,040h,040h
	BYTE 044h,064h,088h,0adh,0adh,089h,091h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,008h,004h,044h,044h,020h,020h,020h
	BYTE 020h,020h,064h,08dh,044h,040h,040h,064h,08dh,0b1h,0d1h,0b1h,0adh,095h,038h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h
	BYTE 00ch,024h,044h,089h,089h,069h,068h,064h,064h,0adh,0d2h,0adh,08dh,0adh,0adh,0d1h
	BYTE 0d1h,0d1h,0adh,0b1h,095h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,038h,02ch,024h,044h,089h,0adh,0adh,0d1h,0adh,089h
	BYTE 0adh,0d1h,0d1h,0d1h,0f6h,0f6h,0d2h,0d1h,0b1h,08dh,095h,079h,038h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,010h,004h
	BYTE 024h,068h,0adh,0adh,0adh,0adh,088h,0adh,0d1h,0d1h,0d1h,0d1h,0f6h,0d1h,0d1h,0b1h
	BYTE 06ch,074h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,018h,030h,028h,044h,088h,0adh,0adh,0adh,088h,0adh,0d1h
	BYTE 0b1h,0b1h,0b1h,0d1h,0d1h,0b1h,08dh,070h,058h,038h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,030h,024h
	BYTE 068h,088h,0adh,088h,064h,068h,0adh,088h,0adh,0b1h,0d1h,0cdh,0adh,06ch,074h,038h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,03ch,030h,024h,064h,088h,0adh,088h,060h,040h,044h,068h,0adh
	BYTE 0d1h,0d1h,0adh,08ch,06ch,054h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,024h,044h,088h
	BYTE 089h,088h,064h,064h,088h,0adh,0adh,0adh,0d1h,0adh,08ch,06ch,054h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,034h,028h,044h,068h,088h,064h,064h,064h,088h,088h,088h,088h,0adh
	BYTE 0adh,08ch,06ch,054h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,034h,028h,044h,064h,088h,088h
	BYTE 088h,089h,0a9h,0a8h,0adh,0d1h,0adh,0ach,08ch,04ch,054h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,038h
	BYTE 034h,035h,028h,044h,044h,088h,089h,088h,088h,088h,0a8h,0adh,0d1h,0adh,08dh,068h
	BYTE 050h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,03ch,014h,00ch,008h,00ch,008h,024h,044h,044h,064h,089h,089h,0adh
	BYTE 0adh,0cdh,0adh,0adh,0adh,088h,068h,071h,054h,038h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,038h,054h,030h,008h,004h,004h,024h
	BYTE 024h,044h,044h,044h,068h,0adh,0adh,0d1h,0d1h,0d1h,0adh,088h,068h,08dh,0b1h,071h
	BYTE 038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,038h,038h,058h
	BYTE 055h,075h,095h,049h,024h,025h,024h,044h,044h,044h,044h,064h,088h,088h,088h,0adh
	BYTE 0adh,088h,064h,088h,0b1h,0d1h,0b5h,079h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h
	BYTE 038h,038h,055h,075h,075h,095h,095h,095h,0b6h,0d6h,092h,049h,048h,024h,044h,044h
	BYTE 044h,044h,044h,064h,068h,068h,088h,088h,064h,064h,0adh,0d1h,0d1h,0d5h,0dah,099h
	BYTE 038h,018h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,038h,038h,038h,054h,075h,075h,095h,0b6h,0b6h,0b6h,0b6h,0d6h,0d6h
	BYTE 0d6h,0b6h,08dh,049h,044h,044h,044h,064h,044h,044h,064h,044h,044h,044h,064h,064h
	BYTE 088h,0d1h,0d1h,0d1h,0d6h,0fah,0dah,079h,058h,038h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,058h,074h,070h,070h,091h,0b6h,0dah
	BYTE 0b6h,0b6h,0b6h,0d6h,0b6h,0d6h,0d6h,0d6h,0d6h,0b6h,06dh,048h,044h,044h,044h,044h
	BYTE 064h,064h,064h,044h,044h,064h,088h,0d1h,0d1h,0d1h,0d5h,0fah,0fah,0dah,0dah,09ah
	BYTE 079h,059h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,054h
	BYTE 070h,091h,0b1h,0adh,0b1h,0d6h,0d6h,0b6h,0b6h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,092h,069h,044h,044h,044h,044h,064h,064h,064h,064h,064h,064h,0adh,0d1h,0d1h
	BYTE 0d1h,0d6h,0fah,0fah,0fbh,0fbh,0dah,0bah,09eh,059h,03ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,038h,034h,070h,08dh,0b1h,0d1h,0b1h,0b1h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,069h,044h,044h,044h,044h,064h
	BYTE 064h,064h,064h,088h,0d1h,0d1h,0d1h,0d6h,0d6h,0fah,0fah,0dah,0fbh,0fbh,0dbh,0dah
	BYTE 09ah,079h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,034h,050h,08dh,0b1h,0d1h
	BYTE 0d1h,0d1h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,092h,049h,044h,044h,044h,044h,064h,064h,088h,0b1h,0d1h,0d1h,0d2h,0d6h,0dah
	BYTE 0dah,0dah,0fbh,0dbh,0fbh,0dbh,0dah,0dah,0bah,059h,03ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,038h,050h,06ch,0b1h,0b1h,0d1h,0b1h,0d1h,0d1h,0d6h,0f6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,091h,069h,069h,069h,064h,044h,068h
	BYTE 0adh,0d2h,0d1h,0b1h,0d6h,0d6h,0dah,0dbh,0dah,0dah,0fbh,0fah,0dah,0dah,0dah,0dah
	BYTE 0bah,099h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,070h,08dh,0b1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d6h,0f6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah
	BYTE 0d6h,0b2h,0b2h,0b2h,08dh,069h,08dh,0d6h,0d6h,0d6h,0b1h,08dh,0b2h,0d6h,0dah,0dbh
	BYTE 0b6h,0b2h,0dah,0d6h,0dah,0dah,0dah,0dah,0bah,099h,059h,03ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,034h
	BYTE 070h,0adh,0b1h,0d1h,0d1h,0d1h,0d1h,0d5h,0d6h,0dah,0d6h,0d6h,0d6h,0d6h,0b2h,0b1h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,092h,06dh,08dh,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,08dh,069h,08dh,06dh,06dh,092h,0b6h,0dah,0d6h,0dah,0fah,0d6h,0dah,0dah
	BYTE 0bah,09ah,079h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,038h,050h,08dh,0d1h,0d1h,0d1h,0d1h,0d5h,0d5h,0d5h,0d6h
	BYTE 0d6h,0dah,0d6h,0d6h,0d6h,0b1h,08dh,0d6h,0d6h,0d6h,0d6h,0dah,0dah,0dah,0dah,0dah
	BYTE 0d6h,0d6h,08dh,08dh,0b2h,0b6h,0d6h,0d6h,0d6h,0b2h,069h,08dh,024h,000h,069h,0dah
	BYTE 0dbh,0b6h,08dh,0d6h,0d6h,0d6h,0dah,0dah,0dah,095h,075h,058h,038h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,054h,070h,0b1h,0d1h
	BYTE 0d1h,0d5h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0dah,0dah,0dah,0dah,0d6h,0d6h,091h,06dh,08dh,0b2h,0d6h,0d6h,0b6h
	BYTE 08dh,044h,091h,069h,000h,049h,0d6h,0fbh,0b6h,048h,091h,0d6h,0d6h,0d6h,0dah,0dah
	BYTE 0d6h,095h,095h,054h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,03ch,050h,06dh,0b1h,0d1h,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,0dah,0d6h,0b1h
	BYTE 0b6h,091h,092h,091h,0b2h,0d6h,08dh,024h,000h,049h,092h,044h,024h,092h,0dbh,0dbh
	BYTE 04dh,000h,06dh,0b6h,0dah,0d6h,0d6h,0d6h,0d1h,0b5h,095h,074h,038h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,050h,08dh,0b1h,0d1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d5h,0d5h,0d5h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,0d6h
	BYTE 0d6h,0dah,0dah,0dah,0d6h,0d6h,0b1h,0d6h,091h,06dh,08dh,091h,0b2h,0b2h,06dh,000h
	BYTE 024h,092h,0b6h,06dh,024h,049h,0b6h,092h,000h,024h,0b6h,0dah,0d6h,0d6h,0d1h,0d1h
	BYTE 0d6h,0b5h,095h,054h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 038h,04ch,0b1h,0d1h,0d1h,0f6h,0f6h,0f6h,0f6h,0d5h,0d1h,0d1h,0d1h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0dah,0dah,0d6h,0dah,0dah,0d6h,0d6h,0d6h,0dah,0d6h,08dh,0b6h,0b6h
	BYTE 08dh,069h,06dh,091h,0d6h,092h,000h,000h,049h,0b6h,0b6h,091h,024h,024h,06dh,024h
	BYTE 020h,0b2h,0d6h,0d6h,0d6h,0d2h,0d2h,0d6h,0d5h,0b5h,075h,038h,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,06ch,0b1h,0d1h,0d5h,0f6h,0f6h,0d6h,0d5h
	BYTE 0d1h,0d1h,0d1h,0b1h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0dah,0dah
	BYTE 0d6h,0d6h,0d6h,0b6h,08dh,0b2h,0b6h,0b6h,08dh,069h,08dh,0d6h,092h,020h,000h,000h
	BYTE 024h,049h,0b2h,06dh,000h,000h,000h,020h,092h,0d6h,0d6h,0d6h,0d6h,0f6h,0d6h,0d6h
	BYTE 0d5h,095h,054h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,034h,06ch
	BYTE 0b1h,0d1h,0d5h,0f6h,0f6h,0d6h,0d5h,0d1h,0d1h,0d1h,0adh,0d1h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0dah,0dah,0dah,0b6h,091h,0b6h,091h,069h,048h,069h,049h,08dh
	BYTE 0b2h,08dh,092h,08dh,000h,000h,000h,020h,000h,049h,0b6h,069h,000h,000h,000h,069h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d2h,0b5h,074h,038h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,038h,050h,091h,0d1h,0d1h,0d6h,0d6h,0d6h,0d5h,0d1h,0d1h,0d1h
	BYTE 0d1h,0adh,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,0d6h,08dh
	BYTE 06dh,069h,06dh,044h,020h,024h,06dh,048h,044h,06dh,024h,000h,000h,000h,000h,000h
	BYTE 024h,08dh,06dh,000h,000h,000h,024h,091h,0d6h,0d6h,0d6h,0f6h,0f6h,0d2h,0d6h,0b5h
	BYTE 074h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,050h,070h,0b1h,0d1h,0d1h
	BYTE 0d6h,0d6h,0d6h,0d5h,0d1h,0d1h,0d1h,0d1h,0adh,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,06dh,049h,08dh,048h,020h,020h,044h,024h,024h
	BYTE 024h,000h,000h,000h,000h,000h,000h,000h,024h,049h,020h,000h,020h,092h,0b6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b5h,075h,054h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,038h,050h,08dh,0d1h,0d1h,0d1h,0d6h,0d6h,0d6h,0d6h,0d5h,0d1h,0d1h,0d1h,0b1h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,0b2h
	BYTE 092h,06dh,044h,024h,024h,020h,020h,024h,000h,000h,000h,000h,000h,000h,000h,000h
	BYTE 048h,048h,000h,049h,0b6h,0dbh,0fah,0d6h,0d6h,0f6h,0d6h,0f6h,0d6h,0d5h,091h,054h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,034h,071h,0b1h,0d1h,0d1h,0f2h,0f6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d1h,0d1h,0d1h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0b6h,0b2h,0b1h,091h,0b2h,08dh,049h,024h,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,024h,06dh,069h,0b2h,0dbh,0d6h,0d6h,0d6h,0d6h
	BYTE 0f6h,0f6h,0d6h,0f6h,0d5h,091h,054h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,050h
	BYTE 091h,0d1h,0d1h,0d1h,0f2h,0f6h,0d6h,0d6h,0d6h,0d6h,0d5h,0d1h,0d1h,0d1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,0d6h,0b6h,0b2h,0b1h,0b6h,0b6h
	BYTE 0b6h,0b6h,06dh,06dh,049h,000h,000h,000h,000h,000h,000h,000h,000h,000h,000h,049h
	BYTE 0b6h,0dbh,0d6h,069h,044h,0b1h,0d6h,0f6h,0f6h,0f6h,0d6h,0d5h,091h,054h,03ch,01ch
	BYTE 01ch,01ch,01ch,01ch,03ch,054h,071h,0b1h,0d1h,0d1h,0d2h,0f6h,0f6h,0d6h,0d6h,0f6h
	BYTE 0d6h,0d6h,0d1h,0d1h,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0dah,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,0d6h,0d6h,0b2h,0b6h,08dh,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,000h,000h,000h,06dh,0b6h,0dah,091h,044h,08dh,0d6h,0f6h,0f6h
	BYTE 0f6h,0d6h,0d5h,091h,054h,03ch,01ch,01ch,01ch,01ch,01ch,038h,050h,091h,0b1h,0d1h
	BYTE 0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d1h,0b1h,0d1h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0b2h,0b1h,0b1h,0d6h,0d6h,0b6h,0d6h,0d6h,0d6h
	BYTE 0b6h,0d6h,0b2h,049h,024h,000h,000h,000h,000h,000h,000h,000h,000h,024h,069h,06dh
	BYTE 08dh,08dh,089h,0b1h,0d6h,0d6h,0f6h,0f6h,0d6h,0d5h,091h,054h,03ch,01ch,01ch,01ch
	BYTE 01ch,01ch,034h,070h,0b1h,0d1h,0d1h,0d1h,0d5h,0d6h,0d6h,0d6h,0d6h,0f6h,0f6h,0d6h
	BYTE 0d1h,0b1h,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,08dh,068h
	BYTE 069h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,08dh,044h,024h,000h,000h,000h
	BYTE 000h,000h,000h,000h,024h,06dh,091h,08dh,08dh,08dh,0d2h,0d6h,0d6h,0f6h,0d6h,0d5h
	BYTE 0d5h,091h,054h,03ch,01ch,01ch,01ch,01ch,038h,054h,091h,0d1h,0d1h,0d1h,0d1h,0d5h
	BYTE 0d5h,0d6h,0d6h,0d6h,0f6h,0d6h,0d6h,0d1h,0b1h,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,069h,068h,068h,0b2h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah
	BYTE 0dah,0b6h,06dh,049h,024h,000h,000h,000h,000h,000h,000h,020h,069h,08dh,08dh,0adh
	BYTE 0d1h,0d6h,0d6h,0d6h,0f6h,0d6h,0d5h,0b5h,095h,054h,01ch,01ch,01ch,01ch,01ch,038h
	BYTE 050h,0b1h,0d1h,0d1h,0d1h,0d1h,0d5h,0d5h,0d6h,0d6h,0f6h,0f6h,0f6h,0d1h,0b1h,0adh
	BYTE 0d1h,0d6h,0d6h,0d6h,0d6h,0b1h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,08dh,08dh,08dh,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0fah,0dah,0dah,0b6h,092h,049h,024h,000h,000h,000h
	BYTE 000h,000h,024h,044h,08dh,0b1h,0b1h,0d1h,0d6h,0d6h,0d6h,0f6h,0d6h,0d5h,0b5h,095h
	BYTE 058h,01ch,01ch,01ch,01ch,03ch,054h,070h,0b1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d5h,0d5h
	BYTE 0f6h,0f6h,0f6h,0d1h,0d1h,0adh,0adh,0b1h,0d6h,0d6h,0d6h,0b6h,091h,08dh,0b6h,0d6h
	BYTE 0d6h,0d6h,0d6h,091h,08dh,091h,0b6h,0d6h,0d6h,0d6h,0dah,0fah,0fah,0fbh,0dbh,0dbh
	BYTE 0dbh,0b6h,091h,049h,049h,024h,020h,024h,000h,000h,020h,068h,0b1h,0d1h,0d1h,0d5h
	BYTE 0d6h,0d6h,0f6h,0f6h,0d5h,0b5h,074h,058h,01ch,01ch,01ch,01ch,03ch,050h,090h,0b1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d5h,0d5h,0d1h,0d1h,0b1h,08dh,08dh,0b1h,0d6h
	BYTE 0d6h,0d6h,0d6h,0b1h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,08dh,0b6h,0d6h,0d6h,0d6h
	BYTE 0dah,0dah,0fbh,0fbh,0fbh,0fbh,0dbh,0dbh,0dbh,0d6h,092h,08dh,06dh,06dh,06dh,024h
	BYTE 000h,020h,068h,0d1h,0d5h,0d5h,0d6h,0f6h,0d6h,0f6h,0d6h,0d6h,0b5h,074h,058h,01ch
	BYTE 01ch,01ch,01ch,038h,050h,091h,0b1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,08dh,068h,08dh,0b1h,0b2h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,091h,0b6h,0d6h,0dah,0fah,0fbh,0fbh,0fbh,0dah,0dbh,0dbh,0fbh,0dbh,0dbh
	BYTE 0dbh,0d6h,0b6h,0b6h,0b6h,0b6h,044h,020h,044h,068h,0d1h,0d5h,0d5h,0d6h,0f6h,0f6h
	BYTE 0f6h,0f6h,0d6h,0b1h,074h,058h,01ch,01ch,01ch,01ch,038h,070h,0b1h,0b1h,0d1h,0d1h
	BYTE 0adh,0adh,0adh,0ach,0ach,0adh,0adh,0adh,0adh,088h,068h,0adh,0b1h,0d1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0dah,0fah,0fah,0fbh,0fah,0fbh
	BYTE 0fah,0fah,0fah,0dah,0fbh,0fbh,0fbh,0fbh,0fbh,0dbh,0dbh,0dbh,0dbh,069h,020h,044h
	BYTE 089h,0d1h,0d5h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0d6h,0b1h,074h,058h,01ch,01ch,01ch
	BYTE 038h,034h,070h,0adh,0adh,0cdh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0ach,0adh,0adh
	BYTE 088h,08ch,08dh,0adh,0b1h,0d1h,0d2h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0fah
	BYTE 0fah,0fah,0fah,0fah,0fah,0fah,0fah,0d6h,0b1h,0d6h,0d6h,0fah,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,08dh,044h,089h,0b1h,0d6h,0d6h,0f6h,0f6h,0f6h,0f6h,0f6h,0f6h
	BYTE 0d1h,0b5h,095h,058h,01ch,01ch,01ch,038h,030h,08ch,0adh,0adh,0cdh,0adh,0adh,0adh
	BYTE 0adh,0adh,0adh,0cdh,0cdh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh,0adh
	BYTE 0b1h,0adh,0adh,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0adh
	BYTE 08dh,08dh,0b1h,0d6h,0fah,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,08dh,068h,0b1h,0d6h,0d6h
	BYTE 0f6h,0f6h,0f6h,0f6h,0f6h,0f6h,0d5h,0d1h,0b1h,091h,074h,03ch,01ch,01ch,058h,050h
	BYTE 08ch,0adh,0adh,0adh,0adh,0b1h,0b1h,0b1h,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h,0b1h,0b1h
	BYTE 0b1h,0b1h,0d1h,0d1h,0b1h,0b1h,0b1h,0b1h,0adh,0adh,0b1h,0d1h,0d1h,0d1h,0d1h,0b1h
	BYTE 0b1h,0b1h,0b1h,0d1h,0b1h,0b1h,08ch,08ch,08dh,08ch,068h,08dh,0b1h,0dah,0fbh,0fbh
	BYTE 0fah,0fah,08dh,08dh,0d1h,0d6h,0d6h,0d6h,0d6h,0f6h,0f6h,0f6h,0f6h,0d6h,0d1h,0b1h
	BYTE 091h,074h,03ch,01ch,01ch,054h,050h,08dh,0adh,0cdh,0cdh,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h,0ach,0ach,08ch,08ch
	BYTE 08dh,08ch,068h,068h,08dh,0b1h,0d6h,0fah,0f6h,089h,0adh,0d1h,0d1h,0f6h,0f6h,0f6h
	BYTE 0f6h,0f6h,0f6h,0f6h,0d6h,0d1h,0b1h,091h,074h,03ch,01ch,01ch,074h,04ch,08dh,0adh
	BYTE 0cdh,0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0adh,0ach,08ch,08ch,08ch,08ch,08ch,08ch,08ch,088h,08dh,08dh,0b1h,0d2h
	BYTE 068h,08dh,0d1h,0d6h,0d6h,0d6h,0f6h,0f6h,0f6h,0d6h,0d6h,0d6h,0d1h,0d1h,0b1h,074h
	BYTE 03ch,01ch,01ch,071h,06ch,0adh,0cdh,0d1h,0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d5h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0adh,0ach,08ch,08ch,08ch,08ch,088h,088h
	BYTE 088h,088h,088h,088h,088h,08dh,08dh,068h,08dh,0d1h,0d6h,0d6h,0f6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d1h,0d1h,0b1h,074h,038h,01ch,01ch,071h,06ch,0adh,0cdh,0cdh,0cdh
	BYTE 0cdh,0cdh,0cdh,0cdh,0adh,0b1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0adh
	BYTE 08ch,088h,088h,088h,08ch,08ch,08dh,088h,088h,088h,088h,088h,08ch,088h,088h,088h
	BYTE 0adh,0d1h,0d6h,0f6h,0f6h,0d6h,0f6h,0f6h,0d6h,0d6h,0d1h,0d1h,0b1h,074h,038h,01ch
	BYTE 01ch,070h,04ch,0ach,0cdh,0cdh,0cdh,0cdh,0cdh,0cdh,0cdh,0adh,0adh,0b1h,0cdh,0cdh
	BYTE 0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0b1h,0adh,0adh,0adh,08ch,088h,088h,088h,088h,088h,088h,088h,088h,088h
	BYTE 088h,088h,08ch,088h,088h,068h,088h,088h,088h,0adh,0d2h,0f6h,0d6h,0f6h,0d6h,0d6h
	BYTE 0d6h,0f6h,0d1h,0b1h,094h,038h,01ch,01ch,054h,04ch,088h,0a8h,0adh,0adh,0cdh,0cdh
	BYTE 0cdh,0cdh,0adh,0adh,0adh,0cdh,0cdh,0cdh,0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0cdh,0adh,0adh,0adh,0adh,0adh,0adh,088h,088h,088h
	BYTE 088h,08ch,08ch,088h,088h,088h,088h,088h,088h,08ch,088h,088h,088h,088h,088h,068h
	BYTE 044h,0adh,0d6h,0d6h,0f6h,0d6h,0f6h,0f6h,0f2h,0d1h,0d1h,095h,038h,01ch,01ch,054h
	BYTE 02ch,088h,0a8h,0a8h,0ach,0adh,0adh,0cdh,0adh,0adh,0adh,0ach,0adh,0adh,0cdh,0d1h
	BYTE 0cdh,0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0adh,0adh,0adh
	BYTE 0adh,088h,088h,088h,088h,088h,088h,068h,088h,088h,088h,088h,088h,088h,088h,088h
	BYTE 088h,088h,088h,088h,088h,088h,088h,088h,0b1h,0d6h,0d6h,0d6h,0d6h,0f6h,0f6h,0f1h
	BYTE 0d1h,0d1h,094h,038h,01ch,01ch,038h,030h,06ch,088h,088h,088h,089h,0a9h,0adh,0adh
	BYTE 0a8h,0ach,0adh,0adh,0adh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0adh,0adh,0adh,08dh,088h,088h,088h,064h,064h,068h,068h,068h,068h,068h,068h
	BYTE 068h,068h,088h,088h,088h,088h,088h,088h,088h,08dh,088h,088h,088h,08dh,08dh,0b1h
	BYTE 0d5h,0d5h,0d5h,0d5h,0f5h,0f1h,0f1h,0d1h,0b1h,074h,038h,01ch,01ch,038h,034h,02ch
	BYTE 048h,068h,068h,068h,068h,088h,089h,0a9h,0adh,0adh,0adh,0adh,0b1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0adh,0adh,08dh,088h,088h,068h,068h,068h,064h,044h,040h
	BYTE 020h,044h,044h,044h,068h,068h,068h,068h,088h,088h,088h,088h,068h,088h,088h,088h
	BYTE 08dh,088h,088h,088h,08ch,08dh,0adh,0d1h,0d5h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h
	BYTE 074h,038h,01ch,01ch,01ch,01ch,014h,030h,008h,008h,024h,044h,068h,068h,088h,088h
	BYTE 088h,08dh,0adh,0adh,0adh,0adh,0adh,0adh,0b1h,0adh,0adh,0adh,088h,088h,064h,064h
	BYTE 044h,044h,044h,068h,068h,044h,044h,044h,044h,044h,044h,069h,068h,068h,068h,068h
	BYTE 088h,088h,088h,068h,068h,088h,088h,088h,088h,088h,088h,088h,08ch,08ch,0adh,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h,074h,038h,01ch,01ch,01ch,01ch,01ch,038h,038h
	BYTE 034h,030h,02ch,028h,024h,044h,044h,064h,064h,064h,088h,088h,088h,088h,088h,088h
	BYTE 068h,088h,088h,0adh,088h,064h,068h,089h,089h,08dh,0adh,0b1h,091h,069h,048h,044h
	BYTE 044h,048h,069h,044h,044h,048h,068h,068h,068h,088h,088h,088h,068h,068h,068h,088h
	BYTE 088h,088h,088h,088h,088h,0adh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h,074h,03ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,038h,034h,02ch,024h,024h,044h
	BYTE 064h,064h,064h,064h,064h,064h,064h,064h,068h,088h,088h,088h,088h,0adh,0adh,0adh
	BYTE 0adh,0d5h,0d6h,0d6h,0b1h,08dh,08dh,068h,069h,069h,020h,024h,044h,064h,068h,068h
	BYTE 068h,068h,088h,068h,064h,068h,088h,088h,088h,088h,068h,088h,088h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,091h,074h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,058h,050h,024h,048h,069h,068h,068h,088h,088h,088h,068h,068h,088h,088h
	BYTE 0ach,088h,0ach,0ach,0ach,0adh,0adh,0ach,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,08dh,08dh
	BYTE 08dh,069h,044h,044h,044h,044h,044h,044h,068h,068h,068h,068h,068h,088h,088h,088h
	BYTE 088h,068h,088h,068h,0adh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,091h,054h,03ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,034h,04ch,048h,068h,068h,088h,088h
	BYTE 088h,068h,068h,088h,088h,088h,088h,0adh,088h,0ach,0ach,0ach,0adh,0d1h,0d1h,0d1h
	BYTE 0adh,0adh,0adh,0adh,0adh,0adh,0b1h,0b1h,0b1h,08dh,069h,048h,044h,044h,044h,044h
	BYTE 068h,068h,068h,068h,068h,088h,088h,088h,088h,068h,068h,0adh,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,091h,054h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h
	BYTE 02ch,048h,068h,068h,068h,088h,088h,088h,088h,068h,088h,068h,088h,088h,08ch,088h
	BYTE 0ach,0ach,0ach,0cdh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0cdh,0adh,0adh,0b1h,0b1h,0b6h
	BYTE 0d6h,0b6h,092h,069h,044h,044h,044h,044h,044h,064h,068h,044h,064h,068h,068h,068h
	BYTE 064h,068h,08dh,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h,074h,058h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,038h,02ch,024h,044h,068h,088h,088h,088h,088h,088h,088h
	BYTE 068h,088h,068h,088h,088h,088h,088h,08ch,0ach,0adh,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0adh,0d1h,0d1h,0b1h,0d6h,0dah,0d6h,0b2h,08dh,048h,044h,044h,044h
	BYTE 064h,064h,064h,064h,064h,064h,068h,044h,068h,0adh,0d1h,0d1h,0d1h,0d1h,0d1h,0b1h
	BYTE 074h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,028h,024h,044h
	BYTE 068h,068h,068h,088h,088h,088h,088h,088h,088h,088h,088h,088h,088h,088h,088h,088h
	BYTE 0ach,0d1h,0d5h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0adh,0d1h,0d5h,0d1h,0d2h,0d6h
	BYTE 0fah,0dah,0b2h,092h,069h,044h,044h,064h,064h,064h,064h,068h,068h,068h,044h,064h
	BYTE 08dh,0adh,0d1h,0d1h,0d1h,0d1h,0b1h,074h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,038h,054h,048h,044h,068h,064h,064h,064h,068h,068h,068h,068h,088h,088h
	BYTE 088h,068h,08dh,088h,088h,068h,088h,088h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h,0d1h
	BYTE 0adh,0adh,0d1h,0d1h,0d1h,0b1h,0b2h,0d6h,0fah,0fbh,0d6h,0b6h,06dh,049h,044h,044h
	BYTE 044h,068h,068h,068h,068h,068h,064h,0adh,0d1h,0cdh,0d1h,0d1h,0d1h,091h,054h,038h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h,055h,02ch,048h,068h,068h,064h,064h
	BYTE 064h,064h,068h,068h,068h,068h,088h,088h,064h,088h,088h,088h,088h,088h,088h,0adh
	BYTE 0adh,0adh,0adh,0adh,0adh,0d1h,0d1h,0adh,0adh,0d1h,0d1h,0d1h,0d1h,0b1h,0b1h,0d6h
	BYTE 0dah,0dah,0dah,0b6h,0b2h,08dh,048h,044h,048h,068h,068h,068h,064h,064h,0b1h,0d1h
	BYTE 0d1h,0d1h,0d1h,0d1h,091h,054h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h
	BYTE 075h,024h,024h,044h,068h,068h,044h,044h,044h,068h,068h,064h,068h,068h,068h,064h
	BYTE 088h,088h,088h,088h,084h,088h,0adh,0d1h,0d1h,0adh,0adh,0adh,0adh,0adh,08ch,0adh
	BYTE 0d1h,0d1h,0d1h,0b1h,0adh,08dh,0b2h,0b1h,0b6h,0d6h,0dah,0dah,0dbh,0b6h,069h,044h
	BYTE 048h,069h,069h,068h,068h,0b1h,0d1h,0d1h,0d1h,0d1h,0b1h,070h,058h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,05dh,0bah,049h,024h,020h,064h,064h,020h,020h,044h
	BYTE 064h,068h,064h,064h,068h,068h,068h,068h,088h,088h,088h,088h,088h,089h,0adh,0adh
	BYTE 0adh,0ach,0ach,0adh,0adh,088h,0adh,0d1h,0adh,0adh,0adh,0adh,08ch,08dh,069h,06dh
	BYTE 08dh,0b2h,0d6h,0fbh,0fbh,0dah,08dh,048h,069h,08dh,0b1h,0b1h,0b1h,0b1h,0d1h,0d1h
	BYTE 0d1h,0b1h,070h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,07dh,096h,048h
	BYTE 044h,044h,068h,044h,044h,044h,064h,064h,068h,068h,068h,068h,068h,068h,088h,089h
	BYTE 088h,064h,064h,068h,068h,064h,064h,088h,088h,0a8h,0a8h,088h,068h,0adh,0d1h,0ach
	BYTE 0ach,0ach,0ach,088h,089h,088h,044h,044h,044h,091h,0dah,0fbh,0fbh,0fbh,0b6h,091h
	BYTE 0b6h,0fah,0d6h,0b1h,0b1h,0d1h,0d1h,0b1h,090h,074h,03ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,038h,09dh,096h,048h,020h,024h,044h,068h,068h,068h,068h,068h,064h
	BYTE 068h,068h,068h,068h,068h,068h,089h,068h,064h,068h,068h,068h,064h,064h,068h,088h
	BYTE 089h,088h,088h,068h,08dh,0b1h,08ch,0ach,0a8h,0a8h,088h,089h,089h,064h,040h,020h
	BYTE 044h,091h,0d6h,0dah,0fbh,0fbh,0fbh,0fbh,0fbh,0fah,0d1h,0b1h,0adh,0cdh,0adh,070h
	BYTE 054h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,059h,0bah,0dah,0b2h,049h,044h
	BYTE 024h,044h,044h,044h,068h,068h,044h,068h,068h,064h,068h,068h,069h,069h,068h,068h
	BYTE 068h,069h,08dh,0b1h,08dh,089h,068h,068h,068h,068h,068h,088h,0b1h,088h,088h,088h
	BYTE 088h,088h,088h,088h,064h,040h,020h,020h,044h,08dh,0b6h,0d6h,0dah,0fbh,0fbh,0dah
	BYTE 0d6h,0d1h,0adh,0adh,0adh,08ch,050h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 03ch,079h,0bah,0dah,0dah,0dah,0b6h,091h,091h,091h,0b2h,0b2h,0b2h,0b1h,0b2h,0b2h
	BYTE 0b6h,0d6h,0d6h,0d6h,0b2h,0b6h,0b2h,0b2h,0b6h,0d6h,0d6h,0d6h,0b2h,08dh,069h,068h
	BYTE 044h,044h,068h,08dh,068h,068h,088h,088h,088h,089h,089h,064h,044h,020h,020h,000h
	BYTE 024h,069h,092h,0d6h,0d6h,0d6h,0dah,0fah,0d6h,0adh,088h,088h,06ch,054h,038h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,05ch,09ah,0dah,0d6h,0dah,0dbh,0dah,0dah,0dah
	BYTE 0dah,0dah,0dah,0fah,0dah,0dah,0dah,0dah,0fah,0fah,0dah,0dah,0dah,0dah,0dah,0dah
	BYTE 0dah,0d6h,0d6h,0d6h,0d6h,0b1h,08dh,068h,044h,048h,068h,020h,044h,044h,044h,064h
	BYTE 064h,068h,068h,044h,020h,020h,020h,020h,024h,069h,0b2h,0b2h,0b6h,0dah,0dah,0dah
	BYTE 0b1h,06ch,04ch,050h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,05dh,0bah
	BYTE 0d6h,0d6h,0d6h,0dah,0dah,0dah,0dah,0dah,0dah,0dah,0dah,0dah,0dah,0fbh,0fbh,0fbh
	BYTE 0dbh,0dah,0dah,0dah,0fbh,0fbh,0fah,0dah,0d6h,0d6h,0d6h,0d6h,0d6h,0b1h,06dh,048h
	BYTE 048h,024h,020h,020h,020h,020h,020h,020h,024h,044h,044h,024h,024h,020h,024h,024h
	BYTE 024h,048h,069h,091h,0b6h,0dah,0dah,0dah,091h,054h,038h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,059h,09ah,0b6h,0d6h,0d6h,0dah,0dah,0d6h,0d6h,0dah,0dah
	BYTE 0dah,0dah,0dah,0dah,0dah,0fbh,0fbh,0fbh,0dah,0dah,0fbh,0dah,0dah,0dah,0dah,0d6h
	BYTE 0d6h,0dah,0d6h,0d6h,0b2h,091h,08dh,08dh,06dh,069h,069h,048h,044h,044h,024h,024h
	BYTE 024h,024h,020h,024h,020h,000h,020h,024h,024h,044h,069h,091h,0d6h,0dah,0dah,099h
	BYTE 038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,058h,099h,0b6h,0b6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,0d6h,0d6h,0dah,0dah,0fbh,0fbh,0fbh,0dbh
	BYTE 0dah,0dah,0dbh,0fbh,0dah,0dah,0dah,0dah,0d6h,0d6h,0d6h,0b6h,0b2h,0b1h,0b2h,0d6h
	BYTE 0b6h,0b6h,0b6h,0b2h,091h,06dh,048h,024h,024h,024h,024h,024h,020h,000h,020h,044h
	BYTE 08dh,091h,091h,0b2h,0dah,0dah,09ah,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,038h,099h,0b6h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h
	BYTE 0d6h,0dah,0dah,0dbh,0fbh,0fbh,0dah,0dah,0dah,0fah,0dah,0dah,0dah,0d6h,0d6h,0d6h
	BYTE 0d6h,0b2h,0b2h,0b2h,0b1h,0b1h,0b1h,0b1h,0b1h,0b1h,0b2h,0d6h,0d6h,0b2h,069h,044h
	BYTE 044h,024h,024h,024h,049h,044h,049h,0b6h,0dah,0b6h,091h,0dah,0dah,0bah,079h,038h
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,03ch,075h,0b6h,0b6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0dah,0dah,0dbh,0dbh,0fbh,0dah,0dah,0dah
	BYTE 0fah,0dah,0dah,0d6h,0d6h,0d6h,0d6h,0d6h,0b1h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0dah,0d6h,0b2h,06dh,048h,048h,024h,048h,069h,048h,048h,0b6h,0dah
	BYTE 0dah,095h,0b6h,0dah,0dah,0bah,059h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,03ch,075h,096h,091h,0b2h,0b6h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0dah
	BYTE 0dbh,0fbh,0fbh,0fbh,0dah,0dah,0dah,0dah,0dah,0dah,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h
	BYTE 0d6h,0dah,0d6h,0d6h,0dah,0d6h,0d6h,0d6h,0d6h,0b6h,0b2h,0b2h,0b1h,08dh,049h,044h
	BYTE 048h,048h,06dh,091h,048h,0b2h,0dah,0dah,095h,095h,0b6h,0dah,0dah,09ah,058h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,095h,0b6h,091h,091h,0b2h,0b6h,0b6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0dbh,0fbh,0fbh,0fbh,0fbh,0dah,0d6h,0d6h,0dah,0dah
	BYTE 0dah,0dah,0d6h,0d6h,0d6h,0d6h,0b2h,0d6h,0d6h,0d6h,0dah,0d6h,0d6h,0b6h,0b2h,0b6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0b6h,091h,069h,049h,049h,049h,091h,069h,0b2h,0dah,0dah,0bah
	BYTE 075h,0b5h,0d6h,0dah,0dah,079h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h
	BYTE 09ah,0b6h,0b1h,0b1h,0b1h,0b6h,0b6h,0b6h,0b6h,0d6h,0d6h,0d6h,0d6h,0fbh,0fbh,0fbh
	BYTE 0fbh,0dbh,0d6h,0b2h,0b2h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0dah,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,06dh,069h
	BYTE 049h,06dh,069h,0b1h,0dah,0dah,0bah,075h,091h,0b6h,0dah,0dah,0bah,079h,038h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,059h,0bah,0b2h,0b2h,0b2h,0b1h,0b2h,0b1h,0b2h,0b6h
	BYTE 0d6h,0d6h,0dah,0dah,0fbh,0fbh,0fbh,0fbh,0d6h,0b2h,091h,091h,0b1h,0b2h,0b6h,0b2h
	BYTE 0b1h,0b6h,0d6h,0d6h,0d6h,0dah,0d6h,0dah,0dah,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0b6h,0b6h,0d6h,08dh,069h,049h,069h,048h,0b2h,0d6h,0d6h,0bah,095h,071h
	BYTE 095h,0dah,0dah,0dah,0bah,05dh,03ch,01ch,01ch,01ch,01ch,01ch,03ch,059h,0bah,0b2h
	BYTE 0b1h,0b2h,0b2h,091h,08dh,091h,0b6h,0d6h,0dah,0dah,0dbh,0fbh,0fbh,0fbh,0dbh,0d6h
	BYTE 0b6h,0b2h,0b6h,0d6h,0dah,0dah,0d6h,0b2h,0b1h,0b1h,0b2h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,0b6h,0d6h,0d6h,0d6h,0d6h,092h,06dh,06dh,06dh
	BYTE 048h,08dh,08dh,0b6h,0dah,09ah,054h,075h,099h,0bah,0dah,0dah,099h,058h,03ch,01ch
	BYTE 01ch,01ch,01ch,03ch,059h,096h,0b2h,08dh,08dh,0b1h,0b1h,091h,08dh,091h,0b6h,0dah
	BYTE 0dah,0fbh,0fbh,0fbh,0fbh,0dbh,0d6h,0d6h,0fah,0fah,0fbh,0fbh,0fbh,0fbh,0fah,0d6h
	BYTE 0d6h,0b1h,08dh,08dh,0b1h,0b2h,0b2h,0d6h,0d6h,0b6h,0b2h,0b6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0dah,0dah,091h,06dh,08eh,049h,048h,069h,0b6h,0dah,0bah,079h,054h,055h
	BYTE 099h,0b6h,0dah,0bah,095h,058h,03ch,01ch,01ch,01ch,01ch,058h,095h,0b2h,0b2h,08dh
	BYTE 069h,068h,069h,069h,08dh,0b6h,0dah,0dbh,0dbh,0fbh,0fbh,0fbh,0dah,0dah,0dah,0fah
	BYTE 0fbh,0fbh,0fbh,0fbh,0fbh,0dah,0d6h,0f6h,0d6h,0d6h,0b2h,0b1h,08dh,069h,08dh,0b1h
	BYTE 0b6h,0d6h,0d6h,0dah,0d6h,0d6h,0fah,0dah,0fah,0dah,0dah,0b6h,06dh,06dh,06dh,049h
	BYTE 06dh,0b2h,0dah,0dah,099h,059h,038h,058h,075h,091h,091h,06dh,071h,075h,038h,01ch
	BYTE 01ch,01ch,038h,075h,0b5h,0b6h,0b2h,0b2h,08dh,068h,044h,06dh,0b6h,0dah,0fbh,0fbh
	BYTE 0fbh,0dbh,0fbh,0dah,0dah,0dah,0fah,0fbh,0fbh,0fbh,0fbh,0fbh,0d6h,069h,069h,089h
	BYTE 08dh,08dh,08dh,089h,068h,068h,069h,069h,069h,091h,0d6h,0dah,0d6h,0dah,0dah,0fah
	BYTE 0d6h,0dah,0d6h,06dh,06dh,06dh,049h,091h,091h,0d6h,0dah,0bah,079h,03ch,038h,054h
	BYTE 04ch,04ch,071h,06ch,050h,058h,01ch,01ch,01ch,038h,079h,095h,0b6h,0d6h,0d6h,0b6h
	BYTE 0b2h,069h,08dh,0d6h,0dah,0dah,0fbh,0fbh,0fbh,0fbh,0d6h,0d6h,0dah,0fah,0fbh,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,069h,044h,044h,044h,044h,044h,068h,068h,069h,08dh,08dh,08dh
	BYTE 08dh,0b1h,0b6h,0d6h,0d6h,0d6h,0f6h,0f6h,0dah,0d6h,08dh,069h,06dh,048h,06dh,06dh
	BYTE 091h,091h,071h,054h,038h,01ch,038h,030h,02ch,02ch,02ch,030h,034h,01ch,01ch,01ch
	BYTE 01ch,058h,079h,095h,0d6h,0d6h,0d6h,0b6h,092h,092h,0d6h,0dah,0fah,0dah,0fbh,0fbh
	BYTE 0fbh,0d6h,0d6h,0d6h,0fah,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,091h,068h,064h,068h,089h
	BYTE 08dh,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,08dh,06dh,069h,069h,069h,0adh,0d2h,0d6h
	BYTE 0d6h,06dh,049h,069h,048h,04ch,050h,04ch,04ch,02ch,034h,01ch,01ch,01ch,038h,038h
	BYTE 034h,038h,038h,038h,01ch,01ch,01ch,01ch,01ch,038h,075h,095h,0b6h,0b6h,0b6h,0b2h
	BYTE 091h,0b6h,0dah,0dah,0dah,0dbh,0fbh,0dbh,0b6h,0b1h,0b2h,0dah,0fbh,0fbh,0fbh,0fbh
	BYTE 0fbh,0fbh,0d6h,08dh,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h
	BYTE 0b6h,0b2h,0b1h,091h,08dh,0b1h,0b1h,0b2h,06dh,049h,06dh,04dh,030h,058h,038h,038h
	BYTE 038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,058h,075h,0b6h,0b6h,0b6h,0b2h,08dh,0b2h,0dah,0dah,0dbh,0fbh,0fbh,0dah,0b6h
	BYTE 091h,0b2h,0d6h,0fbh,0fbh,0fbh,0fbh,0fbh,0fbh,0fah,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0b1h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,08dh
	BYTE 049h,049h,04ch,030h,038h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,054h,095h,0b6h,0b6h,0b2h,08dh,0b2h
	BYTE 0d6h,0dah,0dah,0fbh,0fbh,0dah,0b2h,0b1h,0b6h,0d6h,0dah,0dbh,0fbh,0dbh,0fbh,0fbh
	BYTE 0fah,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,091h,049h,049h,04dh,059h,038h,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,018h
	BYTE 010h,04ch,091h,0b2h,0b2h,08dh,0d6h,0dah,0dah,0dbh,0fbh,0fbh,0d6h,08dh,08dh,0b2h
	BYTE 0b6h,0d6h,0dbh,0dbh,0dbh,0fbh,0fbh,0fbh,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,06dh,049h
	BYTE 04dh,059h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,038h,00ch,028h,06dh,092h,08dh,08dh,0d6h,0dah,0d6h
	BYTE 0dah,0fbh,0fbh,0d6h,08dh,068h,068h,06dh,0b2h,0dbh,0fbh,0fbh,0fbh,0fbh,0fbh,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,092h,04dh,02ch,055h,038h,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,00ch,008h
	BYTE 045h,044h,048h,091h,0dah,0dah,0dah,0fbh,0fbh,0dbh,0b2h,08dh,068h,068h,044h,08dh
	BYTE 0dah,0fbh,0dbh,0fbh,0fbh,0fah,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,06dh,04dh,030h
	BYTE 038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,034h,008h,028h,025h,024h,044h,0b6h,0dah,0dah,0dah,0fbh,0fbh
	BYTE 0fbh,0b2h,0b1h,0b1h,08dh,048h,044h,0b6h,0fbh,0dbh,0fbh,0fbh,0fbh,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d5h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,091h,04ch,030h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,008h,028h,024h,024h
	BYTE 044h,0b6h,0dah,0d6h,0dah,0dbh,0fbh,0fbh,0b2h,0b1h,0d6h,0d6h,08dh,044h,0b6h,0fbh
	BYTE 0fbh,0fbh,0fbh,0fbh,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,06dh,030h,038h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,010h,008h,028h,024h,044h,044h,092h,0dah,0d6h,0dah,0fbh,0fbh,0dah,0b6h
	BYTE 0b1h,0d6h,0d6h,0b1h,069h,0b6h,0fbh,0dbh,0fbh,0fbh,0fbh,0d6h,0b6h,0d6h,0d6h,0d6h
	BYTE 0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b2h,0d2h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,091h,075h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,02ch,028h,028h,049h,049h,024h,06dh
	BYTE 0d6h,0d6h,0d6h,0dbh,0fbh,0dah,0d6h,0b1h,0d6h,0d6h,0b6h,069h,0d6h,0fbh,0dah,0dbh
	BYTE 0fbh,0fbh,0dah,0d6h,0d6h,0d6h,0d1h,0d5h,0d6h,0b1h,0b1h,0b1h,0d6h,0d6h,0d6h,0d6h
	BYTE 0b2h,0b2h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0bah,099h,058h,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h
	BYTE 051h,04dh,06dh,06dh,049h,024h,048h,091h,0d6h,0dah,0dah,0fbh,0fbh,0d6h,0b1h,0d6h
	BYTE 0d6h,0b1h,068h,0b6h,0dah,0dbh,0dbh,0fbh,0fbh,0fah,0d6h,0d6h,0d6h,0d1h,0d6h,0d5h
	BYTE 0b1h,0b1h,0b1h,0d6h,0d6h,0d6h,0b1h,0b1h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0bah,099h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,038h,075h,091h,092h,091h,048h,044h,024h,049h,0b2h
	BYTE 0d6h,0dah,0dah,0fbh,0dah,0b2h,0d6h,0d6h,0b1h,044h,069h,0b2h,0dah,0fbh,0fbh,0fbh
	BYTE 0fbh,0d6h,0b6h,0b2h,0d6h,0d5h,0d1h,0d6h,0d6h,0d6h,0d6h,0d6h,0b1h,0b1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b5h,079h,038h,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,034h,071h,0b2h
	BYTE 0b6h,08dh,048h,024h,024h,024h,06dh,0d6h,0dah,0dah,0fah,0fah,0d6h,0d6h,0d6h,0b1h
	BYTE 044h,024h,048h,092h,0dah,0fbh,0fbh,0fbh,0fah,0d6h,0d6h,0d6h,0b1h,0b1h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d5h,0b1h,0b6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,099h
	BYTE 059h,03ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,03ch,034h,091h,0b2h,0b2h,06dh,048h,028h,024h,024h,069h,0b6h,0dah
	BYTE 0dah,0dah,0dah,0dah,0dah,0d6h,0d6h,091h,068h,020h,049h,0b6h,0dbh,0fbh,0fbh,0fbh
	BYTE 0d6h,0d6h,0d6h,0b1h,0b1h,0d5h,0d5h,0d6h,0d6h,0d5h,0b5h,0b6h,0d6h,0d6h,0b6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,099h,058h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,038h,034h,095h,0b2h,091h,049h
	BYTE 049h,049h,029h,028h,048h,0b2h,0dah,0fah,0dah,0dah,0fbh,0dah,0d6h,0d6h,0d6h,0b1h
	BYTE 048h,049h,0b6h,0dah,0dah,0fbh,0fbh,0fah,0dah,0d6h,0b1h,0d5h,0d5h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0b6h,0b6h,099h,038h,01ch
	BYTE 01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,038h,034h,095h,0b6h,0b2h,049h,049h,049h,049h,049h,044h,08dh,0d6h,0dah,0dah
	BYTE 0dbh,0fbh,0fah,0dah,0d6h,0d6h,0d6h,069h,048h,0b2h,0d6h,0dah,0fbh,0fbh,0fbh,0fah
	BYTE 0d6h,0b1h,0d5h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h,0d6h
	BYTE 0d6h,0d6h,0b6h,0b6h,079h,038h,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch,01ch
	BYTE 01ch,01ch,01ch,01ch



 lynch SPRITE <>
 brady SPRITE <>
 stringer BYTE "Collision"
 lynchrect EECS205RECT <>
 mouseclick BYTE "CLICK"
 bradyrect EECS205RECT <>
  spacer BYTE "SPACE"
;; If you need to, you can place global variables here


;;COMMENT STUFF HERE:

;To play as Beast Mode to avoid a rampant brady being flown at you press space brady

;to avoid Beast Mode as brady press the left mouse

.CODE

GameInit PROC USES ebx ecx esi
	;get rid of background stuff
	invoke PlaySound, offset SndPath, 0, SND_ASYNC 
	rdtsc
	invoke nseed, eax 
	mov lynch2small.bTransparent, 01ch  
	mov brady2small.bTransparent, 01ch  
	;set lynch xpos ypos and bmp
	mov lynch.xPOS, 300  ;lynch position
	mov lynch.yPOS, 350
	mov lynch.bmp, OFFSET lynch2small
	;dealing with "gravity"
	mov lynch.VEL, 0
	mov lynch.ACCEL, -3
	;set brady xpos ypos and bmp
	;dealing with "gravity"
	mov brady.xPOS, 599
	mov brady.yPOS, 350
	mov brady.bmp, OFFSET brady2small
	mov brady.VEL, 0
	mov brady.xVEL, 11
	mov brady.ACCEL, 3
	mov brady.up, 0

	;MARSHAWN LYNCH
	mov esi,  lynch.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, lynch.yPOS
	mov lynchrect.dwBottom, ecx

	;getting the bottom
	mov ecx, lynch.yPOS
	sub ecx, ebx
	mov lynchrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, lynch.xPOS
	mov lynchrect.dwRight, ecx

	;getting the left
	mov ecx, lynch.xPOS
	sub ecx, ebx
	mov lynchrect.dwLeft, ecx

	;tom brady
	mov esi, brady.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, brady.yPOS
	mov bradyrect.dwBottom, ecx

	;getting the bottom
	mov ecx, brady.yPOS
	sub ecx, ebx
	mov bradyrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, brady.xPOS
	mov bradyrect.dwRight, ecx

	;getting the left
	mov ecx, brady.xPOS
	sub ecx, ebx
	mov bradyrect.dwLeft, ecx

	
	ret         ;; Do not delete this line!!!
GameInit ENDP


GamePlay PROC USES ebx ecx edx esi
	INVOKE BlackStarField

	mov ecx, KeyPress
	cmp ecx, 20h
	jne afterkeys
	cmp lynch.jmpState, 0
	jne afterkeys
	mov lynch.jmpState, 1
	mov lynch.VEL, 40

	INVOKE DrawStr, OFFSET spacer, 250, 100, 255




afterkeys:

	;this deals with lynch jumping
	cmp lynch.jmpState, 1
	jne drawstuff
	mov ebx, lynch.VEL
	add ebx, lynch.ACCEL
	mov ecx, ebx
	mov lynch.VEL, ebx
	mov edx, lynch.yPOS
	sub edx, ebx
	mov lynch.yPOS, edx

	
	mov edx, lynchrect.dwTop
	sub edx, ecx
	mov lynchrect.dwTop, edx
	mov edx, lynchrect.dwBottom
	sub edx, ecx
	mov lynchrect.dwBottom, edx
	cmp lynch.yPOS,350
	jle drawstuff
	mov lynch.yPOS, 350
	;ADD STUFF FOR DWTOP HERE AS WELL
	mov lynch.jmpState,0
	;MARSHAWN LYNCH
	mov esi,  lynch.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, lynch.yPOS
	mov lynchrect.dwBottom, ecx

	;getting the bottom
	mov ecx, lynch.yPOS
	sub ecx, ebx
	mov lynchrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, lynch.xPOS
	mov lynchrect.dwRight, ecx

	;getting the left
	mov ecx, lynch.xPOS
	sub ecx, ebx
	mov lynchrect.dwLeft, ecx




drawstuff:	
	;basically if he's not already jumping make him jump
	cmp brady.jmpState, 1
	je bradyjump
	mov ecx, Offset MouseStatus
	mov ebx, (MouseInfo PTR [ecx]).buttons
	cmp ebx, MK_LBUTTON
	jne actuallydraw
	xor ebx, ebx
	mov bl, brady.up
	cmp bl, 1
	jne actuallydraw
	mov brady.jmpState, 1
	mov brady.VEL, 40

;this part is if we know brady is supposed to be jumping
bradyjump:
	mov ebx, brady.xPOS
	cmp brady.xPOS, 0
	jle actuallyreset
	mov ebx, brady.VEL
	sub ebx, brady.ACCEL
	mov ecx, ebx
	mov brady.VEL, ebx
	mov edx, brady.yPOS
	add edx, ebx
	mov brady.yPOS, edx
	;basically adding acceleration to velocity every time then "subtracting" (bc of way screen is made up) to the position
	mov edx, bradyrect.dwTop
	add edx, ecx
	;this part is for the rectangles
	mov bradyrect.dwTop, edx
	mov edx, bradyrect.dwBottom
	add edx, ecx
	mov bradyrect.dwBottom, edx
	cmp brady.yPOS, 250
	jge actuallydraw

	mov brady.yPOS, 250
	mov brady.jmpState, 0
	mov esi, brady.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	sub ecx, brady.yPOS
	mov bradyrect.dwBottom, ecx

	;getting the bottom
	mov ecx, brady.yPOS
	add ecx, ebx
	mov bradyrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	sub ecx, brady.xPOS
	mov bradyrect.dwRight, ecx

	;getting the left
	mov ecx, brady.xPOS
	add ecx, ebx
	mov bradyrect.dwLeft, ecx


actuallydraw:
	mov ebx, brady.xPOS
	mov ecx, brady.xVEL
	sub ebx, ecx
	mov brady.xPOS, ebx
	mov ebx, bradyrect.dwLeft
	sub ebx, ecx
	mov bradyrect.dwLeft, ebx
	mov ebx, bradyrect.dwRight
	sub ebx, ecx
	mov bradyrect.dwRight, ebx
	INVOKE CheckIntersectRect, OFFSET lynchrect, OFFSET bradyrect
	cmp eax, 1
	jne drawsprites
	INVOKE DrawStr, OFFSET stringer, 100, 100, 255

drawsprites:
	INVOKE BasicBlit, lynch.bmp, lynch.xPOS, lynch.yPOS
	INVOKE BasicBlit, brady.bmp, brady.xPOS, brady.yPOS


resetbrady:
	cmp brady.xPOS, 0
	jge returner
actuallyreset:
	mov brady.jmpState, 0
	mov brady.xPOS,599
	mov esi, brady.bmp
	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, brady.xPOS
	mov bradyrect.dwRight, ecx

	;getting the left
	mov ecx, brady.xPOS
	sub ecx, ebx
	mov bradyrect.dwLeft, ecx

	;MAKING BRADY FASTER EACH TIME THROUGH
	; need to make sure that he has a top speed of 23 (might keep this changing)
	mov edx, brady.xVEL
	cmp edx, 23
	je randomstuff
	inc edx
	mov brady.xVEL, edx

randomstuff:
	;deciding when to make brady go to the top
	invoke nrandom, 2
	cmp eax, 1
	je resetheight
	mov brady.yPOS, 250
	mov brady.up, 1
	mov esi, brady.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, brady.yPOS
	mov bradyrect.dwBottom, ecx

	;getting the bottom
	mov ecx, brady.yPOS
	sub ecx, ebx
	mov bradyrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, brady.xPOS
	mov bradyrect.dwRight, ecx

	;getting the left
	mov ecx, brady.xPOS
	sub ecx, ebx
	mov bradyrect.dwLeft, ecx

	jmp returner

	;now he is staying at 350
resetheight:

	mov brady.up, 0
	mov brady.yPOS, 350
	mov esi, brady.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, brady.yPOS
	mov bradyrect.dwBottom, ecx

	;getting the bottom
	mov ecx, brady.yPOS
	sub ecx, ebx
	mov bradyrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, brady.xPOS
	mov bradyrect.dwRight, ecx

	;getting the left
	mov ecx, brady.xPOS
	sub ecx, ebx
	mov bradyrect.dwLeft, ecx


	;consider  making lynch jmp up and down faster
	;mov edx, lynch.ACCEL
	;dec edx
	;mov lynch.ACCEL, edx

	

returner:
	ret         ;; Do not delete this line!!!
GamePlay ENDP
	

END
