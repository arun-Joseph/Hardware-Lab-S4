;Write a program to read an array and to find tuple (a,b,c) which maximize product a*b*c, where a,b,c are elements of the array. a,b,c must be distinct.

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

 push n
 push format3
 call scanf
 
 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h
 
 mov dword[i], 0
 mov dword[len], 0
 loop0:
  mov eax, dword[i]
  cmp eax, dword[n]
  je a1
  
  call read
  fstp qword[temp]
  
  mov dword[j], 0
  loopx:
   mov eax, dword[j]
   cmp eax, dword[len]
   je x1
   
   fld qword[temp]
   mov ecx, dword[j]
   add ecx, ecx
   add ecx, ecx
   add ecx, ecx
   fcomp qword[arr+ecx]
   fstsw ax
   sahf
   je x2
   inc dword[j]
   jmp loopx
  
 x1: 
  fld qword[temp]
  mov ecx, dword[len]
  add ecx, ecx
  add ecx, ecx
  add ecx, ecx
  fstp qword[arr+ecx]
  inc dword[len]
  
 x2:
  inc dword[i]
  jmp loop0
  
 a1:
  mov eax, dword[len]
  mov dword[n], eax
 
  cmp dword[n], 3
  jae a0
  
  mov eax, 4
  mov ebx, 1
  mov ecx, msg4
  mov edx, len4
  int 80h
  jmp exit
  
 a0:
  mov dword[cons], 10000
  fild dword[cons]
  fchs
  fstp qword[max]
  mov dword[i], 0
  loop1:
   mov eax, dword[i]
   add eax, 2
   cmp eax, dword[n]
   je an
   
   mov eax, dword[i]
   mov dword[j], eax
   inc dword[j]
   loop2:
    mov eax, dword[j]
    add eax, 1
    cmp eax, dword[n]
    je a2
    
    mov eax, dword[j]
    mov dword[k], eax
    inc dword[k]
    loop3:
     mov eax, dword[k]
     cmp eax, dword[n]
     je a3
     
     fld1
     mov ecx, dword[i]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fmul qword[arr+ecx]
     mov ecx, dword[j]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fmul qword[arr+ecx]
     mov ecx, dword[k]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fmul qword[arr+ecx]
     fcom qword[max]
     fstsw ax
     sahf
     jna a4
     
     fst qword[max]
     
    a4:
     ffree st0
     inc dword[k]
     jmp loop3
    
   a3:
    inc dword[j]
    jmp loop2
    
  a2:
  inc dword[i]
  jmp loop1
  
 an:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, len3
  int 80h
 
 b1:
  mov dword[i], 0
  lop1:
   mov eax, dword[i]
   add eax, 2
   cmp eax, dword[n]
   je exit
   
   mov eax, dword[i]
   mov dword[j], eax
   inc dword[j]
   lop2:
    mov eax, dword[j]
    add eax, 1
    cmp eax, dword[n]
    je b2
    
    mov eax, dword[j]
    add eax, 1
    mov dword[k], eax
    lop3:
     mov eax, dword[k]
     cmp eax, dword[n]
     je b3
     
     fld1
     mov ecx, dword[i]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fmul qword[arr+ecx]
     mov ecx, dword[j]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fmul qword[arr+ecx]
     mov ecx, dword[k]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fmul qword[arr+ecx]
     fcomp qword[max]
     fstsw ax
     sahf
     jne b4
     
     mov eax, 4
     mov ebx, 1
     mov ecx, newline
     mov edx, 1
     int 80h
     
     mov ecx, dword[i]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fld qword[arr+ecx]
     call print
     ffree st0
     mov ecx, dword[j]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fld qword[arr+ecx]
     call print
     ffree st0
     mov ecx, dword[k]
     add ecx, ecx
     add ecx, ecx
     add ecx, ecx
     fld qword[arr+ecx]
     call print
     ffree st0
     
    b4:
     inc dword[k]
     jmp lop3
    
   b3:
    inc dword[j]
    jmp lop2
    
  b2:
  inc dword[i]
  jmp lop1
  
exit:
 mov eax, 1
 mov ebx, 0
 int 80h

section .bss
 arr: resq 100
 n: resd 1
 len: resd 1
 temp: resq 1
 i: resd 1
 j: resd 1
 k: resd 1
 cons: resd 1
 max: resq 1
 res: resq 1

section .data
 msg1 db "Enter the size :- "
 len1 equ $-msg1
 msg2 db "Enter the array :- "
 len2 equ $-msg2
 msg3 db "The max tuple is :- "
 len3 equ $-msg3
 msg4 db "No tuples possible",10
 len4 equ $-msg4
 newline db 10
 format1 db "%lf",0
 format3 db "%d",0
 format2 db "%lf ",10