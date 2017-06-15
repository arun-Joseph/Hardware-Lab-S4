;Compute the sin series below :-
;cos x = 1-x^2/2!+x^4/4!-x^6/6!+..... n terms
;Calculate cos(x) by processor instruction and compare the result with the above one.

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

pow:
 fld1
 fstp qword[p]
 mov dword[j], 0
 lp1:
  mov eax, dword[j]
  cmp eax, dword[i]
  je b1
  
  fld qword[p]
  fmul qword[x]
  fmul qword[x]
  fchs
  fstp qword[p]
  inc dword[j]
  jmp lp1
  
 b1:
  ret

fact:
 fld1
 fstp qword[f]
 
 mov eax, dword[i]
 add eax, eax
 mov dword[j], eax
 lp2:
  cmp dword[j], 0
  je b2
  
  fld qword[f]
  fimul dword[j]
  fstp qword[f]
  dec dword[j]
  jmp lp2
  
 b2:
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
 
 call read
 fstp qword[x]
 fldz
 fstp qword[res]

 mov dword[i], 0
 loop1:
  mov eax, dword[i]
  cmp eax, dword[n]
  je a1
  
  call pow
  fld qword[p]
  call fact
  fdiv qword[f]
  fadd qword[res]
  fstp qword[res]
  inc dword[i]
  jmp loop1
 
 a1:
  mov eax, 4
  mov ebx, 1
  mov ecx, msg3
  mov edx, len3
  int 80h
  
  fld qword[res]
  call print
  
  mov eax, 4
  mov ebx, 1
  mov ecx, msg4
  mov edx, len4
  int 80h
  
  fld qword[x]
  fcos
  call print
 
 fcom qword[res]
 fstsw ax
 sahf
 jne a2
 
 mov eax, 4
 mov ebx, 1
 mov ecx, ans1
 mov edx, l1
 int 80h
 jmp exit
 
 a2:
  fcom qword[res]
  fstsw ax
  sahf
  ja a3
  
  mov eax, 4
  mov ebx, 1
  mov ecx, ans2
  mov edx, l2
  int 80h
  jmp exit
  
  a3:
   mov eax, 4
   mov ebx, 1
   mov ecx, ans3
   mov edx, l3
   int 80h
 
exit:
 mov eax, 1
 mov ebx, 0
 int 80h

section .bss
 n: resd 1
 x: resq 1
 res: resq 1
 i: resd 1
 j: resd 1
 p: resq 1
 f: resq 1

section .data
 msg1 db "Enter n :- "
 len1 equ $-msg1
 msg2 db "Enter x :- "
 len2 equ $-msg2
 msg3 db "The cosine series value  is :- "
 len3 equ $-msg3
 msg4 db "The cosine processor instruction value is :- "
 len4 equ $-msg4
 ans1 db "The results are the same",10
 l1 equ $-ans1
 ans2 db "The cosine series value is higher than processor value",10
 l2 equ $-ans2
 ans3 db "The cosine series value is lower than processor value",10
 l3 equ $-ans3
 format1 db "%lf",0
 format3 db "%d",0
 format2 db "%lf ",10