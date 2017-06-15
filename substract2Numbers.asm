;Write a program to read, subtract and print two 16 bit numbers.

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
	    mov bl, byte[temp]
	    sub bl, 30h
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
	    mov bl, byte[temp]
	    sub bl, 30h
	    mov bh, 0
	    add ax, bx
	    mov word[num2], ax
	    jmp loop_read2
	
	prog:
	    mov ax, word[num2]
	    cmp word[num1], ax
	    je printz
	    
	    cmp word[num1], ax
	    jb sub1
	    
	    mov ax, word[num2]
	    sub word[num1], ax
	    
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
	
	sub1:
	    mov ax, word[num1]
	    sub word[num2], ax
	    
	extract1:
	    cmp word[num2], 0
	    je printm
	    
	    inc byte[node]
	    mov dx, 0
	    mov ax, word[num2]
	    mov bx, 10
	    div bx
	    push dx
	    mov word[num2], ax
	    jmp extract1
	   
	printm:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, minus
	    mov edx, 1
	    int 80h
	    
	print1:
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
	    jmp print1
	
	printz:
	    mov eax, 4
	    mov ebx, 1
	    mov ecx, zer
	    mov edx, 1
	    int 80h
	
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
    rev: resw 1
    temp: resb 1
    node: resb 1

section	.data
    query db 'Enter 2 16-bit numbers: ',10
    len	equ	$-query
    minus db '-'
    zer db '0'
    newline db 10