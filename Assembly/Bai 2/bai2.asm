section .text
    global _start
section .bss
    mess resb 32 ; char mess[32];
section .data
_start:
    mov eax, 0x03 ; gọi hàm sys_read
    mov ebx, 1 ; gán 1 số nguyên có thanh ghi ebx
    mov ecx, mess ; gán biến mess cho thanh ghi ecx
    mov edx, 32 ; gán độ dài chuỗi tối đa cho thanh ghi edx
    int 0x80 ; thực thi hàm
    
    mov eax, 0x04 ; gọi hàm sys_write
    mov ebx, 1 ; gán 1 số nguyên có thanh ghi ebx
    mov ecx, mess ; gán biến mess cho thanh ghi ecx
    mov edx, 32 ; gán độ dài chuỗi tối đa cho thanh ghi edx
    int 0x80 ; thực thi hàm

    mov eax, 0x01 ; gọi hàn sys_exit
    int 0x80 ; thực thi hàm