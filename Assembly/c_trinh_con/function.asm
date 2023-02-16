section .text
   global _start
section .data
   mes db 'Hi, I am Dwc', 10
_start:
   mov eax, mes
   call strlen
   ; eax = mes
   ; strlen()
   
   mov ecx, mes
   mov edx, eax
   mov eax, 0x04
   mov ebx, 1
   int 0x80
   ;printf("%s", mes)
   
   mov eax, 0x01
   int 0x80
strlen:
   push ebx
   mov ebx, eax
   ; push ebx
   ; ebx = eax
   
next_char:
   cmp byte [eax], 0
   jz finished
   inc eax
   jmp next_char
   ; if (mes[eax] == '\n') finished()
   ;next_char()
   
finished:
  sub eax, ebx
  pop ebx
  ret
  ;eax -= ebx
  ; pop ebx
