#PURPOSE: 	Simple program that exits and returns status code.
#
#INPUT:	  	None
#OUTPUT:	Returns a status code
#VARs:		
#		%eax holds the system call number
#		%ebx holds return status

.section .data,

.section .text,
.globl start
start:
movl 	$1, %eax	#Linux kernel command
			#number for exiting

movl	$0, %ebx	#Status number will return

int 	$0x80
