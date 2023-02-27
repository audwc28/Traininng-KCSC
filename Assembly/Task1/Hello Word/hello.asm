section	.text
	global _start ;khai báo để sử dụng gcc
_start:                     ;int _start
    mov eax, 0x04 ; gọi hàm sys_write
    mov ebx, 1 ; gán 1 số nguyên cho biến ebx
    mov ecx, mess ; gán biến cho thanh ghi ecx
	mov	edx, leng ; gán độ dài biến cho thanh ghi edx
	int	0x80   ; thực thi hàm
	
	mov	eax, 1 ; gọi hàm sys_exit
	int	0x80 ; thực thi hàm

section	.data

    mess db	'Hello, world!', 0xa ; string str = 'hello, word!'
    leng equ	$ - mess ; Gán độ dài chuỗi mess vào len