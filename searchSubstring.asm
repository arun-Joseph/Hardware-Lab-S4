;Write a program to check if a String contains another String. The program takes two strings as the input and returns the index where the second string is found. If the target string cannot be found, then return -1.

section .text
 global _start

printn:
 cmp word[num], 0
 je printz

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
  je a1

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

 printz:
  mov eax, 4
  mov ebx, 1
  mov ecx, zero
  mov edx, 1
  int 80h

 a1:
  ret

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

 mov dword[l1], 0
 mov edi, str1

 loop_read1:
  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  cmp byte[temp], 10
  je b1

  mov al, byte[temp]
  stosb
  inc dword[l1]
  jmp loop_read1

b1:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h

 mov dword[l2], 0
 mov edi, str2

 loop_read2:
  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  cmp byte[temp], 10
  je b2

  mov al, byte[temp]
  stosb
  inc dword[l2]
  jmp loop_read2

b2:
 mov eax, dword[l1]
 sub eax, dword[l2]
 mov dword[limt], eax
 mov eax, dword[l2]
 mov dword[i], 0
 mov byte[nfl], 0

loop1:
 mov eax, dword[i]
 cmp eax, dword[limt]
 jg b6

 mov dword[j], eax
 mov dword[k], 0
 mov byte[fl], 0
 loop2:
  mov eax, dword[k]
  cmp eax, dword[l2]
  je b3

  mov ecx, dword[j]
  mov al, byte[str1+ecx]
  mov edx, dword[k]
  mov bl, byte[str2+edx]
  cmp al, bl
  je b4

  mov byte[fl], 1
  jmp b3

  b4:
   inc dword[j]
   inc dword[k]
   jmp loop2

 b3:
  cmp byte[fl], 0
  je b5

  inc dword[i]
  jmp loop1

  b5:
   mov eax, dword[i]
   mov word[num], ax
   call printn

   mov eax, 4
   mov ebx, 1
   mov ecx, spa
   mov edx, 1
   int 80h

   inc byte[nfl]
   inc dword[i]
   jmp loop1

b6:
 cmp byte[nfl], 0
 jne exit

 mov eax, 4
 mov ebx, 1
 mov ecx, nega
 mov edx, 2
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
 str1: resb 100
 l1: resd 1
 str2: resb 100
 l2: resd 1
 num: resw 1
 temp: resb 1
 node: resb 1
 i: resd 1
 j: resd 1
 k: resd 1
 limt: resd 1
 fl: resb 1
 nfl: resb 1

section .data
 msg1 db 'Enter the first string: '
 len1 equ $-msg1
 msg2 db 'Enter the second string: '
 len2 equ $-msg2
 newline db 10
 spa db 32
 zero db '0'
 nega db '-1'
