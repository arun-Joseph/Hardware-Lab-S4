;Write a program to read elements into an array, sort it in ascending order and insert a number into the array.

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
  add eax, 1
  cmp eax, dword[length]
  jae displ

  mov dword[j], 0

  innerloop:
   mov eax, dword[j]
   mov ebx, dword[i]
   add eax, ebx
   add eax, 1
   cmp eax, dword[length]
   jae last

   mov ecx, dword[j]
   add ecx, ecx
   mov ax, word[arr+ecx]
   mov edx, dword[j]
   add edx, 1
   add edx, edx
   mov bx, word[arr+edx]
   cmp ax, bx
   jbe abc
   mov word[arr+ecx], bx
   mov word[arr+edx], ax

   abc:
    inc dword[j]
    jmp innerloop

   last:
    inc dword[i]
    jmp outerloop

 displ:
  mov eax, 4
  mov ebx, 1
  mov ecx, disp1
  mov edx, len2
  int 80h

 mov dword[counter], 0

 output_array:
  mov eax, dword[length]
  cmp eax, dword[counter]
  je ins

  mov ecx, dword[counter]
  add ecx, ecx
  mov ax, word[arr+ecx]
  mov word[num], ax
  mov byte[node], 0

  cmp word[num], 0
  je printz1

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

  printz1:
   mov eax, 4
   mov ebx, 1
   mov ecx, zero
   mov edx, 2
   int 80h

  inc dword[counter]
  jmp output_array

 ins:
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, 1
  int 80h

  mov eax, 4
  mov ebx, 1
  mov ecx, query2
  mov edx, len3
  int 80h

  loop_readi:
   mov eax, 3
   mov ebx, 0
   mov ecx, temp
   mov edx, 1
   int 80h
        
   cmp byte[temp], 10
   je out1
   cmp byte[temp], 32
   je out1

   mov ax, word[inse]
   mov bx, 10
   mul bx
   mov bl, byte[temp]
   sub bl, 30h
   mov bh, 0
   add ax, bx
   mov word[inse], ax
   jmp loop_readi

 out1:
  mov dword[counter], 0

 insert:
  mov eax, dword[counter]
  cmp eax, dword[length]
  je swa1

  mov ecx, dword[counter]
  add ecx, ecx
  mov ax, word[arr+ecx]
  cmp ax, word[inse]
  jae swa1

  inc dword[counter]
  jmp insert

 swa1:
  mov ax, word[inse]
  mov word[maxw], ax
  inc dword[length]

 swa2:
  mov eax, dword[counter]
  cmp eax, dword[length]
  je output_arrx

  mov ecx, dword[counter]
  add ecx, ecx
  mov ax, word[arr+ecx]
  mov word[num], ax
  mov ax, word[maxw]
  mov word[arr+ecx], ax
  mov ax, word[num]
  mov word[maxw], ax
  inc dword[counter]
  jmp swa2

 output_arrx:
  mov eax, 4
  mov ebx, 1
  mov ecx, disp2
  mov edx, len4
  int 80h
  mov dword[counter], 0

 output_arr:
  mov eax, dword[length]
  cmp eax, dword[counter]
  je exit

  mov ecx, dword[counter]
  add ecx, ecx
  mov ax, word[arr+ecx]
  mov word[num], ax
  mov byte[node], 0

  cmp word[num], 0
  je printz2

  extracti:
   cmp word[num], 0
   je printi
 
   inc byte[node]
   mov dx, 0
   mov ax, word[num]
   mov bx, 10
   div bx
   push dx
   mov word[num], ax
   jmp extracti

  printi:
   cmp byte[node], 0
   je pspa1

   dec byte[node]
   pop dx
   mov byte[temp], dl
   add byte[temp], 30h

   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h
   jmp printi

  pspa1:
   mov eax, 4
   mov ebx, 1
   mov ecx, spa
   mov edx, 1
   int 80h

  inc dword[counter]
  jmp output_arr

 printz2:
  mov eax, 4
  mov ebx, 1
  mov ecx, zero
  mov edx, 2
  int 80h

  inc dword[counter]
  jmp output_arr

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
 maxw: resw 1
 inse: resw 1

section	.data
 query1 db 'Enter an array: '
 len1 equ $-query1
 disp1 db 'The sorted array is: '
 len2 equ $-disp1
 query2 db 'Enter a number: '
 len3 equ $-query2
 disp2 db 'The new array is: '
 len4 equ $-disp2
 newline db 10
 spa db 32
 zero db '0 '
