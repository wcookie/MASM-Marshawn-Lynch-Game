; #########################################################################
;
;   lines.asm - Assembly file for EECS205 Assignment 2
;
;      Wyatt Cook
;      wsc147
;      2827797
;
;
; #########################################################################

      .586
      .MODEL FLAT,STDCALL
      .STACK 4096
      option casemap :none  ; case sensitive

include stars.inc
include lines.inc

.DATA
;;  These are some useful constants (fixed point values that correspond to important angles)
PI_HALF = 102943           	;;  PI / 2
PI =  205887	                ;;  PI 
TWO_PI	= 411774                ;;  2 * PI 
PI_INC_RECIP =  5340353        	;;  256 / PI   (use this to find the table entry for a given angle
	                        ;;              it is easier to use than divison would be)

	;; If you need to, you can place global variables here


i DWORD ?
fixed_inc FXPT ?
fixed_j FXPT ?

.CODE
	

FixedSin PROC USES ebx ecx edx angle:FXPT
looper:
	add angle, TWO_PI
	mov ebx, 0
	cmp angle, ebx
	jl looper    ;gets rid of negatives	
	mov eax, angle
	xor edx, edx
	mov ebx, PI      
	div ebx    ;divides angle by PI
	cmp edx, PI_HALF   ;compares remainder to pI/2
	jg bigger  ;if bigger it jumps to "bigger"
	mov eax, angle
	mov ebx, PI_HALF
	xor edx, edx
	div ebx
	mov eax, edx
fixedmath:
	INVOKE AXP, eax, PI_INC_RECIP, 00h	;get fixed point multiplication
	xor ebx, ebx
	mov ebx, eax
	shr ebx, 16  ;only care about 16 biggest bits
	xor eax, eax
	mov cx, WORD PTR [  SINTAB + 2*ebx]  ;mov zero extend
	movzx eax, cx
	jmp return
bigger:
	mov eax, PI
	sub eax, edx    ;recursion
	INVOKE FixedSin, eax

return:
	mov ebx, angle    
	cmp angle, TWO_PI
	jg otherwise
negative:
	;ebx is angle i am negatizing
	;eax is the value that i got before negatization started
	mov ecx, PI
	cmp ebx, ecx
	jl away
	mov ebx, 00h
	sub ebx, eax
	mov eax, ebx
	jmp away
otherwise:
	sub ebx, TWO_PI
	cmp ebx, TWO_PI
	jg otherwise     ;dealing with bigger than two
	jmp negative

away:
	ret        	;;  Don't delete this line...you need it		
FixedSin ENDP 
	
FixedCos PROC USES ebx angle:FXPT	
	mov eax, angle
	cmp eax, 0
	jne sincall
	mov eax, 010000h   ;because for exactly angle of 0 i get super weird case so force it to 1
	jmp returner

sincall:
	mov eax, angle
	add eax, PI_HALF    ;trig identity
	invoke FixedSin, eax

returner:
	ret        	;;  Don't delete this line...you need it		
FixedCos ENDP	


ABS PROC  val:DWORD
	mov eax, val
	cmp eax, 0
	jl positize
	jmp return

positize:
	mov eax, 0
	sub eax, val
	

return:
	ret 
ABS ENDP

FIXED_TO_INT PROC val:FXPT
	mov eax, val
	sar eax, 16  ;sign extend
	ret
FIXED_TO_INT ENDP

INT_TO_FIXED PROC val:DWORD
	mov eax, val
	sal eax, 16  ;sign extend
	ret
INT_TO_FIXED ENDP

PLOT PROC USES ebx ecx edx x:DWORD, y:DWORD, color:DWORD
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
PLOT ENDP
	
DrawLine PROC USES ebx ecx edx x0:DWORD, y0:DWORD, x1:DWORD, y1:DWORD, color:DWORD




	 
ifabs:
	;comparing the ABS of y1-y0 and x1-x0
	mov ebx, y1
	mov ecx, y0
	sub ebx, ecx ;get y1-y0
	INVOKE ABS, ebx ;getting abs of y1-y0 and putting it into ebx
	mov ebx, eax
	mov ecx, x1
	mov edx, x0
	sub ecx, edx ;get x1-x0
	INVOKE ABS, ecx ;getting abs of x1-x0 and putting it into ecx
	mov ecx, eax
	cmp ebx, ecx
	jge elsey1noty0   ;if ABS(y1-y0)>=ABS(x1-x0) go to else if


