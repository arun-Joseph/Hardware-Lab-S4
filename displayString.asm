;Write a program to read a sentence and display those words whose size is greater than ‘n’.

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

 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h

readn:
 mov eax, 3
 mov ebx, 0
 mov ecx, temp
 mov edx, 1
 int 80h

 cmp byte[temp], 10
 je b2

 mov ax, word[num]
 mov bx, 10
 mul bx
 mov bl, byte[temp]
 sub bl, 30h
 mov bh, 0
 add ax, bx
 mov word[num], ax
 jmp readn

b2:
 mov dword[i], 0
 mov dword[j], 0
 loop1:
  mov eax, dword[i]
  cmp eax, dword[len]
  jae exit

  mov ecx, dword[i]
  mov al, byte[str+ecx]
  cmp al, 32
  jne b3

  mov bx, word[count]
  cmp bx, word[num]
  jbe b4

  loop2:
   mov eax, dword[j]
   cmp eax, dword[i]
   je b5

   mov ecx, dword[j]
   mov al, byte[str+ecx]
   mov byte[temp], al

   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h
   inc dword[j]
   jmp loop2

 b5:
  mov eax, 4
  mov ebx, 1
  mov ecx, spa
  mov edx, 1
  int 80h

 b4:
  mov eax, dword[i]
  inc eax
  mov dword[j], eax
  mov word[count], -1

 b3:
  inc word[count]
  inc dword[i]
  jmp loop1

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
 temp: resb 1
 count: resw 1
 num: resw 1
 i: resd 1
 j: resd 1

section .data
 msg1 db 'Enter a sentence: '
 len1 equ $-msg1
 msg2 db 'Enter n: '
 len2 equ $-msg2
 newline db 10
 spa db 32
