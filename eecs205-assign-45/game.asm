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
include tall_bill.asm
include small_roger.asm
include secondmarshawn.asm
include skittlesbag.asm
include skittle.asm


skittle SPRITE <>
skittlerect EECS205RECT <>
skittlesbag SPRITE <>
skittlesbagrect EECS205RECT <>
billy SPRITE <>
lynch SPRITE <>
brady SPRITE <>
roger SPRITE <>
rogerrect EECS205RECT <>
stringer BYTE "Collision"
lynchrect EECS205RECT <>
mouseclick BYTE "CLICK"
bradyrect EECS205RECT <>
spacer BYTE "SPACE"
billyrect EECS205RECT <>
pauseFLAG BYTE ?
pausestuff BYTE "THIS GAME IS PAUSED.  PRESS p TO UNPAUSE"
extraspace BYTE ?
stuff_here BYTE '0'
powerupFLAG BYTE ?
numSkittles BYTE ?
shootingFLAG BYTE ?
gameoverFLAG BYTE ?
numLives BYTE ?
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

	;setting up some gameover stuff
	mov gameoverFLAG, 0

	;starting with 5 lives, might change later.
	mov numLives, 5

	;setting up powerup flag   and other powerup stuff
	mov powerupFLAG, 0
	mov numSkittles, 0
	mov shootingFLAG, 0

	;get rid of background stuff
	mov lynch2small.bTransparent, 01ch  
	mov brady2small.bTransparent, 01ch 
	;doing the same with the others 
	mov skittlebmp.bTransparent, 00h
	mov skittlesbagbmp.bTransparent, 00h
	mov tall_bill.bTransparent, 00h


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

	;set up billy bill
	mov billy.xPOS, -500
	mov billy.yPOS, 300
	mov billy.bmp, OFFSET tall_bill
	mov billy.xVEL, 2
	mov billy.dead, 1

	;set up roger
	mov roger.dead, 1
	mov roger.xVEL, 10
	mov roger.bmp, OFFSET small_roger
	mov roger.VEL, 0
	mov roger.xPOS, 599
	mov roger.yPOS, 300

	;set up skittles bag power UP
	mov skittlesbag.dead, 1
	mov skittlesbag.xVEL, 10
	mov skittlesbag.bmp, OFFSET skittlesbagbmp
	mov skittlesbag.xPOS, 599
	mov skittlesbag.yPOS, 300

	;setting up skittle gunfire
	;firing xVEL is 14.
	mov skittle.xVEL, 14
	mov skittle.bmp, OFFSET skittlebmp 
	mov skittle.VEL, 0
	mov skittle.ACCEL, -3


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

	;billy boy
	mov esi,  billy.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, billy.yPOS
	mov billyrect.dwBottom, ecx

	;getting the bottom
	mov ecx, billy.yPOS
	sub ecx, ebx
	mov billyrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, billy.xPOS
	mov billyrect.dwRight, ecx

	;getting the left
	mov ecx, billy.xPOS
	sub ecx, ebx
	mov billyrect.dwLeft, ecx



	;rog mahal
	mov esi,  roger.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, roger.yPOS
	mov rogerrect.dwBottom, ecx

	;getting the bottom
	mov ecx, roger.yPOS
	sub ecx, ebx
	mov rogerrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, roger.xPOS
	mov rogerrect.dwRight, ecx

	;getting the left
	mov ecx, roger.xPOS
	sub ecx, ebx
	mov rogerrect.dwLeft, ecx

	;skittlesbag
	mov esi,  skittlesbag.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, skittlesbag.yPOS
	mov skittlesbagrect.dwBottom, ecx

	;getting the bottom
	mov ecx, skittlesbag.yPOS
	sub ecx, ebx
	mov skittlesbagrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, skittlesbag.xPOS
	mov skittlesbagrect.dwRight, ecx

	;getting the left
	mov ecx, skittlesbag.xPOS
	sub ecx, ebx
	mov skittlesbagrect.dwLeft, ecx




	
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

createbilly:
	;create a new billy bill
	;but need to make sure he's dead before re recreate him
	mov bl, billy.dead
	cmp bl, 1
	jne createskittlesbag
	;now we know billy is dead if we're here.  time to reincarnate him if he is randomly lucky
	;now we are saying 1 in 300 chance but that is something to play with later
	invoke nrandom, 300
	cmp eax, 1
	jne createskittlesbag
	;he's a live
	mov billy.dead, 0
	;set him back towards the left
	mov billy.xPOS, -20
	mov billy.yPOS, 300

	;now we need to make his rect all good
	;billy boy
	mov esi,  billy.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, billy.yPOS
	mov billyrect.dwBottom, ecx

	;getting the bottom
	mov ecx, billy.yPOS
	sub ecx, ebx
	mov billyrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, billy.xPOS
	mov billyrect.dwRight, ecx

	;getting the left
	mov ecx, billy.xPOS
	sub ecx, ebx
	mov billyrect.dwLeft, ecx


