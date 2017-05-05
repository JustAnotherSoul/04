global start
section .data
msg: db "Enter your number:", 10
len: equ $-msg
section .bss
str1: resb 1 
section .text
start:
	push	dword len	;Length of message
	push	dword msg	;Message to write
	push	dword 1		;STDOUT
	sub 	esp,4		;Make space on stack
	mov 	eax,4		;We are writing
	int 	0x80		;SYSCALL
	pop 	ebx	
	
	push 	dword 1		;Once again length
	push 	dword ebx	;msg
	push 	dword 1		;stout
	sub	esp,4
	mov 	eax,4		;Read
	int 	0x80	

	add 	esp,16		;Move back
	push 	dword 0		;Exit code
	mov 	eax,1		;Exit command
	sub	esp,12		;Back up
	int 	0x80		;SYSCALL	
