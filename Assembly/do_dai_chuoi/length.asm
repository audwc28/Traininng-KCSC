section .text
   global _start
section .data
   mes db 'Hi, I am 4uDwc', 10
_start:
   mov ebx, mes
   mov eax, ebx
	; ebx = mes
	; eax = ebx
next_char:
   cmp byte [eax], 0
   jz finished
   inc eax
   jmp next_char
	; if (str[eax] == '\n') fininshed();
	; eax++
	; next_char() ;
	
finished:
   sub eax, ebx
   ; eax -= ebx
    
   mov ecx, mes
   mov edx, eax
   mov eax, 0x04
   mov ebx, 1
   int 0x80
   ; printf("%c", mes)
   
   mov eax, 0x01
   mov ebx, 0
   int 0x80