createskittlesbag:

	;creating new skittles bag powerup
	;if there is already a skittlesbag jmp to create roger
	mov bl, skittlesbag.dead
	cmp bl, 1
	jne createroger
	;however, we also only want skittlesbag if there also isnt a roger out there
	mov bl, roger.dead
	cmp bl, 1
	jne createroger

	;we also dont want a skittles bag if lynch is already in powerup mode
	cmp powerupFLAG, 1
	je createroger

	;so now we know there is no fine or powerup in existence and we can try and make a skittlesbag

	; we are making the chances of getting a skittlesbag much higher if billy is alive, just for funsies

	mov bl, billy.dead
	cmp bl, 1
	je deadrandom

	;so basically if billy is alive make it 1 in 85 chance otherwise make it 1 in 250 chance
	invoke nrandom, 85
	cmp eax, 1
	je initializeskittlesbag
	jmp createroger
deadrandom:
	;doing 1 in 250 chance if billy is dead.  might need to be looked at later.  
	invoke nrandom, 250
	cmp eax, 1
	jne createroger

	;if we got here, we know we are tryna make a skittlesbag
initializeskittlesbag:
	mov skittlesbag.dead, 0
	mov skittlesbag.xPOS, 599
	mov skittlesbag.yPOS, 300

	;now gotta reset that rectangle tho 

	mov esi,  skittlesbag.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, skittlesbag.yPOS
	mov skittlesbagrect.dwBottom, ecx

	;getting the bottom
	mov ecx, skittlesbag.yPOS
	sub ecx, ebx
	mov skittlesbagrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, skittlesbag.xPOS
	mov skittlesbagrect.dwRight, ecx

	;getting the left
	mov ecx, skittlesbag.xPOS
	sub ecx, ebx
	mov skittlesbagrect.dwLeft, ecx



createroger:
	
	;creating the roger 

	;if roger is already alive go on
	mov bl, roger.dead
	cmp bl, 1
	jne checkspacebar 
	;same with if skittlesbag is alive, only one powerup or fine at a time, otherwise chaos could ensue

	mov bl, skittlesbag.dead
	cmp bl, 1
	jne checkspacebar

	;also if billy is alive to make it a tad easier to get a skittles bag we wont have roger spawn

	mov bl, billy.dead
	cmp bl, 1
	jne checkspacebar

	;now both are dead.  1 in 500 (??) chance of rog mahal spawning
	invoke nrandom, 500
	cmp eax, 1
	jne checkspacebar


	;now we want to spawn him

	mov roger.dead, 0
	mov roger.xPOS, 599
	mov roger.yPOS, 300

	;now gotta reset that rectangle tho 

	mov esi,  roger.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, roger.yPOS
	mov rogerrect.dwBottom, ecx

	;getting the bottom
	mov ecx, roger.yPOS
	sub ecx, ebx
	mov rogerrect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, roger.xPOS
	mov rogerrect.dwRight, ecx

	;getting the left
	mov ecx, roger.xPOS
	sub ecx, ebx
	mov rogerrect.dwLeft, ecx





checkspacebar:
	;space bar check
	mov ecx, KeyPress
	cmp ecx, 20h
	jne checkfkey
	cmp lynch.jmpState, 0
	jne checkfkey
	mov lynch.jmpState, 1
	mov lynch.VEL, 40

	INVOKE DrawStr, OFFSET spacer, 250, 100, 255


checkfkey:

	;TODO MAKE SURE ITS NOT ALREADY MOVING

	;this is for the f key.  if this is the case, then we are doing the whole firing skittles thing.
	cmp powerupFLAG, 0
	;basically if there is a powerup flag then we can shoot things.
	je afterkeys
	;making sure there isnt one already going, otherwise would make it keep jumping
	cmp shootingFLAG, 1
	je afterkeys

	mov ecx, KeyPress
	cmp ecx, 46h
	jne afterkeys
	mov shootingFLAG, 1
	mov skittle.VEL, 25



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

	;mov brady to thel eft and his rectangle with him
	mov ebx, brady.xPOS
	mov ecx, brady.xVEL
	sub ebx, ecx
	mov brady.xPOS, ebx
	;the rectangle stuff
	mov ebx, bradyrect.dwLeft
	sub ebx, ecx
	mov bradyrect.dwLeft, ebx
	mov ebx, bradyrect.dwRight
	sub ebx, ecx
	mov bradyrect.dwRight, ebx

	;doing the same with billy boy

	;if billy is dead dont move him
	mov bl, billy.dead
	cmp bl, 1
	je moveroger
	mov ebx, billy.xPOS
	mov ecx, billy.xVEL
	add ebx, ecx
	mov billy.xPOS, ebx
	;rectangle stuff
	mov ebx, billyrect.dwLeft
	add ebx, ecx
	mov billyrect.dwLeft, ebx
	mov ebx, billyrect.dwRight
	add ebx, ecx
	mov billyrect.dwRight, ebx

