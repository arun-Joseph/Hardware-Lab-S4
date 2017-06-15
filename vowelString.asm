;Write a program to read a sentence add an in front of all the vowel words.

section	.text
 global _start

reads:
 mov word[len], 0

 loop_read:
  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  cmp byte[temp], 10
  je b1

  mov al, byte[temp]
  mov ecx, dword[len]
  mov byte[str+ecx], al
  inc dword[len]
  jmp loop_read

 b1:
  ret

vowel:
 cmp byte[str+ecx], 'a'
 je pan
 cmp byte[str+ecx], 'e'
 je pan
 cmp byte[str+ecx], 'i'
 je pan
 cmp byte[str+ecx], 'o'
 je pan
 cmp byte[str+ecx], 'u'
 je pan
 cmp byte[str+ecx], 'A'
 je pan
 cmp byte[str+ecx], 'E'
 je pan
 cmp byte[str+ecx], 'I'
 je pan
 cmp byte[str+ecx], 'O'
 je pan
 cmp byte[str+ecx], 'U'
 je pan

 ret

 pan:
  mov al, byte[str+ecx]
  mov byte[temp], al

  cmp ecx, 0
  je pcan

  mov eax, 4
  mov ebx, 1
  mov ecx, an
  mov edx, 3
  int 80h
  ret

 pcan:
  mov eax, 4
  mov ebx, 1
  mov ecx, can
  mov edx, 3
  int 80h
  ret

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, query1
 mov edx, len1
 int 80h

 call reads
 mov ecx, 0
 call vowel

 mov dword[i], 0
 prints:
  mov eax, dword[i]
  cmp eax, dword[len]
  je exit

  mov ecx, dword[i]
  cmp byte[str+ecx], 32
  jne last

  inc dword[i]
  mov eax, 4
  mov ebx, 1
  mov ecx, spa
  mov edx, 1
  int 80h

  mov ecx, dword[i]
  call vowel

 last:
  mov ecx, dword[i]
  mov al, byte[str+ecx]
  mov byte[temp], al

  mov eax, 4
  mov ebx, 1
  mov ecx, temp
  mov edx, 1
  int 80h

  inc dword[i]
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
 str: resb 100
 num: resw 1
 temp: resb 1
 len: resd 1
 i: resd 1

section	.data
 query1 db 'Enter the sentence : '
 len1 equ $-query1
 an db 'an '
 can db 'An '
 newline db 10
 spa db 32
