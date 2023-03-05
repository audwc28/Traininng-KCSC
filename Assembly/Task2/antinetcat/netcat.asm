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
    xor rsi, rsi
    xor rdx, rdx
    syscall
    mov rbx, rax

    ; Đọc thông tin
    mov rax, 0xd9
    xor rdi, rdi
    lea rsi, [buf]
    xor rdx, rdx
    syscall

    ; In buf
    mov rax, 0x01
    mov rdi, 1
    lea rsi, [buf]
    mov rdx, 1000
    syscall

    mov rax, 0x3c
    xor rdi, rdi
    syscall

