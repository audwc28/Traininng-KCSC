section .data
   str1 db 'Nhap xau S: ', 10, 0
   len1 equ $ - str1
   str2 db 'Nhap xau con: ', 10, 0
   len2 equ $ - str2
   kc db ' ', 0xa, 0
   soluong db 0, 0
   vitri db 0, 0, 0, 0, 0 ,0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, 0, 0, 0, 0, 0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0,0, 0, 0, 0, 0 ,0, 0, 0, 0, 0
section .bss
   xau resb 100
   con resb 10
section .text
   global _start
_start:
   ; printf("Nhap xau S: ");
   mov rdi, 1
   mov rsi, str1
   mov rdx, len1
   mov rax, 1
   syscall
   ;scanf("%100s", &xau);
   mov rdi, 0
   mov rsi, xau
   mov rdx, 100
   mov rax, 0
   syscall
   ; printf("Nhap xau con: ");
   mov rdi, 1
   mov rsi, str2
   mov rdx, len2
   mov rax, 1
   syscall
   ;scanf("%10s", &con);
   mov rdi, 0
   mov rsi, con
   mov rdx, 10
   mov rax, 0
   syscall
   ;
   ; r8 = con
   ; r9 = r8
   ; while(true){
   ;    if (strcmp(r9[i]), 0x0A == 0){
   ;       finished();   
   ;    }else {
   ;        i++; 
   ;    }   
   ; }
   ; Hàm tính độ dài chuỗi con và lưu vào r9
   doDaiChuoi:
   mov r8, con
   mov r9, r8
next_char:
   cmp byte [r9], 0x0A
   jz finished
   inc r9
   jmp next_char
finished:
   sub r9, r8
   ;
   ; rdi = xau
   ; rdx = con
   ; rcx = 0 ; Biến đếm từ đầu đến cuối chuỗi xâu
   ; rsi = vitri
   ; timXauCon()
   ;
   mov rdi, xau
   mov rdx, con
   mov rcx, 0
   mov rsi, vitri
   call timXauCon
   ;
   ; rdx = vitri
   ; rcx = 0 ; đếm số lượng khoảng trắng vì số phần từ bằng số khoảng trắng
   ; loop1()
   ;
   mov rdx, vitri
   mov rcx, 0
   call loop1
   ;
   ; rax = rcx ; Truyền số lượng phần tử vào rax để thêm vào mảng
   ; rbx = 10
   ; rdx = 0
   ; rcx = soluong
   ; themSoLuongVaoMang()
   ;
   mov rax, rcx
   mov rbx, 10
   xor rdx, rdx
   mov rcx, soluong
   call themSoLuongVaoMang
   ;
   ; for(int i = 0; i < strlen(soluong); i++){
   ;    printf("%c", soluong[i]);  
   ; }
   ; In số lượng xâu con có trong chuỗi
   mov rdi, 1
   lea rsi, [soluong]
   mov rdx, 2
   mov rax, 1
   syscall
   ; printf(" ");
   ; Chỉ để xuống dòng
   mov rdi, 1
   mov rsi, kc
   mov rdx, 2
   mov rax, 1
   syscall
   ;
   ; for(int i = 0; i < strlen(vitri); i++)
   ; {
   ;    printf("%c", vitri[i]);  
   ; }
   ; In vị trí xâu con có trong chuỗi
   mov rdi, 1
   lea rsi, [vitri]
   mov rdx, 100
   mov rax, 1
   syscall
   ; exit()
   mov rax, 60
   xor rdi, rdi
   syscall
   ;
   ; void timXauCon(){
   ;     while(true){
   ;         if (strcmp(chuoi[rdi], 0xa) == 0) {
   ;
   ;         }else {
   ;              al = chuoi[rdi] - '0';
   ;              bl = xau[rdx] - '0';
   ;              if (strcmp(al, bl) == 0){
   ;                  rdx++; rdi++; rcx++;
   ;                  if (strcmp(con[rdx], 0) == 0) {
   ;                       rcx -= r9;
   ;                       
   ;                  }
   ;              }
   ;         }
   ;     }    
   ; } 
   ;
