include "syscalls.inc"

AF_INET = 2
SOCK_STREAM = 1

struc sockaddr_in sa_family, in_port, in_addr {
  .sa_family dw sa_family
  .in_port   dw in_port
  .in_addr   dd in_addr
  .zeros     dq 0
  .len       dw 16
}

macro socket domain, type, protocol {
  syscall_ SYS_socket, domain, type, protocol, 0, 0, 0
}

macro bind sockfd, sockaddr, sockaddr_len {
  syscall_ SYS_bind, sockfd, sockaddr, sockaddr_len, 0, 0, 0
}

macro listen sockfd, backlog {
  syscall_ SYS_listen, sockfd, backlog, 0, 0, 0, 0
}

macro accept sockfd, addr, addr_len {
  syscall_ SYS_accept, sockfd, addr, addr_len, 0, 0, 0
}

macro close sockfd {
    syscall_ SYS_close, sockfd, 0, 0, 0, 0, 0
}
