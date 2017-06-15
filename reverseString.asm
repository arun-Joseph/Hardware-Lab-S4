;Write a program to read a sentence with n words, interchange 1st and nth words, 2nd and n-1th word etc...

section .text
 global _start

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

mov edi, str
mov dword[len], 0
mov dword[size], 20
loop_read:
 mov eax, 3
 mov ebx, 0
 mov ecx, temp
 mov edx, 1
 int 80h

 cmp byte[temp], 10
 je b1

 mov al, byte[temp]
 stosb
 inc dword[len]
 jmp loop_read

b1:
 mov al, 32
 stosb
 inc dword[len]

b2:
 mov dword[i], 0
 mov dword[j], 0
 loop1:
  mov eax, dword[i]
  cmp eax, dword[len]
  jae b6

  mov ecx, dword[i]
  mov al, byte[str+ecx]
  cmp al, 32
  jne b3

  cmp dword[count], 0
  je b4

  mov dword[k], 0
  loop2:
   mov eax, dword[j]
   cmp eax, dword[i]
   je b5

   mov eax, dword[size]
   mov ebx, dword[flen]
   mul ebx
   mov ecx, dword[k]
   add ecx, eax
   mov edx, dword[j]
   mov al, byte[str+edx]
   mov byte[strm+ecx], al
   
   inc dword[k]
   inc dword[j]
   jmp loop2

 b5:
  mov eax, dword[count]
  mov ecx, dword[flen]
  add ecx, ecx
  add ecx, ecx
  mov dword[l+ecx], eax
  inc dword[flen]

 b4:
  mov eax, dword[i]
  inc eax
  mov dword[j], eax
  mov dword[count], -1

 b3:
  inc dword[count]
  inc dword[i]
  jmp loop1

b6:
 mov eax, dword[flen]
 dec eax
 mov dword[i], eax
 lop1:
  mov eax, dword[i]
  cmp eax, 0
  jl exit

  mov dword[j], 0
  lop2:
   mov ecx, dword[i]
   add ecx, ecx
   add ecx, ecx
   mov eax, dword[l+ecx]
   cmp dword[j], eax
   je b7

   mov eax, dword[i]
   mov ebx, dword[size]
   mul ebx
   mov ecx, dword[j]
   add ecx, eax
   mov al, byte[strm+ecx]
   mov byte[temp], al

   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h
   inc dword[j]
   jmp lop2

  b7:
   mov eax, 4
   mov ebx, 1
   mov ecx, spa
   mov edx, 1
   int 80h
   dec dword[i]
   jmp lop1

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
 str: resb 100
 len: resd 1
 strm: resb 1000
 l: resd 50
 temp: resb 1
 count: resd 1
 i: resd 1
 j: resd 1
 k: resd 1
 size: resd 1
 flen: resd 1

section .data
 msg1 db 'Enter a sentence: '
 len1 equ $-msg1
 msg2 db 'Enter n: '
 len2 equ $-msg2
 newline db 10
 spa db 32
