;Write a program to calculate the Euclidean distance between points p and q in 3-dimentional points.

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

 call read
 fstp qword[x1]
 call read
 fstp qword[y1]
 call read
 fstp qword[z1]
 
 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h
 
 call read
 fstp qword[x2]
 call read
 fstp qword[y2]
 call read
 fstp qword[z2]
 
 mov eax, 4
 mov ebx, 1
 mov ecx, msg3
 mov edx, len3
 int 80h
 
 fld qword[x1]
 fsub qword[x2]
 fmul st0
 fld qword[y1]
 fsub qword[y2]
 fmul st0
 fadd st1
 fld qword[z1]
 fsub qword[z2]
 fmul st0
 fadd st1
 fsqrt
 call print

exit:
 mov eax, 1
 mov ebx, 0
 int 80h

section .bss
 x1: resq 1
 x2: resq 1
 y1: resq 1
 y2: resq 1
 z1: resq 1
 z2: resq 1

section .data
 msg1 db "Enter point P :- "
 len1 equ $-msg1
 msg2 db "Enter point Q :- "
 len2 equ $-msg2
 msg3 db "The Euclidean distance  is :- "
 len3 equ $-msg3
 format1 db "%lf",0
 format2 db "%lf ",10