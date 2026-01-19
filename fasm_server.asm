format ELF64 executable

include "syscalls.inc"
include "net.inc"

struc slice data& {
  . db data
  .ptr = .
  .len = $ - .
}

macro write fd, buf, size {
  syscall_ SYS_write, fd, buf, size, 0, 0, 0
}

macro exit _code {
  syscall_ SYS_exit, _code, 0, 0, 0, 0, 0
}

EXIT_SUCCESS equ 0
EXIT_ERROR equ 1

segment readable executable
entry main
main:
write STDOUT, start, start.len

write STDOUT, socket_creation_msg, socket_creation_msg.len
socket AF_INET, SOCK_STREAM, 0

; int3

cmp rax, 0
jl main.error

mov qword [sockfd], rax

write STDOUT, socket_binding_msg, socket_binding_msg.len
bind [sockfd], addr.sa_family, addr.len

write STDOUT, socket_listen_msg, socket_listen_msg.len
listen [sockfd], 5

.loop:
  accept [sockfd], 0, 0
  cmp rax, 0
  jl main.error

  mov [clientfd], rax

  write [clientfd], reply_msg, reply_msg.len

  close [clientfd]

  jmp main.loop


close [sockfd]
exit EXIT_SUCCESS

.error:
  write STDERR, error_msg, error_msg.len
  close [sockfd]
  exit EXIT_ERROR

segment readable writeable
sockfd   dq 0
clientfd dq 0
addr sockaddr_in AF_INET, 0x1388, 0x0100007F

start slice 10, "Starting web server...", 10
socket_creation_msg slice "Creating socket...", 10
socket_binding_msg slice "Biding socket...", 10
socket_listen_msg slice "Server listening...", 10
reply_msg slice "HTTP/1.1 200 OK", 13, 10, 13, 10, "<h1>RESPONSE</h1>", 13, 10
error_msg slice "ERROR", 10
