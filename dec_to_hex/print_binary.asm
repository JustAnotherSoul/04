global printBinary 		;This is our 'main' thing, we are exporting this
section .data
zero: db "0"
len: equ $-zero
one: db "1"
section .text
printBinary:
	push	ebp 		;Push so we can go back
	mov	ebp,esp		;Alright, now we're aligning everything
	mov 	edx,[esp+8]	;Our parameter is here!
;	mov 	edx,0xABCDEF23	;Dummy parameter for test
	;Something like this: xor with 10000000 repeatedly to assemble the number: bitmask. 0b1000 0000 0000 0000 = 0x8000 (32 bits though so four more zeros)
	;False: AND with 0x80000000 to determine which to print 0 or 1. 
	mov 	ecx,0x1		;To keep track of how many times this has been done 
my_loop:
	cmp 	ecx,0		;If it rotates through all the bits we're done
	je 	done_label	;Go to done
	push 	edx		;Push the thing we have
	and 	edx,0x80000000	;Should be 0 or 1 now.
	cmp 	edx,0
	je 	print_zero	;Ah, good, we print zero
	jmp 	print_one	;Oh, okay, print one (explicit in case a later change shuffles the order)
print_zero:
	push 	dword len	;length
	push 	zero		;Character (zero in this case)
	push	dword 1		;stdout
	mov 	eax,4		;print opcode
	sub 	esp,4		;Make space per BSD calling convention
	int 	0x80		;SYSCALL
	add 	esp,16		;Functionally pop
	pop 	edx
	shl 	ecx,1		;Move to next bit and loop
	shl	edx,1
	jmp 	my_loop		;Keep going
print_one:	 
	push 	dword len	;length
	push 	one		;Character (one in this case)
	push 	dword 1		;stdout
	mov 	eax,4		;print opcode
	sub 	esp,4		;Make space per BSD calling convention
	int 	0x80		;SYSCALL
	add 	esp,16		;Functionally pop
	pop 	edx
	shl 	ecx,1		;Move to the next bit
	shl 	edx,1
	jmp 	my_loop		;and loop
done_label:
	;All done!

	mov	esp, ebp
	pop 	ebp
	ret
	;Return to caller

	push 	dword 0
	mov	eax,1
	sub	esp,12
	int 	0x80
