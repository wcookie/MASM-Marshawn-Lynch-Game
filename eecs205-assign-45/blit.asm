; #########################################################################
;
;   blit.asm - Assembly file for EECS205 Assignment 3
;	 Wyatt Cook
;	 wsc147
;    2827797
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc
include blit.inc

.DATA
;declaring my own variables plus the psuedo code ones
   i DWORD ?
   iterations DWORD ?
   colorincrementer DWORD ?
   mycolor DWORD ?
   yvalue DWORD ?
   cosa DWORD ?
   sina DWORD ?
   shiftX DWORD ?
   shiftY DWORD ?
   dstWidth DWORD ?
   dstHeight DWORD ?
   dstX DWORD ?
   dstY DWORD ?
   srcX dWORD ?
   srcY DWORD ?
	;; If you need to, you can place global variables here
	
.CODE
;plot code from last assignment
NEWPLOT PROC USES ebx ecx edx x:DWORD, y:DWORD, color:DWORD
	mov ebx, x
	cmp ebx, 640
	jge returner
	cmp ebx, 0
	jl returner
	mov ebx, y
	cmp ebx, 480
	jge returner
	mov ebx, y
	cmp ebx, 0
	jl returner


	mov ebx, x
	mov eax, y
	mov ecx, 640
	xor edx, edx
	mul ecx
	add eax, ebx
	mov ebx, color  
	mov edx, ScreenBitsPtr
	mov BYTE PTR[edx + eax], bl   ;move the last 8 bits of ebx
returner:	
	ret
NEWPLOT ENDP

BasicBlit PROC USES ebx ecx edx esi ptrBitmap:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD

	mov esi, ptrBitmap
	mov eax, (EECS205BITMAP PTR [esi]).dwWidth
	mov ecx, (EECS205BITMAP PTR [esi]).dwHeight
	mul ecx
	mov iterations, eax  ;there will be x*y iterations
	mov i, 0  ;our looping incrementer
	mov colorincrementer, 0

looper:
	mov ebx, iterations ;looping for each individual pixel
	cmp i, ebx
	jg returner
	mov edx, i
	mov ecx, (EECS205BITMAP PTR [esi]).lpBytes
	mov edx, [ecx + edx]
	mov mycolor, edx ;get the color from the index i
	mov yvalue, 0
	mov ecx, i
getremainder:	
	;we will subtract EECS205BITMAP.dwWidth each time we go through adn count number of passes for y value
	mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
	cmp ecx, ebx ;compare our ecx to i
	jl plotting  ;if we found the y value, go to plotting
	sub ecx, ebx
	inc yvalue
	jmp getremainder
;ecx is our x, yvalue is our y, mycolor is our color
plotting:
	
	add ecx, xcenter ;adding the center to ecx
	shr ebx, 1 ;getting half
	sub ecx, ebx  ;moving the bitmap to the right part
	mov eax, yvalue ;doing the same thing for yvalue
	add eax, ycenter
	mov ebx, (EECS205BITMAP PTR [esi]).dwHeight
	shr ebx, 1
	sub eax, ebx
	mov yvalue, eax
	xor ebx, ebx
	mov bl, (EECS205BITMAP PTR [esi]).bTransparent ;get bTransparent
	mov eax, mycolor
	cmp bl, al ;if mycolor is bTransparent
	je skipplot
	INVOKE NEWPLOT, ecx, yvalue, mycolor ;plot my x, y, color
skipplot:
	inc i
	jmp looper

returner:

	ret    	;;  Do not delete this line!
BasicBlit ENDP

	

RotateBlit PROC USES  ebx ecx edx esi  lpBmp:PTR EECS205BITMAP, xcenter:DWORD, ycenter:DWORD, angle:FXPT
setup:	
	INVOKE FixedCos, angle
	mov cosa, eax
	INVOKE FixedSin, angle
	mov sina, eax
	mov esi, lpBmp
	xor edx, edx
	mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
	mov eax, cosa
	imul ebx
	sar eax, 1 ;divide by 2
	mov shiftX, eax
	mov ebx, (EECS205BITMAP PTR [esi]).dwHeight
	mov eax, sina
	xor edx, edx
	imul ebx 
	sar eax, 1 ;divide by 2
	sub shiftX, eax ;shiftX is acquired
	mov ebx, (EECS205BITMAP PTR [esi]).dwHeight
	mov eax, cosa
	xor edx, edx
	imul ebx
	sar eax, 1 ;divide by 2
	mov shiftY, eax
	mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
	mov eax, sina
	xor edx, edx
	imul ebx
	sar eax, 1 ;divide by 2
	add shiftY, eax ;shiftY is acquired
	xor ebx, ebx
	mov ebx, (EECS205BITMAP PTR [esi]).dwWidth
	add ebx, (EECS205BITMAP PTR [esi]).dwHeight
	mov dstWidth, ebx
	mov dstHeight, ebx
	sar shiftX, 16  ;dealing with fixed point stuff here
	sar shiftY, 16  ;dealing with fixed point stuff here
setuploop:
	neg ebx
	mov dstX, ebx
	mov dstY, ebx

outerloopcondition:
	mov ebx, dstWidth
	cmp dstX, ebx
	jge returner

