section .data
  start_msg db "Server listening on port 5000...", 10, 0
  start_msg_len equ $-start_msg-1

  response db "HTTP/1.1 200 OK", 13, 10, 13, 10, "<h1>RESPONSE</h1>", 13, 10
  response_len equ $-response

  addr:
    dw 2
    dw 0x8813
    dd 0x0100007F
    dq 0

section .bss
  client_fd resq 1

section .text
global _start

_start:
  ; create socket
  mov rax, 41         ; socket syscall
  mov rdi, 2          ; AF_INET
  mov rsi, 1          ; SOCKET_STREAM (TCP)
  xor rdx, rdx        ; default protocol
  syscall
  mov r12, rax        ; server fd

  ; bind socket
  mov rax, 49         ; bind syscall
  mov rdi, r12        ; server fd
  lea rsi, [rel addr] ; sockaddr
  mov rdx, 16         ; sockaddr_len
  syscall

  ; listen for connections
  mov rax, 50         ; listen syscall
  mov rdi, r12        ; server fd
  mov rsi, 5          ; pending connections queue size
  syscall

  ; write start message to stdout
  mov rax, 1  ; write syscall
  mov rdi, 1  ; stdout
  lea rsi, [rel start_msg]
  mov rdx, start_msg_len
  syscall
  
  accept_loop:
    ; accept connections
    mov rax, 43  ; accept syscall
    mov rdi, r12 ; server fd
    xor rsi, rsi ; addr (NULL)
    xor rdx, rdx ; addr_len (NULL)
    syscall

    ; saves client fd
    mov [rel client_fd], rax

    ; write response
    mov rax, 1  ; write syscall
    mov rdi, [rel client_fd]
    lea rsi, [rel response]
    mov rdx, response_len
    syscall

    ; close connection
    mov rax, 3 ; close syscall
    mov rdi, [rel client_fd]
    syscall

    jmp accept_loop
