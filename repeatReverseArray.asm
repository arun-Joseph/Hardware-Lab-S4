;Write a program to find the most repeated element in an array and replace it with its reverse.

section	.text
 global _start

_start:
 mov eax, 4
 mov ebx, 1
 mov	ecx, query1
 mov	edx, len1
 int 80h

 input_array:
  loop_read:
   mov eax, 3
   mov ebx, 0
   mov ecx, temp
   mov edx, 1
   int 80h
        
   cmp byte[temp], 10
   je prog
   cmp byte[temp], 32
   je add_arr

   mov ax, word[num]
   mov bx, 10
   mul bx
   mov bl, byte[temp]
   sub bl, 30h
   mov bh, 0
   add ax, bx
   mov word[num], ax
   jmp loop_read

  add_arr:
   mov ecx, dword[length]
   add ecx, ecx
   mov ax, word[num]
   mov word[arr+ecx], ax
   inc dword[length]
   mov word[num], 0
   jmp input_array

 prog:
  mov ecx, dword[length]
  add ecx, ecx
  mov ax, word[num]
  mov word[arr+ecx], ax
  inc dword[length]
  mov word[num], 0

 mov dword[i], 0
 outerloop:
  mov eax, dword[i]
  cmp eax, dword[length]
  jae displ

  mov eax, dword[i]
  add eax, 1
  mov dword[j], eax
  mov dword[count], 1

  innerloop:
   mov eax, dword[j]
   cmp eax, dword[length]
   jae last

   mov ecx, dword[j]
   add ecx, ecx
   mov ax, word[arr+ecx]
   mov edx, dword[i]
   add edx, edx
   mov bx, word[arr+edx]
   cmp ax, bx
   jne abc
   inc dword[count]

   abc:
    inc dword[j]
    jmp innerloop

   last:
    inc dword[i]
    mov eax, dword[count]
    cmp eax, dword[max]
    jbe outerloop

    mov eax, dword[count]
    mov dword[max], eax
    dec dword[i]
    mov ecx, dword[i]
    add ecx, ecx
    mov ax, word[arr+ecx]
    mov word[maxw], ax
    inc dword[i]
    jmp outerloop

 displ:
  mov eax, 4
  mov ebx, 1
  mov ecx, disp
  mov edx, len2
  int 80h

 mov dword[counter], 0

 output_array:
  mov eax, dword[length]
  cmp eax, dword[counter]
  je exit

  mov ecx, dword[counter]
  add ecx, ecx
  mov ax, word[arr+ecx]
  mov word[num], ax
  mov byte[node], 0

  cmp word[num], 0
  je printz

  cmp ax, word[maxw]
  je rev

  extract:
   cmp word[num], 0
   je print
 
   inc byte[node]
   mov dx, 0
   mov ax, word[num]
   mov bx, 10
   div bx
   push dx
   mov word[num], ax
   jmp extract

  print:
   cmp byte[node], 0
   je pspa

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

  pspa:
   mov eax, 4
   mov ebx, 1
   mov ecx, spa
   mov edx, 1
   int 80h

  inc dword[counter]
  jmp output_array

 rev:
  cmp word[num], 0
  je prspa

  mov dx, 0
  mov ax, word[num]
  mov bx, 10
  div bx
  mov byte[temp], dl
  add byte[temp], 30h
  mov word[num], ax

  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h
  jmp rev

 prspa:
  mov eax, 4
  mov ebx, 1
  mov ecx, spa
  mov edx, 1
  int 80h

 inc dword[counter]
 jmp output_array

 printz:
  mov eax, 4
  mov ebx, 1
  mov ecx, zero
  mov edx, 2
  int 80h

 inc dword[counter]
 jmp output_array

 exit:
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, 1
  int 80h
 
  mov eax, 1
  mov ebx, 0
  int 80h

section .bss
 arr: resw 100
 num: resw 1
 temp: resb 1
 node: resb 1
 length: resd 1
 i: resd 1
 j: resd 1
 counter: resd 1
 max: resd 1
 count: resd 1
 maxw: resw 1

section	.data
 query1 db 'Enter an array: '
 len1 equ $-query1
 disp db 'The new array is: '
 len2 equ $-disp
 newline db 10
 spa db 32
 zero db '0 '
