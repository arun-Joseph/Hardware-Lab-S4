;Write a program to accept a string with n characters and generate its toggle case, and reverse the resultant string.

section	.text
 global _start

 b1:
  ret

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, query1
 mov edx, len1
 int 80h

reads:
 mov word[len], 0

 loop_read:
  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  cmp byte[temp], 10
  je prints

  mov dl, byte[temp]
  mov dh, 0
  push dx
  inc dword[len]
  jmp loop_read

prints:
 cmp dword[len], 0
 je exit

 pop dx
 mov byte[temp], dl

 cmp byte[temp], 65
 jb csm
 cmp byte[temp], 90
 ja csm

 add byte[temp], 32
 jmp last

 csm:
  cmp byte[temp], 97
  jb last
  cmp byte[temp], 122
  ja last

  sub byte[temp], 32

 last:
  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h

 dec dword[len]
 jmp prints

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
 temp: resb 1
 len: resw 1

section	.data
 query1 db 'Enter the sentence : '
 len1 equ $-query1
 newline db 10
