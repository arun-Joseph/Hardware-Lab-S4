;Write a program to find LCM of two numbers using Euclids algorithm (non recursive).

section	.text
    global _start

_start:
	mov	eax, 4
	mov	ebx, 1
	mov	ecx, query
	mov	edx, len
	int	80h
	
	loop_read1:
	    mov eax, 3
	    mov ebx, 0
	    mov ecx, temp
	    mov edx, 1
	    int 80h
	    
	    cmp byte[temp], 10
	    je loop_read2
	    cmp byte[temp], 32
	    je loop_read2
	    
	    mov ax, word[num1]
	    mov bx, 10
	    mul bx
	    sub byte[temp], 30h
	    mov bl, byte[temp]
	    mov bh, 0
	    add ax, bx
	    mov word[num1], ax
	    jmp loop_read1
	
	loop_read2:
	    mov eax, 3
	    mov ebx, 0
	    mov ecx, temp
	    mov edx, 1
	    int 80h
	    
	    cmp byte[temp], 10
	    je prog
	    cmp byte[temp], 32
	    je prog
	    
	    mov ax, word[num2]
	    mov bx, 10
	    mul bx
	    sub byte[temp], 30h
	    mov bl, byte[temp]
	    mov bh, 0
	    add ax, bx
	    mov word[num2], ax
	    jmp loop_read2
	
	prog:
	    mov ax, word[num1]
	    mov word[a], ax
	    mov ax, word[num2]
	    mov word[b], ax
	
	cmp word[num1], ax
	ja pgcd
	
	mov bx, word[num1]
	mov word[num2], bx
	mov word[num1], ax
	
	pgcd:
	    cmp word[num2], 0
	    je plcm
	    
	    mov dx, 0
	    mov ax, word[num1]
	    mov bx, word[num2]
	    div bx
	    mov word[num2], dx
	    mov word[num1], bx
	    jmp pgcd
	
	plcm:
	    mov ax, word[b]
	    mov bx, word[num1]
	    div bx
	    mov bx, word[a]
	    mul bx
	    mov word[num1], ax
	
	extract:
	    cmp word[num1], 0
	    je print
	    
	    inc byte[node]
	    mov dx, 0
	    mov ax, word[num1]
	    mov bx, 10
	    div bx
	    push dx
	    mov word[num1], ax
	    jmp extract
	    
	print:
	    cmp byte[node], 0
	    je exit
	    
	    dec byte[node]
	    pop dx
	    mov byte[temp], dl
	    add byte[temp], 30h
	    
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, temp
	    mov edx, 1
	    int 80h
	    jmp print 
	    
	exit:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, newline
	    mov edx, 1
	    int 80h
	    
	    mov	eax, 1
	    mov ebx, 0
	    int	80h

section .bss
    num1: resw 1
    num2: resw 1
    temp: resb 1
    a: resw 1
    b: resw 1
    tem: resw 1
    node: resb 1

section	.data
    query db 'Enter 2 numbers: ',10
    len	equ	$-query
    newline db 10