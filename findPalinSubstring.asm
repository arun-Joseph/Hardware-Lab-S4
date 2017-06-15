;Write a program to find all substrings of the given string which are palindrome(length > 1).

section .text
 global _start

palin:
 mov dword[l1], 0
 mov eax, dword[i]
 mov dword[k], eax
 lop1:
  mov eax, dword[k]
  cmp eax, dword[j]
  ja a1

  mov ecx, dword[k]
  mov al, byte[str+ecx]
  cmp al, 32
  je a2
  cmp al, 9
  je a2

  cmp al, 'A'
  jb a3
  cmp al, 'Z'
  ja a3

  add al, 32

  a3:
   mov edx, dword[l1]
   mov byte[strp+edx], al
   inc dword[l1]

  a2:
   inc dword[k]
   jmp lop1

 a1:
  mov dword[k], 0
  lop2:
   mov eax, dword[k]
   cmp eax, dword[l1]
   jae a4

   mov ecx, dword[k]
   mov al, byte[strp+ecx]
   mov edx, dword[l1]
   sub edx, dword[k]
   sub edx, 1
   mov bl, byte[strp+edx]
   cmp al, bl
   je a5

   mov byte[fl], 1
   ret

   a5:
    inc dword[k]
    jmp lop2

 a4:
  ret

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

 mov dword[len], 0
 mov edi, str

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
 mov dword[i], 0
 
loop1:
 mov eax, dword[i]
 add eax, 1
 cmp eax, dword[len]
 jae exit

 mov ecx, dword[i]
 mov al, byte[str+ecx]
 cmp al, 32
 je b2
 cmp al, 9
 je b2

 mov eax, dword[i]
 add eax, 1
 mov dword[j], eax
 loop2:
  mov eax, dword[j]
  cmp eax, dword[len]
  jae b2

  mov ecx, dword[j]
  mov al, byte[str+ecx]
  cmp al, 32
  je b3
  cmp al, 9
  je b3

  mov byte[fl], 0
  call palin
  cmp byte[fl], 0
  jne b3

  mov eax, dword[i]
  mov dword[k], eax
  prints:
   mov eax, dword[k]
   cmp eax, dword[j]
   ja b4

   mov ecx, dword[k]
   mov al, byte[str+ecx]
   mov byte[temp], al

   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h

   inc dword[k]
   jmp prints

  b4:
   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 80h

  b3:
   inc dword[j]
   jmp loop2

 b2:
  inc dword[i]
  jmp loop1

exit:
 mov eax, 1
 mov ebx, 0
 int 80h

section .bss
 str: resb 100
 len: resd 1
 strp: resb 100
 l1: resd 1
 temp: resb 1
 i: resd 1
 j: resd 1
 k: resd 1
 fl: resb 1

section .data
 msg1 db 'Enter a string: '
 len1 equ $-msg1
 newline db 10