setfixedinc:

	xor ecx, ecx
	xor eax, eax
	mov ecx, x1  
	mov eax, x0
	sub ecx, eax ;ecx = x1-x0
	mov eax, ecx
	mov eax, y1
	mov ebx, y0
	sub eax, ebx ;eax = y1-y0
	mov edx, eax
	sar edx, 16  ;get the 16 most significant bits of eax into 16 least of edx
	sal eax, 16  ;put 16 least of eax into 16 most eax
	idiv ecx  ;dividing
	mov ecx, fixed_inc
	xor fixed_inc, ecx   ;clearing fixed-inc
	mov fixed_inc, eax ;set fixed_inc to division of y1-y0/x1-x0



casex0biggerx1:
	mov ebx, x0
	mov ecx, x1
	cmp ebx, ecx
	jle elsex1asbig ;if x1 is >= x0 go to else case
	;swapping x1 and x0
	mov ebx, x0
	mov ecx, x1
	xchg x0, ecx   ;xchg is a beautiful built in function
	xchg x1, ebx
	mov ebx, y1
	INVOKE INT_TO_FIXED, ebx
	mov ecx, fixed_j
	xor fixed_j, ecx ;clear fixed_j
	mov fixed_j, eax ;getting fixed point version of y1 into fixed_j
	jmp forloopdraw


elsex1asbig:
	mov ebx, y0
	INVOKE INT_TO_FIXED, ebx
	mov ecx, fixed_j
	xor fixed_j, ecx ;clear fixed_j
	mov fixed_j, eax ;getting y0 into fixed_j

forloopdraw:
	mov ebx, x0  ;initializing i to x0
	mov ecx, i
	xor i, ecx
	mov i, ebx
looper:
	mov ebx, x1
	cmp i, ebx
	jg returner  ;if x0>x1 leave for looop
	INVOKE FIXED_TO_INT, fixed_j ;make fixed_j fixed point to int
	mov ecx, color
	INVOKE PLOT, i, eax, ecx ;plot the point of ebx, the fixed point of fixed j, and color
	mov ecx, fixed_inc
	add fixed_j, ecx ;add fixed_inc to fixed_j
	add i, 1 ;increment ebx
	jmp looper ;loop again


elsey1noty0:
	mov ebx, y1
	cmp ebx, y0
	je returner   ;if y1==y0 leave
	xor ecx, ecx
	xor eax, eax
	mov ecx, y1 ;set ecx to y1
	mov eax, y0
	sub ecx, eax; ecx= y1-y0
	mov eax, x1
	mov ebx, x0
	sub eax, ebx ;eax=x1-x0
	xor edx, edx
	mov edx, eax
	sar edx, 16
	sal eax, 16
	idiv ecx     ;doing division stuff like Prof does in the slides
	mov ecx, fixed_inc
	xor fixed_inc, ecx
	mov fixed_inc, eax   ;put the result in fixed_inc
	mov ebx, y0
	cmp ebx, y1
	jle elsey1bigger ;if y1 >= y0 go to else

casey0bigger:
	; swap y1, y0
	mov ebx, y0
	mov ecx, y1
	xchg ebx, y1
	xchg ecx, y0
	mov ebx, x1
	INVOKE INT_TO_FIXED, ebx ;get fixed of x1
	mov ecx, fixed_j
	xor fixed_j, ecx ;clear fixed_j
	mov fixed_j, eax ;put it into fixed_j
	jmp secondforloop


elsey1bigger:
	mov ebx, x0
	INVOKE INT_TO_FIXED, ebx
	mov ecx, fixed_j
	xor fixed_j, ecx ;cleared fixed_j
	mov fixed_j, eax ;get fixed of x0 and put into fixed_j

secondforloop:
	mov ebx, y0 ;initailize i to y0
	mov ecx, i
	xor i, ecx
	mov i, ebx
secondlooper:
	mov ebx, y1
	cmp i, ebx
	jg returner ;if i>y1 leave
	INVOKE FIXED_TO_INT, fixed_j ;get int verison of fixed_j
	INVOKE PLOT, eax, i, color
	mov ebx, fixed_inc
	add fixed_j, ebx
	add i, 1
	jmp secondlooper ;loop again

returner:
	ret        	;;  Don't delete this line...you need it
DrawLine ENDP




END