moveroger:

	;gotta move roger if hes not dead
	mov bl, roger.dead
	cmp bl, 1
	je moveskittlesbag

	;now we know rog is not dead
	mov ebx, roger.xPOS
	mov ecx, roger.xVEL
	sub ebx, ecx
	mov roger.xPOS, ebx
	mov ebx, rogerrect.dwLeft
	sub ebx, ecx
	mov rogerrect.dwLeft, ebx
	mov ebx, rogerrect.dwRight
	sub ebx, ecx
	mov rogerrect.dwRight, ebx

	;we know that if roger is alive then skittlesbag is dead so we can save the computational check of seeing if skittlesbag is alive
	jmp powerupinitialize

moveskittlesbag:
	
	;moving skittles bag if skittles bag aint dead

	mov bl, skittlesbag.dead
	cmp bl, 1
	je powerupinitialize

	;now we know that skittlesbag is alive and well
	mov ebx, skittlesbag.xPOS
	mov ecx, skittlesbag.xVEL
	sub ebx, ecx
	mov skittlesbag.xPOS, ebx
	mov ebx, skittlesbagrect.dwLeft
	sub ebx, ecx
	mov skittlesbagrect.dwLeft, ebx
	mov ebx, skittlesbagrect.dwRight
	sub ebx, ecx
	mov skittlesbagrect.dwRight, ebx


powerupinitialize:
	;dealing with all of the firing motion
	cmp powerupFLAG, 0
	je checkbrady
	cmp shootingFLAG, 1
	je powerupmove

	;this is the start of a shooting
	;setting up flags
	;now need to initialize skittles position

	;using lynchrect dwleft so that we can start the position off of the left of lynchs rectangle
	mov ebx, lynchrect.dwLeft
	mov skittle.xPOS, ebx
	mov ebx, lynch.yPOS
	mov skittle.yPOS, ebx

	;now we wanna initiliaze rectangle.
	;skittle
	mov esi,  skittle.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, skittle.yPOS
	mov skittlerect.dwBottom, ecx

	;getting the bottom
	mov ecx, skittle.yPOS
	sub ecx, ebx
	mov skittlerect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, skittle.xPOS
	mov skittlerect.dwRight, ecx

	;getting the left
	mov ecx, skittle.xPOS
	sub ecx, ebx
	mov skittlerect.dwLeft, ecx

	;now we have initialized we dont want to move first time through so well jump away
	jmp checkbrady



powerupmove:
	
	;just move the skittle
	mov ebx, skittle.xPOS
	mov ecx, skittle.xVEL
	sub ebx, ecx
	mov skittle.xPOS, ebx
	;dealing with the jumpy part

	mov ebx, skittle.VEL
	add ebx, skittle.ACCEL
	mov ecx, ebx
	mov skittle.VEL, ebx
	mov edx, skittle.yPOS
	sub edx, ebx
	mov skittle.yPOS, edx

	;skittle rectangle RESET
	mov esi,  skittle.bmp

	;getting the top
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	sar ecx,1
	mov ebx, ecx ;copying 1/2 height into ebx as well
	add ecx, skittle.yPOS
	mov skittlerect.dwBottom, ecx

	;getting the bottom
	mov ecx, skittle.yPOS
	sub ecx, ebx
	mov skittlerect.dwTop, ecx

	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, skittle.xPOS
	mov skittlerect.dwRight, ecx

	;getting the left
	mov ecx, skittle.xPOS
	sub ecx, ebx
	mov skittlerect.dwLeft, ecx




checkbrady:
	;checking if brady and beast mode have contacted each other
	INVOKE CheckIntersectRect, OFFSET lynchrect, OFFSET bradyrect
	cmp eax, 1
	jne checkbilly
	INVOKE DrawStr, OFFSET stringer, 100, 100, 255
	
	;want to decrease number of lives, unless there is only 1 life, then set gameoverFLAG
	cmp numLives, 1
	jne lowernumlives
	;we set gameoverFLAG here
	mov gameoverFLAG, 1

lowernumlives:
	;otherwise we decrement num of lives
	dec numLives
	;also brady is dead now
	mov brady.xPOS, -50

