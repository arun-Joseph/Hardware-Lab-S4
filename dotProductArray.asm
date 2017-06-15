;Write a program which accepts two n dimensional vectors as input and calculate their dot product.

section	.text
 global _start

_start:
 mov eax, 4
 mov ebx, 1
 mov	ecx, query1
 mov	edx, len1
 int 80h

 input_array1:
  loop_read1:
   mov eax, 3
   mov ebx, 0
   mov ecx, temp
   mov edx, 1
   int 80h
        
   cmp byte[temp], 10
   je prog
   cmp byte[temp], 32
   je add_arr1

   mov ax, word[num]
   mov bx, 10
   mul bx
   mov bl, byte[temp]
   sub bl, 30h
   mov bh, 0
   add ax, bx
   mov word[num], ax
   jmp loop_read1

  add_arr1:
   mov ecx, dword[length]
   add ecx, ecx
   mov ax, word[num]
   mov word[arr1+ecx], ax
   inc dword[length]
   mov word[num], 0
   jmp input_array1

 prog:
  mov ecx, dword[length]
  add ecx, ecx
  mov ax, word[num]
  mov word[arr1+ecx], ax
  inc dword[length]
  mov word[num], 0

 input_array2:
  mov eax, dword[counter]
  cmp eax, dword[length]
  je prod   

  loop_read2:
   mov eax, 3
   mov ebx, 0
   mov ecx, temp
   mov edx, 1
   int 80h
 
   cmp byte[temp], 32
   je add_arr2
   cmp byte[temp], 10
   je add_arr2 
   mov ax, word[num]
   mov bx, 10
   mul bx
   mov bl, byte[temp]
   sub bl, 30h
   mov bh, 0
   add ax, bx
   mov word[num], ax
   jmp loop_read2

  add_arr2:
   mov ecx, dword[counter]
   add ecx, ecx
   mov ax, word[num]
   mov word[arr2+ecx], ax
   inc dword[counter]
   mov word[num], 0
   jmp input_array2

 prod:
  mov dword[counter], 0   

 pro_loop:
  mov eax, dword[counter]
  cmp eax, dword[length]
  je displ
 
  mov ecx, dword[counter]
  add ecx, ecx
  mov eax, dword[arr1+ecx]
  mov ebx, dword[arr2+ecx]
  mul ebx
  add dword[ans], eax
  inc dword[counter]
  jmp pro_loop

 displ:
  mov eax, 4
  mov ebx, 1
  mov ecx, disp
  mov edx, len2
  int 80h

 cmp dword[ans], 0
 je printz

 extract:
  cmp dword[ans], 0
  je print
 
  inc byte[node]
  mov edx, 0
  mov eax, dword[ans]
  mov ebx, 10
  div ebx
  push edx
  mov dword[ans], eax
  jmp extract 

 print:
  cmp byte[node], 0
  je exit

  dec byte[node]
  pop edx
  mov byte[temp], dl
  add byte[temp], 30h

  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h
  jmp print

 printz:
  mov eax, 4
  mov ebx, 1
  mov ecx, zero
  mov edx, 1
  int 80h

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
 arr1: resw 100
 arr2: resw 100
 num: resw 1
 temp: resb 1
 node: resb 1
 length: resd 1
 counter: resd 1
 ans: resd 1

section	.data
 query1 db 'Enter 2 vectors: ',10
 len1 equ $-query1
 disp db 'The dot product is '
 len2 equ $-disp
 newline db 10
 zero db '0'
