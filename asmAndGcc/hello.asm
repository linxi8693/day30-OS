extern  water
global entry
[bits 32]
;hello-os
;bios will copy the code to 0x7c00 ,this means link address
	jmp entry
;this is fat12 format information

;but now this is not used in our program ,so if we don`t use it ,we just leave+
;it alone




entry:
	mov ax ,0 ; ax=0
	mov ds ,ax; ds=0
	mov es ,ax; es=0
	mov ss ,ax; ss=0

	mov sp,0x7c00 ;sp=0x7c00
	mov si,msg

; while (*msg)displaychar(*msg++)
; loop and if else
putcharloop:
	mov al,[si] ;al=first character to display
	add si,1
	cmp al,0
	
	je finish

	mov ah,0x0e   ;display one character once
	mov bx,15     ;the color of character
	int 0x10      ; bios 0x10 interrupt service

	jmp putcharloop

finish:
	call while_c
	hlt
	mov al,0x31
	int 0x10
	hlt
	jmp finish

msg:
	db 0x0a,0x0a ;this means \n \n 
	db "\n\nhello,world\n\0"  ;maybe this doesn`t work
	db 0x0a

times 510-($-$$) db 0
dw 0xaa55


