section .text
    global _start
section .bss                         ;block starting symbol
    num1 resb 10
    num2 resb 10    
section .data
_start:
    ; Nhập số thứ nhất
    mov ecx, num1      
    inc ecx
    mov edx,10
    mov eax, 0x03
    mov ebx, 0
    int 0x80
    ;Nhập số thứ hai
    mov ecx, num2   
    mov edx, 10
    mov eax, 0x03
    mov ebx, 0
    int 0x80
    
    mov ecx, num1 ; Gán chuỗi trong num1 cho ecx 
    mov al,[ecx] ; Xét tuwnngf ký tự trong chuõi
    add al,'0' ; Cộng từng ký tự cho '0' hay 48
    mov [ecx],al ; Gán lại tronng chuỗi của ecx
    mov edx, num2 ; Gán chuỗi trong num2 cho edx 
    dec edx ; edx--
    call cong ; gọi hàm cộng
    call to0 ; gọi hàm to0
    
    mov ecx, num1
    mov edx, 10
    mov eax, 0x04
    mov ebx, 0
    int 0x80

    mov eax, 0x01
    int 0x80
cong: 
    inc ecx ; ecx++
    mov al, [ecx] ; gán từng ký tự chuỗi trong ecx cho al
    cmp al, 0xa ; so sánh ký tự với rỗng
    je done ; nếu đúng kết thúc chương trình
    sub al,'0' ; al - '0' sẽ trả về số nguyên cho ký tự đó
    inc edx ; edx ++
    mov bl, [edx] ; gán từng ký tự chuỗi edx cho bl
    sub bl,'0' ; bl - '0' sẽ trả về số nguyên cho ký tự đó
    add al, bl ; al += bl;
    cmp al, 9 ; so sánh al với 9
    ja lon_hon_9 ; Nếu lớn hơn 9 thì gọi hàm lon_hon_9
    add al, '0' ; al - '0' sẽ trả về kiểu str 
    mov [ecx], al ; Gán ký tự al vào chuỗi ecx
    jmp cong ; thực hiện ký tự tiếp theo
    ret   

to0:                ;value: 0123 -> 123
    mov ecx, num1 ; Gán chuỗi số thứ nhất cho ecx
    mov al, [ecx] ; Gán al với từng ký tự chuỗi trong acx
    cmp al, '0' ; So sánh al với null
    je to_0 ; Nếu đúng gọi hàm to_0
    ret

to_0:
    mov al, 0 ; al = 0
    mov [ecx], al ; Gán lại cho vị trí chuỗi ecx đang tính với giá al
    ret
    
    
lon_hon_9:            ;value:1a2 -> 202
    mov ebx,ecx ; ebx += ecx
    jmp xu_ly ; gọi hàm xu li
    ret    

xu_ly:
    sub al, 10 ; al -= 10 (Vì lớn hơn 10 nên trừ 10 ròi nhớ 1)
    add al, '0' ; al + '0' để lấy kus tự
    mov [ebx], al ; Gán ký tự al vào vị trí đang tính hiện tại chuỗi ebx
    dec ebx ; ebx--
    mov al, [ebx] ; Gán từng ký tự của chuỗi trong ebx cho al
    add al, 1 ; al += 1
    sub al, '0' ; al - '0' để trả về kiểu số nguyên
    cmp al, 9 ; so sánh al với 9 
    ja xu_ly ; Nếu lớn hơn thì thực hiện lại hàm xu_ly
    add al, '0' ; al +'0' trả lại ký tự tương ứng số
    mov [ebx], al ; Gán ký tự vừa rồi vào lại chuỗi ebx đang tính hiện tại
    jmp cong ; thực hiện tiếp hàm cộng
    ret
done:
    ret