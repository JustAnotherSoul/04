section .text
global start

start:
; read a byte from stdin
mov eax, 3 	;sys_read system call
push dword 13	; input length
push dword variable ;address to pass to
push dword 0	;read from stdin
push eax
int 0x80
add esp, 16

mov eax, 4	;sys_write system call
push dword 13	;output length
push dword variable
push dword 1
push eax
int 0x80
add esp, 16

mov eax, 1
push dword 0
push eax
int 0x80
section .bss
variable resb 14
section .data
; variable resb ;1 DOESN'T GO HERE this goes in the bss section.
