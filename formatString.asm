;Write a menu driven program to implement the below three choices :-
;a. UPPER (str) -> convert input string to Upper case.
;b. LOWER(str) -> convert input string to Lower case.
;c. CAPITALIZE(str) -> first character in Upper case and all other character in Lower case.

section	.text
 global _start

reads:
 mov dword[len], 0
 loop_read:
  mov eax, 3
  mov ebx, 0
  mov ecx, temp
  mov edx, 1
  int 80h

  cmp byte[temp], 10
  je b1

  mov ecx, dword[len]
  mov al, byte[temp]
  mov byte[str+ecx], al
  inc dword[len]
  jmp loop_read

 b1:
  ret

upper:
 mov dword[i], 0
 printu:
  mov ecx, dword[i]
  cmp ecx, dword[len]
  je norm

  mov al, byte[str+ecx]
  mov byte[temp], al

  cmp byte[temp], 'a'
  jb out1
  cmp byte[temp], 'z'
  ja out1

  sub byte[temp], 32
  out1:
   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h

  inc dword[i]
  jmp printu

lower:
 mov dword[i], 0
 printl:
  mov ecx, dword[i]
  cmp ecx, dword[len]
  je norm

  mov al, byte[str+ecx]
  mov byte[temp], al

  cmp byte[temp], 'A'
  jb out2
  cmp byte[temp], 'Z'
  ja out2

  add byte[temp], 32
  out2:
   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h

  inc dword[i]
  jmp printl

capitalize:
 cmp dword[len], 0
 je norm

 cmp byte[str], 'a'
 jb out3
 cmp byte[str], 'z'
 ja out3

 sub byte[str], 32

 out3:
  mov eax, 4
  mov ebx, 1
  mov ecx, str
  mov edx, 1
  int 80h

 mov dword[i], 1
 printc:
  mov ecx, dword[i]
  cmp ecx, dword[len]
  je norm

  mov al, byte[str+ecx]
  mov byte[temp], al

  cmp byte[temp], 'A'
  jb out4
  cmp byte[temp], 'Z'
  ja out4

  add byte[temp], 32
  out4:
   mov eax, 4
   mov ebx, 1
   mov ecx, temp
   mov edx, 1
   int 80h

  inc dword[i]
  jmp printc

_start:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

 mov eax, 3
 mov ebx, 0
 mov ecx, choice
 mov edx, 2
 int 80h
 
 cmp byte[choice], '4'
 je exit

 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h

 call reads

 mov eax, 4
 mov ebx, 1
 mov ecx, msg3
 mov edx, len3
 int 80h

 cmp byte[choice], '1'
 je upper
 cmp byte[choice], '2'
 je lower
 cmp byte[choice], '3'
 je capitalize

 norm:
  mov eax, 4
  mov ebx, 1
  mov ecx, newline
  mov edx, 1
  int 80h
  jmp _start

 exit:
  mov eax, 1
  mov ebx, 0
  int 80h

section .bss
 str: resb 100
 len: resd 1
 choice: resb 1
 temp: resb 1
 i: resd 1

section	.data
 msg1 db 'Menu :-',10,' 1. Upper',10,' 2. Lower',10,' 3. Capitalize',10,' 4. Exit',10,'Enter your choice: '
 len1 equ $-msg1
 msg2 db 'Enter the string: '
 len2 equ $-msg2
 msg3 db 'The new string: '
 len3 equ $-msg3
 newline db 10