timXauCon:
   cmp byte [rdi], 0x0A ; ket thuc chuoi
   je done
   mov al, byte [rdi] ; Gán ký tự cho al
   mov bl, byte [rdx] ; Gán ký tự cho bl
   cmp al, bl ; So sánh al với bl
   jnz kyTuTiep ; Nếu khác thì chuyển đến kyTuTiep
   inc rdx ; Chuyen ky tu tiep theo cua xau con
   inc rdi ; Chuyển ký tự tiếp theo của chuỗi
   inc rcx ; Tăng 1 đơn vị vì đã qua 1 ký tự
   cmp byte [rdx], 0x0A ; So sánh ký tự hiện tại của chuỗi con với 0xa
   je flag ; Nếu đúng thì chuyển đến flag
   jmp timXauCon ; Thực hiện tiếp timXauCon
flag:
   sub rcx, r9 ; rcx -= r9 ; trừ cho r9 tức là trừ số phần tử xâu con để tìm vị trí xâu con xuất hiện
   mov rax, rcx ; rax = rcx
   mov rbx, 10 ; rbx = 10
   xor rdx, rdx ; rdx = 0
   add rcx, r9 ; rcx += r9
themVaoMang:
   div rbx ; chia cho rbx phân nguuyeen ở rax, phân dư ở rbx
   add dl, 48 ; dl + '0' -> chuyển sang ký tự
   cmp rax, 0 ; so sánh rax với 0
   jnz them1 ; Nếu khác thì thực hiện them1
   mov byte [rsi], dl ; Gán ký tự vừa chuuyeenr cho mảng vitri
   inc rsi ; Tăng lên 1 đơn vị để lưu ký tự tiếp theo
   mov byte [rsi], 0x20 ; Lưu ký tự khoảng trắng vào
   inc rsi 
   mov rdx, con ; Gán lại chuỗi con cho rdx để tiếp tục tìm kiếm
   jmp timXauCon ; Thực hiện timXauCon
   ;Ý tưởng phần này là do rax có 2 chữ số nên sẽ tăng lên 1 đơn vị rồi lưu phần dư vào đố
   ; Sau đó lùi lại 1 đơn vị để lưu phần dư tiếp theo
them1:
   inc rsi ; 
   mov byte [rsi], dl
   dec rsi
   xor rdx, rdx
   div rbx
   add dl, 48
   mov byte [rsi], dl
   inc rsi
   inc rsi
   mov byte [rsi], 0x20
   inc rsi
   mov rdx, con
   jmp timXauCon
kyTuTiep:
   inc rdi ; Chuyển đến ký tự tiếp theo của xâu
   inc rcx ; Tăng biến đếm lên 1 đơn vị
   mov rdx, con ; Gán lại chuỗi con cho rdx để tiếp tục tìm kiếm
   jmp timXauCon
done:
   mov byte [rsi], 0 ; Gán giá trị 0 cho phần tử cuối cùng của mảng vị trí
   ret ; Kết thúc hàm 
   ;
   ; Hàm này dựa vào mảng vị trí đã có trước đó
   ; Đếm xem có bao nhiêu giá trị là khoảng trắng
   ; thì đó chính là số lượng chuỗi con có trong xâu
   ;
loop1:
   cmp byte [rdx], 0x20 ; Kiểm tra ký tự mảng vị trí với 0x20
   je loop2 ; Nếu đúng thì chuyển qua loop2
   cmp byte [rdx], 0 ; Kiểm tra ký tự mảng vị trí với 0
   je done1 ; Nếu đúng thì chuyển qua done1
   inc rdx ; Chuyển sang ký tự tiếp theo
   jmp loop1
loop2: 
   inc rcx ; Tăng biến đếm lên 1
   inc rdx ; Chuyển sang ký tự tiếp theo
   jmp loop1  
done1:
   ret
   ;
   ; Sau khi xác định được số lượng chuỗi con có trong xâu
   ; chuyển sang str để in ra
   ; Vẫn áp dụng kiểu đã dùng ở lưu mảng vị trí
   ;
themSoLuongVaoMang:
   div rbx
   add dl, 48
   cmp rax, 0
   jnz themSoLuongVaoMang1
   mov byte [rcx], dl
   ret
themSoLuongVaoMang1:
   inc rcx
   mov byte [rcx], dl
   dec rcx
   xor rdx, rdx
   div rbx
   add dl, 48
   mov byte [rcx], dl
   ret