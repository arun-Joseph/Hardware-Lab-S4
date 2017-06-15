;Given a string containing characters, numbers and special symbols, write a program to find list of alphabets, numbers and special symbols in the string.

section	.text
 global _start

reads:
 mov dword[l1], 0
 mov dword[l2], 0
 mov dword[l3], 0

 loop_read:
  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  cmp byte[temp], 10
  je b1

  cmp byte[temp], '0'
  jb splk
  cmp byte[temp], '9'
  jbe numb
  cmp byte[temp], 'A'
  jb splk
  cmp byte[temp], 'Z'
  jbe alp
  cmp byte[temp], 'a'
  jb splk
  cmp byte[temp], 'z'
  jbe alp

 splk:
  mov ecx, dword[l3]
  mov al, byte[temp]
  mov byte[str3+ecx], al
  inc dword[l3]
  jmp b2

 numb:
  mov ecx, dword[l2]
  mov al, byte[temp]
  mov byte[str2+ecx], al
  inc dword[l2]
  jmp b2

 alp:
  mov ecx, dword[l1]
  mov al, byte[temp]
  mov byte[str1+ecx], al
  inc dword[l1]
  jmp b2

 b2:
  jmp loop_read

 b1:
  ret

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

 call reads

 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h

 mov dword[i], 0
 print1:
  mov eax, dword[i]
  cmp eax, dword[l1]
  je out1

  mov ecx, dword[i]
  mov al, byte[str1+ecx]
  mov byte[temp], al

  inc dword[i]
  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h
  jmp print1

 out1:
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, 1
  int 80h

 mov eax, 4
 mov ebx, 1
 mov ecx, msg3
 mov edx, len3
 int 80h

 mov dword[i], 0
 print2:
  mov eax, dword[i]
  cmp eax, dword[l2]
  je out2

  mov ecx, dword[i]
  mov al, byte[str2+ecx]
  mov byte[temp], al

  inc dword[i]
  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h
  jmp print2

 out2:
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, 1
  int 80h

 mov eax, 4
 mov ebx, 1
 mov ecx, msg4
 mov edx, len4
 int 80h

 mov dword[i], 0
 print3:
  mov eax, dword[i]
  cmp eax, dword[l1]
  je exit

  mov ecx, dword[i]
  mov al, byte[str3+ecx]
  mov byte[temp], al

  inc dword[i]
  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h
  jmp print3

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
 str3: resb 100
 l3: resd 1
 temp: resb 1
 i: resd 1

section	.data
 msg1 db 'Enter the sentence : '
 len1 equ $-msg1
 msg2 db 'Alphabets: '
 len2 equ $-msg2
 msg3 db 'Numbers: '
 len3 equ $-msg3
 msg4 db 'Special Char: '
 len4 equ $-msg4
 newline db 10
