;Write a program to accept a number between 0 to 9 and print all numbers between 0 and that number.

section	.text
    global _start

_start:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, query
	mov	edx, len
	int	80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, num
	mov edx, 1
	int 80h
	
	sub byte[num], 30h
	
	print:
	    add byte[counter], 30h
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, counter
	    mov edx, 1
	    int 80h
	    sub byte[counter], 2Fh
	    
	    mov eax, 4 
	    mov ebx, 1
	    mov ecx, newline
	    mov edx, 1
	    int 80h
	    
	    mov al, byte[num]
	    cmp al, byte[counter]
	    jae print
	
	exit:
	    mov	eax, 1
	    mov ebx, 0
	    int	80h

section .bss
    counter: resb 1
    num: resb 1

section	.data
    query db 'Enter a digit: ',10
    len	equ	$-query
    newline db 10