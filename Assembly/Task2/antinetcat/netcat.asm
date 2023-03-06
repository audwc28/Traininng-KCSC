section .data
    proc_path db "/proc/", 0
    netcat_str db "nc", 0
    timeout dw 100
section .bss
    buf resb 1000
section .text
    global _start
_start:
    ; Mở thư mục proc
    mov rax, 0x02
    mov rdi, proc_path
    mov rsi, 0
    xor rdx, rdx
    syscall
    mov rbx, rax

    mov rax, 0xd9
    mov rdx, 1000
    mov rsi, buf
    xor rdi, rdi
    syscall

    mov rdi, buf
checkfile:
    cmp byte [rdi], 0
    je exitCheck
    mov rsi, [rdi+8]    ; address of d_name field in the entry
    add rsi, rdi
    mov eax, 4
    mov edi, 1
    mov edx, 255
    syscall
        
    ; In xuống dòng
    mov rax, 4
    mov rdi, 1
    mov rdx, 1
    syscall
        
    ; Tính độ dài của entry và di chuyển đến entry kế tiếp
    mov rax, [rdi+16]   ; length of the entry
    add rdi, rax
    jmp checkfile

    exitCheck:
    ; Đóng thư mục
    mov eax, 3
    mov edi, ebx
    syscall
    
; Exit program
mov rax, 60
xor rdi, rdi
syscall






