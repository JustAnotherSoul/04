global start
EXTERN	printBinary
section	.data
msg: db 48
len: equ $-msg
section .bss
str1: resb 100
section .text
start:
	mov	ebx,msg
	push 	dword len
	push	ebx
	push	dword 1
	mov	eax,4
	sub	esp,4
	int 	0x80
	add	esp,16

	mov	ebx,48
	push	dword 1
	push	ebx
	push	dword 1
	mov	eax,4
	sub	esp,4
	int	0x80
	add	esp,16

	push	dword 1
	push	dword 48
	push	dword 1
	mov	eax,4
	sub	esp,4
	int	0x80
	add	esp,16

	push	dword 1
	push	48
	push 	dword 1
	mov	eax,4
	sub	esp,4
	int	0x80
	add	esp,16

	mov	dword [str1],48
	add	dword [str1],3
	mov	ebx,str1
	push	dword 1
	push	dword str1
	push	dword 1
	mov	eax,4
	sub	esp,4
	int	0x80
	add	esp,16	

	push 	dword 0
	mov	eax,1
	sub	esp,12
	int	0x80
