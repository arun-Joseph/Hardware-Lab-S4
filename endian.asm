;Write a program to check whether a system is little endian or big endian.

section	.text
    global _start

_start:
	mov al, byte[num]
	cmp al, 78h
	je plit
	
	mov eax, 4
	mov ebx, 1
	mov ecx, big
	mov edx, biglen
	int 80h
	jmp exit
	
	plit:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, lit
	    mov edx, litlen
	    int 80h
	
	exit:
	    mov	eax, 1
	    mov ebx, 0
	    int	80h

section	.data
    num dd 12345678h
    lit db 'Little Endian',10
    litlen equ $-lit
    big db 'Big Endian',10
    biglen equ $-big