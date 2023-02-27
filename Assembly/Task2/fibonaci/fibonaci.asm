section .data
   str1 db 'n = ',10 ,0
   len1 equ $ - str1
   t1 db '0', 10, 0
   len2 equ $ - t1
   t2 db '0 1'
   len3 equ $ - t2
section .bss
   num resb 100
   output resb 10
section .text
   global _start
_start:
   ; printf("n = ");
   mov rdi, 1
   mov rsi, str1
   mov rdx, len1
   mov rax, 1
   syscall
   ; scanf("%3s", &n);
   mov rdi, 0
   mov rsi, num
   mov rdx, 3
   mov rax, 0
   syscall
   ; Sau khi nhập n thì đổi sang số nguyên rồi kiểm tra với 100
   xor rcx, rcx ; rcx = 0
   mov rcx, num ; Gán num cho rcx
   mov rax, 0 ; Gán 0 cho rax để tính giá trị nguyên của num
doiSangInt:
   cmp byte [rcx], 0xa ; Kiểm tra ký tự của num với ký tự xuống dòng
   je done1
   cmp byte [rcx], 0 ; Kiểm tra ký tự của num với ký tự null
   je done1
   sub byte [rcx], 48 ; Giảm 48 để lấy giá trị nguyên của số đó
   imul rax, 10 ; nhân 10 với rax
   add al, [rcx] ; cộng giá trị nguyên vừa giảm vào rax
   inc rcx ; Chuyển sang ký tự tiếp theo
   jmp doiSangInt ; Thực hiện tiếp
done1:
   cmp rax, 100 ; Kiểm tra rax với 100
   jg exit ; Nếu lớn hơn thì exit
   mov [num], rax ; Giá rax cho giá trị num
   ;
   mov r9, [num] ; Gán giá trị num cho r9
   call fibonaci ; Gọi hàm fibonaci
   ;

exit:
   mov rax, 60
   xor rdi, rdi
   syscall
   ;
   ; hàm sẽ kiểm tra nếu nhập 1 thì in 0, nhập 2 thì in 0 1
   ; Ngược lại thì lấy giá trị nhập vào trừ cho 2
   ; rồi thực hiện hàm cộng với giá trị ban đầu là 0 và 1
   ; được kết quả chuyển sang chuỗi rồi in ra
   ;
fibonaci:
   cmp r9, 1 ; Kiểm tra r9 với 1
   je In1 ; Nếu đùng thực hiện in1
   cmp r9, 2 ; Kiểm tra r9 với 2
   je In2 ; Nếu đúng thực hiện in2
   ; printf ("0 1"); In 0 vs 1 trước rồi in các số khác tiếp
   mov rdi, 1
   mov rsi, t2
   mov rdx, len3
   mov rax, 1
   syscall
   ;
   sub r9, 0x2 ; r9 -= 2;
   mov rax, 0 ; rax = 0
   mov rbx, 1 ; rax = 1
In3:
   cmp r9, 0 ; Kiểm tra r9 với 0
   je done2 ; Chuyển sang done2 nếu bằng
   add rax, rbx ; rax += rbx
   mov r15, rax ; r15 = r15
   mov r10, rbx ; r10 = rbx
   mov r8, output ; r8 = ouput ; để lưu kết quả vào biến output
   call luuKetQua ; Gọi hàm lưu kết quả
   mov r8, output ; Gán biến output hiện tại là chuỗi kết quả vào r8
   mov r12, 1 ; r12 = 1 ; Là biến đế số lượng ký tự trong chuỗi
   call inKetQua ; Gọi hàm inKetQua
   dec r9 ; r9--
   mov rax, r10 ; Gán giá trị rbx lúc trước cho rax
   mov rbx, r15 ; Giá giá trị vừa tính được cho rax
   jmp In3 ; Thực hiện lại In3 với giá trị rax, rbx mới
done2:
   ret
In1:
   ; printf("0 ");
   mov rdi, 1
   mov rsi, t1
   mov rdx, len2
   mov rax, 1
   syscall
   ret
In2:
   ; printf("0 1");
   mov rdi, 1
   mov rsi, t2
   mov rdx, len3
   mov rax, 1
   syscall
   ret
   ;
   ; Hàm lưu kết quả sẽ chia dư cho 10 rồi lần lượt gán giá trị từ đầu đến cuối
   ; Ví dụ 31 chia cho 10 thì output = "13 "
   ; Giá trị khoảng trắng cuối cùng để in ngược lên
   ;
luuKetQua:
   mov rbx, 10 ; rbx = 10
   xor rdx, rdx ; rdx = 0
   div rbx ; Lấy giá trị rax chia cho rbx = 10
   add dl, 48 ; Phẩn dư lưu vào rdx lên cộng thêm 48 để chuyển sang ký tự
   mov byte [r8], dl ; Lưu ký tự vừa chuyển vào r8 hay là biến output
   inc r8 ; Chuyển sang vị trí tiếp theo để lưu
   cmp rax, 0 ; Kiểm tra rax vs 0
   je done3 ; Nếu bằng thì chuyển sang done3
   jmp luuKetQua ; Thực hiện lại hàm luuKetQua với giá trị rax mới
done3:
   mov byte [r8], 0x20 ; Gán giá trị cuối cùng của output cho 0x20 hay khoảng trắng
   ret
   ;
   ; Hàm in kết quả sẽ duyệt từ đầu đến khi nào gặp ký tự 0x20
   ; Rối bắt đầu in ngược trở lại từ vị trí 0x20
   ;
inKetQua:
   cmp byte [r8], 0x20 ; Kiểm tra ký tự với 0x20
   je inKq ; Nếu bằng thì chuyển sang hàm in kết quả
   inc r8 ; Chuyển sang ký tự tiếp theo của output
   inc r12 ; Tăng biến đếm lên để để số phần từ trong chuỗi
   jmp inKetQua ; thực hiện lại inKetQua
   ;
   ; while (r12 > 0){
   ;     printf("%s", output[r12]);
   ;     r12--;  
   ; }
   ;
inKq:
   mov rdi, 1
   lea rsi, [r8]
   mov rdx, 1
   mov rax, 1
   syscall
   dec r8
   dec r12
   cmp r12, 0
   je done5
   jmp inKq
done5:
   ret