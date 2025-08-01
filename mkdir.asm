format ELF64 executable

STDERR equ 2

macro exit code {
  mov rax, 0x3c
  mov rdi, code
  syscall
}

macro mkdir filename,mode {
  mov rax,0x53
  mov rdi,filename
  mov rsi,mode
  syscall
}

macro write fd, buf, count {
  mov rax,1
  mov rdi,fd
  mov rsi,buf
  mov rdx,count
  syscall
}

segment readable executable
entry main
main:
  cmp word [rsp],0x2
  jl error_args
  mov r10,[rsp+16]
  mov r11,[rsp+32]
  sub r11,r10
  mkdir r10,0777
  exit 0

error_args:
  write STDERR, args_error_msg, args_error_msg_len
  exit 1

segment readable writeable
args_error_msg db "Usage: ./mkdir <folder name>", 10
args_error_msg_len = $ - args_error_msg
