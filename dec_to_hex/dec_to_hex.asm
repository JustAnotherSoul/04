global start
section .data
msg: db "Enter your number:", 10
len: equ $-msg
section .bss
str1: resb 10 
section .text
start:
	push	dword len	;Length of message
	push	dword msg	;Message to write
	push	dword 1		;STDOUT
	mov 	eax,4		;We are writing
	sub 	esp 4		;Making space on the stack??	
	int 	0x80		;SYSCALL
	add 	esp,16		;Move back
	
	push 	dword 10	;length of message (10)
	push	dword str1	;Place to put it
	push 	dword 0		;STDIN 0. Not 3.
	mov 	eax,3		;We are reading
	sub	esp,4		;push	eax
	int 	0x80
	add	esp,16
	
	mov	ebx, str1	;Move it around
	push	dword 10	;Printing 10
	push	dword ebx	;Hopefully putting the string back on the stack?
	push	dword 1		;STDOUT
	mov	eax,4
	sub	esp,4		
	int 	0x80

	;Okay now we have ASCII characters. 
	;I would like to write a function to print out the value on the stack as a binary number, just to see it.
	push ebx
	call printBinary
	call end

printBinary:
	push	ebp
	mov	ebp, esp
	mov 	esi, [esp+8]
		
	

	mov	esp, ebp
	pop 	ebp
	ret
end:
	add 	esp,16		;Move back
	push 	dword 0		;Exit code
	mov 	eax,1		;Exit command
	sub	esp,12		;Back up
	int 	0x80		;SYSCALL	
