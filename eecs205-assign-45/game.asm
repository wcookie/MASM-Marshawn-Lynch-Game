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

include lynch.asm
include brady.asm



 lynch SPRITE <>
 brady SPRITE <>
 stringer BYTE "Collision"
 lynchrect EECS205RECT <>
 mouseclick BYTE "CLICK"
 bradyrect EECS205RECT <>
  spacer BYTE "SPACE"
pauseFLAG BYTE ?
pausestuff BYTE "THIS GAME IS PAUSED.  PRESS p TO UNPAUSE"
extraspace BYTE '0'
;; If you need to, you can place global variables here


;;COMMENT STUFF HERE:

;To play as Beast Mode to avoid a rampant brady being flown at you press space brady

;to avoid Beast Mode as brady press the left mouse

.CODE

GameInit PROC USES ebx ecx esi
	

	;playing music
	invoke PlaySound, offset SndPath, 0, SND_ASYNC 

	;setting up randomstuff
	rdtsc
	invoke nseed, eax 


	;setting up pause stuff
	mov pauseFLAG, 0

	;get rid of background stuff
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
	
	

	; if p is pressed unpause it otherwise jump to pause it
	mov ecx, KeyPress
	cmp ecx, 50h
	jne afterpause
	;so it was pressed now time to do pauseFLAG stuff
	cmp pauseFLAG, 0
	jne unpause
	mov pauseFLAG, 1
	INVOKE DrawStr, OFFSET pausestuff, 100, 100, 255
	jmp returner

unpause:
	mov pauseFLAG, 0

afterpause:
	;make sure it's not paused
	cmp pauseFLAG, 1
	je returner
	INVOKE BlackStarField

	;space bar check
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

	;rect stuff
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
