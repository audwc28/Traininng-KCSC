section .data
   num1 db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
   num2 db 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
section .bss
   num3 resb 21
section .text
   global _start
_start:
   ; scanf("%s", num1);
   mov rdi, 0
   mov rsi, num1
   mov rdx, 20
   mov rax, 0
   syscall
   ; scanf("%s", &num2);
   mov rdi, 0
   mov rsi, num2
   mov rdx, 20
   mov rax, 0
   syscall
   ;
   ; Gán giá trị num1 cho r8, độ dài được tính bởi r10
   ; Gán giá trị num1 cho r9, độ dài được tính bởi r11
   ; Gán num3 cho rcx
   ; rdx là biến nhớ khi cộng lại lớn hơn 10
   ; Di chuyển đến cuối của num1 và num2
   ;
   mov r8, num1
   mov r9, num2
   mov r10, 1
   mov r11, 1
   mov rcx, num3
   mov rdx, 0
   call cuoiNum1
   call cuoiNum2
   call cong
   mov r8, num3
   mov r12, 1
   call inKetQua

   mov rax, 60
   xor rdi, rdi
   syscall
   ;
   ; while (true){
   ;    if (strcmp(num1[r8], 0xa) == 0) {
   ;        num1[r8] = '0';
   ;     }else{
   ;       r8++;
   ;     }  
   ; }
   ;
cuoiNum1:
   cmp byte [r8], 0x0A
   je done1
   inc r8
   inc r10
   jmp cuoiNum1
done1:
   ;mov byte [r8], 0x30
   dec r8
   dec r10
   ret

cuoiNum2:
   cmp byte [r9], 0x0A
   je done2
   inc r9
   inc r11
   jmp cuoiNum2
done2:
   ;mov byte [r9], 0x30
   dec r9
   dec r11
   ret
   ;
   ; while (true) {
   ;     if (r10 <= 0) { //Xem hết độ dài num1 chưa
   ;            if (r11 == 0) { //Xem hết độ dài chuỗi 2 chưa
   ;                 num3[rcx] += rdx;
   ;                 num3[rcx] += '0'; 
   ;                 num3[rcx] = ' '; Gán cho khảng trắng để đánh dấu in ngược lại
   ;                 break;
   ;            }
   ;                rbx = num[r9];
   ;                rbx -= '0';
   ;                num3[rcx] += rbx  + rdx;
   ;                ; Làm tiếp như hàm to 
   ;      }
   ;      if (r11 <= 0) { //Xem hết độ dài num2 chưa
   ;   
   ;      } 
   ;      rax = num1[r8];
   ;      rbx = num2[r9];
   ;      rax -= '0';
   ;      rbx -= '0';
   ;      num3[rcx] = rax + rbx + rdx; rdx là biến nhớ, mặc định ban đầu là 0
   ;      if (num3[rcx] > 10) { //Xem tổng có lớn hơn 10 ko
   ;          num3[rcx] -= 10;
   ;          num3[rcx] += '0';
   ;          rdx = 1; Gán biến nhớ bằng 1 khi tổng lớn hơn 10
   ;          rcx++; 
   ;          r8--; r9--;
   ;     }else {
   ;        num3[rcx] += '0';
   ;        rdx = 0; Gán nhớ bằng 0 khi tổng < 10
   ;        rcx++;
   ;        r10--; r11--;  
   ;     } 
   ; }
   ;
   ; Hàm này sẽ cộng từng chữ số từ phải qua trái 
   ; Kiểm tra xem tổng lớn hơn 10 không nếu có thì giảm 10 rồi lưu nhớ 1 vào rdx
   ; Tiếp tục chuyển sang cộng cột tiếp theo
   ; Cột cuối cùng sẽ cộng với biến nhớ nên có thể là 0 hoặc 1. Lát xử lý ở hàm in
   ; Ví dụ: 12 + 23 = 530, 9+1 = 01
   ;
cong:
   cmp r10 , 0
   jle hetChuoi1
   cmp r11, 0
   jle hetChuoi2
   mov rax, [r8]
   mov rbx, [r9]
   sub al, 48
   sub bl, 48
   add byte [rcx], al
   add byte [rcx], bl
   add byte [rcx], dl
   cmp byte [rcx], 10
   jge lonHon10
   add byte [rcx], 48
   mov rdx, 0
   inc rcx
   dec r8
   dec r9
   dec r10
   dec r11
   jmp cong
lonHon10:
   sub byte [rcx], 10
   add byte [rcx], 48
   mov rdx, 1
   inc rcx
   dec r8
   dec r9
   dec r10
   dec r11
   jmp cong
hetChuoi1:
   cmp r11, 0
   je done3
   mov rbx, [r9]
   sub bl, 48
   add byte [rcx], bl
   add byte [rcx], dl
   cmp byte [rcx], 10
   jge lonHon10chuoi1
   add byte [rcx], 48
   mov rdx, 0
   inc rcx
   dec r9
   dec r11
   jmp hetChuoi1
lonHon10chuoi1:
   sub byte [rcx], 10
   add byte [rcx], 48
   mov rdx, 1
   inc rcx
   dec r8
   dec r9
   dec r10
   dec r11
   jmp hetChuoi1
done3:
   add byte [rcx], dl
   add byte [rcx], 48
   inc rcx 
   mov byte [rcx], 0x20
   ret
hetChuoi2:
   cmp r10, 0
   je done4
   mov rax, [r8]
   sub al, 48
   add byte [rcx], al
   add byte [rcx], dl
   cmp cl, 10
   jge lonHon10chuoi2
   add byte [rcx], 48
   mov rdx, 0
   inc rcx
   dec r8
   dec r10
   jmp hetChuoi2
lonHon10chuoi2:
   sub byte [rcx], 10
   add byte [rcx], 48
   mov rdx, 1
   inc rcx
   dec r8
   dec r9
   dec r10
   dec r11
   jmp hetChuoi2
done4:
   add byte [rcx], dl
   add byte [rcx], 48
   inc rcx 
   mov byte [rcx], 0x20
   ret
   ;
   ; Hàm sẽ duyệt từ đầu đến khi gặp ký tự khoảng trắng là 0x20 thì dừng lại
   ; Lùi lại 1 ký tự
   ; Kiểm tra xem có bằng 0 hay không nếu có thì bỏ qua ký tự này
   ; Nếu không thì in lần lượt từ đó về đầu
   ;
   ;
inKetQua:
   cmp byte [r8], 0x20 ; Kiểm tra ký tự với 0x20
   je xoaKhoangCach ; Nếu bằng thì chuyển sang hàm in kết quả
   inc r8 ; Chuyển sang ký tự tiếp theo của output
   inc r12 ; Tăng biến đếm lên để để số phần từ trong chuỗi
   jmp inKetQua ; thực hiện lại inKetQua
xoaKhoangCach:
   dec r8
   dec r12
   cmp byte [r8], 0x30
   je xoa0
   jmp inKQ
xoa0:
   dec r8
   dec r12
   jmp inKQ
inKQ:
   mov rdi, 1
   lea rsi, [r8]
   mov rdx, 1
   mov rax, 1
   syscall
   dec r8
   dec r12
   cmp r12, 0
   je done5
   jmp inKQ
done5:
   ret
   