innerloop:
	mov ebx, dstHeight
	cmp dstY, ebx
	jge backtoouter
	mov eax, cosa
	mov ebx, dstX
	xor edx, edx
	imul ebx ;cosa *dstX
	mov ebx, srcX
	xor srcX, ebx
	mov ecx, srcY
	xor srcY, ecx
	mov srcX, eax
	mov ebx, sina
	mov eax, dstY
	xor edx, edx
	imul ebx  ;sina*dsty
	add srcX, eax ;srcX = dstX*cosa +dstY*sina
	mov ebx, cosa
	mov eax, dstY
	xor edx, edx
	imul ebx ;dstY*cosa
	mov srcY, eax
	mov ebx, sina
	mov eax, dstX
	xor edx, edx
	imul ebx   ;dstx*sina
	sub srcY, eax ;srcY=dstY*cosa-dstx*sina
	sar srcX, 16 ;to deal with FXPT stuff
	sar srcY, 16 ; ^^^^^^^
	xor eax, eax
	mov eax, srcX
	cmp eax, 0 
	jl backtoinner   ;check if srcx>=0
	cmp eax, (EECS205BITMAP PTR [esi]).dwWidth 
	jge backtoinner ;check if srcx< dwWidth
	mov eax, srcY
	cmp eax, 0 ;check if srcxY>=0
	jl backtoinner
	mov eax, srcY
	cmp eax, (EECS205BITMAP PTR [esi]).dwHeight
	jge backtoinner ;check if srcY <dwHeight
	mov eax, xcenter
	add eax, dstX
	sub eax, shiftX
	cmp eax, 0   ;check if xcenter+dstX-shiftX >=0
	jl backtoinner
	cmp eax, 639 ;check if xcenter+dstX-shiftX <639
	jge backtoinner
	mov eax, ycenter
	add eax, dstY
	sub eax, shiftY
	cmp eax, 0  ;check if ycenter+dstY-shiftY >=0
	jl backtoinner
	cmp eax, 479 ;check if ycenter+dstY-shiftY<479
	jge backtoinner
	mov eax, srcY
	mov ecx, (EECS205BITMAP PTR [esi]).dwWidth
	xor edx, edx
	imul ecx
	add eax, srcX ;get the offset by dwWidth*y+x
	mov ecx, (EECS205BITMAP PTR [esi]).lpBytes
	mov ebx, [ecx+eax] ;color in ebx from lpBytes +offset
	mov ecx, xcenter
	add ecx, dstX
	sub ecx, shiftX
	mov edx, ycenter
	add edx, dstY
	sub edx, shiftY ;find places to put the point
	mov al, (EECS205BITMAP PTR [esi]).bTransparent
	cmp al, bl ;check for transparency
	je backtoinner
	INVOKE NEWPLOT, ecx, edx, ebx  ;plotted


backtoinner:
	inc dstY
	jmp innerloop

backtoouter:
	mov eax, dstHeight
	mov dstY, eax
	neg dstY
	inc dstX
	jmp outerloopcondition


returner:
	ret  	;;  Do not delete this line!
	
RotateBlit ENDP


CheckIntersectRect PROC USES ebx ecx esi edi one:PTR EECS205RECT, two:PTR EECS205RECT

	mov esi, one
	mov edi, two
	mov ebx, (EECS205RECT PTR [esi]).dwLeft
	mov ecx, (EECS205RECT PTR [esi]).dwRight
leftwithin:
	cmp ebx, (EECS205RECT PTR [edi]).dwRight ;if one,left is less than two right 
	jg rightwithin
	cmp ebx, (EECS205RECT PTR [edi]).dwLeft ;and one.left is > two.right
	jl rightwithin
	jmp topwithin
rightwithin:
	cmp ecx, (EECS205RECT PTR [edi]).dwRight ;if one.right is less than two.right
	jg returnFalse
	cmp ecx, (EECS205RECT PTR [edi]).dwLeft ;and one.right is greater than two.left
	jl returnFalse
topwithin:
	
	mov ebx, (EECS205RECT PTR [esi]).dwTop 
	mov ecx, (EECS205RECT PTR [esi]).dwBottom
	cmp ebx, (EECS205RECT PTR [edi]).dwTop ;if one.top is less than two.top
	jl bottomwithin
	cmp ebx, (EECS205RECT PTR [edi]).dwBottom ;and one.top is > two.bottom
	jg bottomwithin
	jmp returnTrue
bottomwithin:
	
	;INVOKE NEWPLOT, 255, ebx, 255
	mov ebx, (EECS205RECT PTR [edi]).dwTop
	;INVOKE NEWPLOT, 500, ebx , 255 
	cmp ecx, (EECS205RECT PTR [edi]).dwTop ;if one.bottom is less than two.top
	jl returnFalse
	cmp ecx, (EECS205RECT PTR [edi]).dwBottom ;and one.botom is > two.bottom
	jg returnFalse

	

returnTrue:
	;INVOKE NEWPLOT, 255, 255, 255
	mov eax, 1
	jmp returner

returnFalse:
	mov eax, 0

returner:
	ret  	;;  Do not delete this line!
	
CheckIntersectRect ENDP

END
