format ELF64 executable

macro exit code {
  mov rax, 0x3c
  mov rdi, code
  syscall
}

macro write fd, buf, count {
  mov rax,1
  mov rdi,fd
  mov rsi,buf
  mov rdx,count
  syscall
}

macro getcwd buff, buff_size {
  mov rax,0x4f
  mov rdi,buff
  mov rsi,buff_size
  syscall
}

segment readable executable
entry main
main:
  getcwd directory, 4096
  write 1,directory,4096
  write 1,newline,1
  exit 0

segment readable writeable
newline db 10
directory db 0
