;Find the product of 2 floating points numbers.

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
 call read
 fmul st1
 call print

exit:
 mov eax, 1
 mov ebx, 0
 int 80h

section .data
 format1 db "%lf",0
 format2 db "The product is : %lf",10
 msg1 db "Enter 2 numbers : "
 len1 equ $-msg1
