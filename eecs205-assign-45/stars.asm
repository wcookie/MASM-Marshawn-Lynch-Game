; #########################################################################
;
;   stars.asm - Assembly file for EECS205 Assignment 1
;
;		Wyatt Cook
;		wsc147
;		2827797
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive


include stars.inc

.DATA

	;; If you need to, you can place global variables here

.CODE

DrawStarField proc
	invoke DrawStar, 5, 5
	invoke DrawStar, 100, 5
	invoke DrawStar, 200, 5
	invoke DrawStar, 300, 5
	invoke DrawStar, 400, 5
	invoke DrawStar, 500, 5
	invoke DrawStar, 600, 400
	invoke DrawStar, 100, 100
	invoke DrawStar, 300, 100
	invoke DrawStar, 500, 100
	invoke DrawStar, 100, 200
	invoke DrawStar, 300, 200
	invoke DrawStar, 500, 200
	invoke DrawStar, 100, 300
	invoke DrawStar, 300, 500
	invoke DrawStar, 500, 500
	invoke DrawStar, 50, 5
	invoke DrawStar, 150, 5



	;; Place your code here

	ret  			; Careful! Don't remove this line
DrawStarField endp


AXP	proc USES ebx edx a:FXPT, x:FXPT, p:FXPT

    ;; Place your code here     mov eax, a     sr

   
    ; get a and x in registers
	mov eax, a
	mov ebx, x
	;signed multiplication
	imul x ; Formally imul ebx.  Dont need the moving to registers
	;Get the 16 least significant bits of the 32 bit output edx from imul
	shl edx, 16
	;Get the 16 most significant bits of the 32 bit output eax from imul
	shr eax, 16
	;combine them
	add eax, edx
	;get p in register
	mov ebx, p
	;add them
	add eax, ebx







	;; Remember that the return value should be copied in to EAX
	
	ret  			; Careful! Don't remove this line	
AXP	endp

	

END
