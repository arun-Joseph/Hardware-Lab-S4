;Write a program to convert a given integer array of n elements into a boolean array (0/1), where each entry is replaced by 0 if number is even and 1 otherwise.

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
   mov bx, 2
   div bx
   cmp ah, 1
   je podd1

   mov byte[arr+ecx], 0

   podd1:
    mov byte[arr+ecx], 1

   inc dword[length]
   mov word[num], 0
   jmp input_array

 prog:
  mov ecx, dword[length]
  add ecx, ecx

  mov ax, word[num]
  mov bx, 2
  div bx
  cmp ah, 1
  je podd

  mov byte[arr+ecx], 0

  podd:
   mov byte[arr+ecx], 1

  inc dword[length]
  mov word[num], 0

 displ:
  mov eax, 4
  mov ebx, 1
  mov ecx, disp
  mov edx, len2
  int 80h

 output_array:
  print:
   mov ecx, dword[counter]
   cmp dword[length], ecx
   je exit

   mov al, byte[arr+ecx]
   mov byte[temp], al
   add byte[temp], 30h

   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h

   mov eax, 4
   mov ebx, 1
   mov ecx, spa
   mov edx, 1
   int 80h

   inc dword[counter]
   jmp print

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
 arr: resb 100
 num: resw 1
 temp: resb 1
 node: resb 1
 length: resd 1
 counter: resd 1

section	.data
 query1 db 'Enter an integer array: '
 len1 equ $-query1
 disp db 'The boolean array is: '
 len2 equ $-disp
 newline db 10
 spa db 32
