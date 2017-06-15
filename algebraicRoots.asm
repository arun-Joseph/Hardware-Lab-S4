;Find the algebraic roots of the equation a*x^2+b*x+c, where a,b,c are given as the inputs.

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
 fstp qword[a]
 call read
 fstp qword[b]
 call read
 fstp qword[c]
 fld qword[b]
 fmul st0
 fld qword[a]
 fmul qword[c]
 mov dword[cons], 4
 fimul dword[cons]
 fsubr st1
 fstp qword[d]
 ffree st0

 fldz
 fcomp qword[d]
 fstsw ax
 sahf
 jna a1

 mov eax, 4
 mov ebx, 1
 mov ecx, msg2
 mov edx, len2
 int 80h
 jmp exit

a1:
 fldz
 fcomp qword[d]
 fstsw ax
 sahf
 jne a2

 mov eax, 4
 mov ebx, 1
 mov ecx, msg3
 mov edx, len3
 int 80h

 fldz
 fsub qword[b]
 mov dword[cons], 2
 fidiv dword[cons]
 fdiv qword[a]
 call print
 jmp exit

a2:
 mov eax, 4
 mov ebx, 1
 mov ecx, msg4
 mov edx, len4
 int 80h

 fld qword[d]
 fsqrt
 fsub qword[b]
 mov dword[cons], 2
 fidiv dword[cons]
 fdiv qword[a]
 call print
 ffree st0

 fld qword[d]
 fsqrt
 fadd qword[b]
 fldz
 fsub st1
 mov dword[cons], 2
 fidiv dword[cons]
 fdiv qword[a]
 call print

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
 a: resq 1
 b: resq 1
 c: resq 1
 d: resq 1
 cons: resd 1

section .data
 msg1 db 'Enter 3 numbers : '
 len1 equ $-msg1
 msg2 db 'No roots',10
 len2 equ $-msg2
 msg3 db 'The root is ',10
 len3 equ $-msg3
 msg4 db 'The roots are ',10
 len4 equ $-msg4
 format1 db "%lf",0
 format2 db "%lf "
 newline db 10
