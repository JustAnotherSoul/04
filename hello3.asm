section.text
global _start ; for linker (ld)

_start:
	push dword len	;Message length
	push dword msg	;Message to write
	push dword 1	;Write to stdout
	mov eax,4	;System call (sys_write)
	sub esp, 4	;OS X syscall needs moar spes.
	int 0x80	;PULL THE LEVER KRONK!	
	add esp, 16 	;Fix the damage we just did.

	push dword 0
	mov eax,1	;System call (sys_exit)
	sub esp, 12	;Syscall needs ekstra spes.
	int 0x80	;As above: call kernel.

section .data
msg db 'Hello, world!', 0xa
len equ $ - msg	
