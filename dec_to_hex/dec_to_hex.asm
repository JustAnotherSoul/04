global start
EXTERN printBinary
section .data
msg: db "Enter your number:", 10
len: equ $-msg
prefix: db "0x"
len2: equ $-prefix
section .bss
str1: resb 100 
char_to_print: resb 4 
section .text
start:
	push	dword len	;Length of message
	push	dword msg	;Message to write
	push	dword 1		;STDOUT
	mov 	eax,4		;We are writing
	sub 	esp,4		;Making space on the stack??	
	int 	0x80		;SYSCALL
	add 	esp,16		;Move back

	push 	dword 10	;length of input (10 bytes)
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
	add	esp,16

	push	dword len2	;Print out '0x' as a prefix
	push	dword prefix	;
	push	dword 1		;
	mov	eax,4		;
	sub 	esp,4		;
	int	0x80		;
	add	esp,16		;
				
	mov	esi,str1	;Prep the thing to print and the counter
	mov	ecx,0		;Our counter starts at zero
my_second_loop:
	cmp	ecx,4
	jge 	end
	mov	ebx,0x0000FACE
	and	ebx,0x0000000F
;	mov	ebx,5
	mov	dword [char_to_print],ebx
	cmp	ebx,10
	jge	ten_up		;Jump to the section to give the correct character
	add	dword [char_to_print],48		;It's not one of the letters, so adjust to the correct character for the number
	inc	ecx
	
	jmp	print_char	;Print the char from ebx
	jmp 	my_second_loop	;

end:
	add 	esp,16		;Move back
	push 	dword 0		;Exit code
	mov 	eax,1		;Exit command
	sub	esp,12		;Back up
	int 	0x80		;SYSCALL	

ten_up:
	add	dword [char_to_print],55		;Align 10 to A
	inc	ecx
	jmp	print_char	;Paranoia
	
print_char:
	push	dword 1		;Character
	push	dword char_to_print	;Register containing said character
	push	dword 1		;STDOUT
	mov	eax,4		;PRIME THE COMMAND!
	sub	esp,4		;SPACE FOR RECOIL!
	int	0x80		;FIRE!
	add	esp,16		;CLEAR CHAMBER!
	jmp	my_second_loop	;RELOAD!
