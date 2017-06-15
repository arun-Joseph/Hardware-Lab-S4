;Write a program to sort an array of floating point numbers.

section .text
global main
 extern scanf
 extern printf

print:
 push ebp
 mov ebp, esp
 sub esp, 8
 fst qword[ebp-8]
 push format2
 call printf
 mov esp, ebp
 pop ebp
 ret

read:
 push ebp
 mov ebp, esp
 sub esp, 8
 lea eax, [esp]
 push eax
 push format1
 call scanf
 fld qword[ebp-8]
 mov esp, ebp
 pop ebp
 ret

main:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg1
 mov edx, len1
 int 80h

 push len
 push format3
 call scanf
 
 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h
 
 mov dword[i], 0
 loop1:
  mov eax, dword[i]
  cmp eax, dword[len]
  je a1
  
  call read
  mov ecx, dword[i]
  add ecx, ecx
  add ecx, ecx
  add ecx, ecx
  fstp qword[arr+ecx]
  inc dword[i]
  jmp loop1
  
 a1:
  mov dword[i], 0
 
 loop2:
  mov eax, dword[i]
  cmp eax, dword[len]
  je a2
  
  mov dword[j], 0
  loop3:
   mov eax, dword[i]
   add eax, dword[j]
   add eax, 1
   cmp eax, dword[len]
   je a3
   
   mov ecx, dword[j]
   add ecx, ecx
   add ecx, ecx
   add ecx, ecx
   fld qword[arr+ecx]
   add ecx, 8
   fcomp qword[arr+ecx]
   fstsw ax
   sahf
   jb a4
   
   mov ecx, dword[j]
   add ecx, ecx
   add ecx, ecx
   add ecx, ecx
   fld qword[arr+ecx]
   fstp qword[temp]
   fld qword[arr+ecx+8]
   fstp qword[arr+ecx]
   fld qword[temp]
   fstp qword[arr+ecx+8]
   
  a4:
   inc dword[j]
   jmp loop3
   
  a3:
   inc dword[i]
   jmp loop2
  
 a2:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, len3
  int 80h
 
  mov dword[i], 0
  
 loop4:
  mov eax, dword[i]
  cmp eax, dword[len]
  je exit
  
  mov ecx, dword[i]
  add ecx, ecx
  add ecx, ecx
  add ecx, ecx
  fld qword[arr+ecx]
  call print
  inc dword[i]
  jmp loop4
   
exit:
 mov eax, 1
 mov ebx, 0
 int 80h

section .bss
 arr: resq 100
 len: resd 1
 temp: resq 1
 i: resd 1
 j: resd 1

section .data
 msg1 db "Enter the size : "
 len1 equ $-msg1
 msg2 db "Enter the array :- "
 len2 equ $-msg2
 msg3 db "The sorted array is :- ",10
 len3 equ $-msg3
 format1 db "%lf",0
 format3 db "%d",0
 format2 db "%lf ",10
 
