section .data
   str1 db 'Nhap so thu nhat: ', 10, 0 
   len1 equ $ - str1
   str2 db 'Nhap so thu hai: ', 10, 0
   len2 equ $ - str2
   error db 'Nhap so sai '
   len3 equ $ - error
   newnum db ' ', 10, 0 ; Lưu tổng của num1 + num2
   output db 10 dup(0) ; Lưu từng chữ số của tổng vào
   temp db ' ', 10, 0
section .bss
   num1 resb 10
   num2 resb 10
section .text
   global _start
_start:
   ;In thông báo nhập chuỗi thứ nhất
   mov edx, len1
   mov ecx, str1
   mov ebx, 1
   mov eax, 4
   int 0x80

   ;Nhập chuỗi thứ nhất
   mov edx, 10 ; Cho bằng 10 vì tối đa 31bit
   mov ecx, num1
   mov ebx, 0
   mov eax, 3
   int 0x80

; Đổi chuỗi num1 thành số nguyên
   xor ecx, ecx
   mov ecx, num1  ; Gán chuỗi num1 cho thanh ghi ecx
   mov eax, 0   ; Tạo eax = 0 để tính giá trị chuỗi
loop1:
   cmp byte [ecx], 0  ; So sánh với ký tự null nếu đúng thì thực hiện done1
   je done1
   cmp byte [ecx], 0x0A ; So sánh với ký tự xuống dòng nếu đúng thì thực hiện done1
   je done1
   sub byte [ecx], 48 ; chuyển đổi ký tự sang số nguyên
   imul eax, 10  ; Nhân eax với 10
   add al, [ecx]  ; Cộng eax với số nguyên vừa được chuyển đổi
   inc ecx    ; tăng ecx lên 1 đơn vị để thực hiện ký tự tiếp theo
   jmp loop1  ; Thực hiện lại vòng lặp
done1:
   cmp eax, 2147483647 ; neu lon hon 2 mu 31 tru 1 thi exit
   jg exit
   mov [num1], eax  ; Lưu giá trị số nguyên mới vào biến num1
   
   ;In thông báo nhập chuỗi thứ hai
   mov edx, len2
   mov ecx, str2
   mov ebx, 1
   mov eax, 4
   int 0x80

   ;Nhập số thứ 2
   mov edx, 10 ; Cho bằng 10 vì tối đa 31bit
   mov ecx, num2
   mov ebx, 0
   mov eax, 3
   int 0x80
   
   
   xor ecx, ecx ; ecx = 0
   ; Đổi chuỗi num2 thành số nguyên
   mov ecx, num2  ; Gán chuỗi num2 cho thanh ghi ecx
   mov eax, 0   ; Tạo eax = 0 để tính giá trị chuỗi
loop2:
   cmp byte [ecx], 0  ; So sánh với ký tự null nếu đúng thì thực hiện done2
   je done2
   cmp byte [ecx], 0x0A ; So sánh với ký tự xuống dòng nếu đúng thì thực hiện done2
   je done2
   sub byte [ecx], 48 ; chuyển đổi ký tự sang số nguyên
   imul eax, 10  ; Nhân eax với 10
   add al, [ecx]  ; Cộng eax với số nguyên vừa được chuyển đổi
   inc ecx    ; tăng ecx lên 1 đơn vị để thực hiện ký tự tiếp theo
   jmp loop2  ; Thực hiện lại vòng lặp
done2:
	cmp eax, 2147483647 ; neu lon hon 2 mu 31 tru 1 thi exit
   jg exit
   mov [num2], eax  ; Lưu giá trị số nguyên mới vào biến num2
   
   mov eax, [num1] ; Lưu giá trị num1 vào eax
   add eax, [num2] ; Cộng giá trị num2 vào eax
   mov [newnum], eax ; Lưu giá trị eax vào giá trị của newnum
   
   ; Đẩy từng số nguyên vào stack
   mov eax, [newnum] ; Gán eax bằng với giá trị newnum
   mov ebx, 10 ; Gán ebx bằng 10 để chia
   mov edi, 0 ; gán edi = 0 để đếm số lần chia
loop3:
   xor edx, edx ; cho edx về 0 để lưu số dư
   div ebx ; Lấy eax chia cho ebx phân nguyên được lưu vào eax phân dư được lưu vào edx
   push edx ; đẩy edx lên stack
   inc edi ; tăng biến đếm lên 1
   cmp eax, 0 ; so sánh eax với 0 nếu khác thì thực hiện tiếp vòng lặp
   jnz loop3
   
   mov [temp], edi
   mov esi, output ; đưa địa chỉ của mảng vào thanh ghi esi
loop4:
   xor edx, edx ; đặt thanh ghi EDX bằng 0 để tính lại giá trị số
   pop edx ; lấy phần dư từ stack vào thanh ghi edx
   dec edi ; Vì edi đã lưu số lần chia nên bây giờ giảm 1 đơn vị. Khi nào về 0 thì dừng
   add dl, '0' ; chuyển giá trị phần dư thành ký tự ASCII tương ứng
   mov byte [esi], dl  ; lưu ký tự vào mảng
   inc esi ; tăng con trỏ mảng lên 1
   cmp edi, 0 ; kiểm tra xem edi đã về 0 chưa nếu chưa thì thực hiện tiếp vòng lặp
   jnz loop4
   
   ; In ra chuỗi kết quả
   mov eax, 4
   mov ebx, 1
   lea ecx, [output] ; đưa địa chỉ của chuỗi số vào thanh ghi ecx
   mov edx, [temp]
   int 0x80
   
exit:   ;Kết thúc chương trình
   mov eax, 1
   xor ebx, ebx
   int 0x80
   