checkbilly:

	;basically saying that billy has collided with beast mode
	mov bl, billy.dead
	cmp bl, 1
	je checkskittlesbag
	INVOKE CheckIntersectRect, OFFSET lynchrect, OFFSET billyrect
	cmp eax, 1
	jne checkskittlesbag
	;change marshawn as test.  later change to GAMEOVER MODE
	;mov lynch.bmp, OFFSET secondmarshawn
	INVOKE DrawStr, OFFSET stringer, 100, 100, 255
	mov gameoverFLAG, 1
	;gameoverFLAG is now set because hitting billy has deterimental consequences

checkskittlesbag:
	;checking if skittlesbag has collided with beast mode.

	;if skittlesbag has collided with beast mode then not only is skittlesbag now dead, beast mode is now in powerup mode AND he 
	;gets the funny looking sprite
	mov bl, skittlesbag.dead
	cmp bl, 1
	je skittlecollision

	INVOKE CheckIntersectRect, OFFSET lynchrect, OFFSET skittlesbagrect
	cmp eax, 1
	jne skittlecollision
	mov lynch.bmp, OFFSET secondmarshawn
	mov powerupFLAG, 1
	mov numSkittles, 2


skittlecollision:
	;if skittle has collided with billy then billy dies
	;making sure theres not some weird powerup error
	cmp powerupFLAG, 1
	jne drawsprites
	;also need to make sure that it didnt just run into billy, need to be shooting
	cmp shootingFLAG, 1
	jne drawsprites

	;then just invoke CheckIntersectRect on skittlerect and billyrect

	INVOKE CheckIntersectRect, OFFSET skittlerect, OFFSET billyrect
	cmp eax, 1
	jne drawsprites

	;NOW WE SEE A Collision

	;need to kill billy
	mov billy.dead, 1
	mov billy.xPOS, -500

	;also need to reset his rect
	mov esi,  billy.bmp
	;getting the right
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	sar ecx, 1
	mov ebx, ecx ;copying 1/2 width into ebx for l8r
	add ecx, billy.xPOS
	mov billyrect.dwRight, ecx

	;getting the left
	mov ecx, billy.xPOS
	sub ecx, ebx
	mov billyrect.dwLeft, ecx


	;need to turn shooting flag offf
	mov shootingFLAG, 0

	;we also need to decrement the number of skittles

	;but first check if this was our last 1

	cmp numSkittles, 1
	je turnoffpower
	dec numSkittles
	jmp drawsprites

turnoffpower:
	;fairly self explanotry tbh
	mov powerupFLAG, 0 
	mov lynch.bmp, OFFSET lynch2small


drawsprites:
	;here we draw lynch and brady and then check if we should be drawing billy roger skittles etc
	INVOKE BasicBlit, lynch.bmp, lynch.xPOS, lynch.yPOS
	INVOKE BasicBlit, brady.bmp, brady.xPOS, brady.yPOS

	;need to make sure that there is a powerupflag before we draw the skittle
	cmp powerupFLAG, 1
	jne checkbillydraw
	INVOKE BasicBlit, skittle.bmp, skittle.xPOS, skittle.yPOS

	;these all make sure respective sprites are alive
checkbillydraw:
	mov bl, billy.dead
	cmp bl, 1
	je checkroger
	INVOKE BasicBlit, billy.bmp, billy.xPOS, billy.yPOS
checkroger:
	mov bl, roger.dead
	cmp bl, 1
	je checkbag
	INVOKE BasicBlit, roger.bmp, roger.xPOS, roger.yPOS
checkbag:
	mov bl, skittlesbag.dead
	cmp bl, 1
	je resetbrady
	INVOKE BasicBlit, skittlesbag.bmp, skittlesbag.xPOS, skittlesbag.yPOS

resetbrady:
	cmp brady.xPOS, 0
	jge resetroger
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



resetroger:
	;basically if roger is off the screen make him dead again
	cmp roger.xPOS, 0
	jge resetskittlesbag
	mov roger.dead, 1

resetskittlesbag:
	;same thing but with skittlesbag
	cmp skittlesbag.xPOS, 0
	jge resetbilly
	mov skittlesbag.dead, 1

resetbilly:
	;with bily instead of checking with 0 we check with 599 (FOPR NOW, later we will do when he is shot)
	cmp billy.xPOS, 599
	jle resetskittle
	mov billy.dead, 1

resetskittle:
	;so we are not going to reset its position but merely set shooting flag to 0 again and decrease num skittles. 
	cmp skittle.xPOS, 0
	jge returner
	mov shootingFLAG, 0
	cmp numSkittles, 1
	jne decrementskittles
	mov powerupFLAG, 0
	mov lynch.bmp, OFFSET lynch2small
	jmp returner
decrementskittles:
	dec numSkittles

returner:
	ret         ;; Do not delete this line!!!
GamePlay ENDP
	

END
