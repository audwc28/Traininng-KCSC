sectionn .data   
sectionn .bss
    chuoi resd 32 ; char chuoi[32]
sectionn .text
    global _start
_start:

    mov ecx, chuoi ; gán biến chuỗi cho ecx
    mov edx, 32 ; Gán số lượng ký tự tối đa cho edx
    mov eax, 0x03 ; gọi sys_read
    mov ebx, 0 ; gán 1 số nguyên cho 
    int 0x80 ; thực thi hàm

    mov edx, chuoi ; gán chuỗi vừa nhập cho edx
    
    call inHoa ; gọi hàm in hoa
    
    mov ecx, chuoi ; gán biến chuỗi cho ecx
    mov edx, 32 ; Gán số lượng ký tự tối đa cho edx
    mov eax, 0x04 ; gọi sys_write
    mov ebx, 0 ; gán 1 số nguyên cho 
    int 0x80 ; thực thi hàm
    
    mov eax, 0x01 ; gọi sys_exit
    int 0x80 ; thực thi hàm

inHoa:
    mov bl, byte [edx] ; gán từng ký tự trong chuỗi cho bl
    cmp bl, 0x0 ; kiểm tra có trùng 0x0 không
    je done ; có thì chuyển đến hàm done
    cmp bl, 'a' ; 4 câu lệnh tiếp theo có nghĩa là kiểm tra xem 'a' <= bl <= 'z'
    jb tiepTuc ; nếu đúng thì thực hiện câu lệnh sub bl, 0x20
    cmp bl, 'z' ; sai thì thực hiện hàm tiếp tục
    ja tiepTuc
    sub bl, 0x20 ; tronng mã ascii thì ký tự thường cộng 0x20 lên sẽ thành ký tự in hoa
    mov [edx], bl ; gán ký tự mới đổi sang in hoa cho [edx]

tiepTuc:
    inc edx ; tăng edx lên 1 đơn vị
    jmp inHoa ; thực hiện hàm inHoa
    
done:
    ret ; xonng hàm in hoa











    



    
    










