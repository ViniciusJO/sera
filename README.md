# SERA - fasm/nasm HTTP server

Studying [nasm](https://www.nasm.us/) and [fasm](https://flatassembler.net/) writing a simple http server.

I love to write `fasm`, it's fun and ergonomic (as far as assemblers can go), but its a nightmare to debbug in linux. Its oficial tooling is develop to window and integrate it with gdb is a unsolved computation problem.

`nasm`, in other hand, feels janky, but works flawlessly with the linux ecosystem. It seems more complete and robust, which implies an enormous complexity.

In conclusion I'll sadly not touch `fasm` again untill better tooling in linux and will need to speend some time unweaving the `nasm`'s nest.

## Build

The only dependencies are the [GNU make](https://www.gnu.org/software/make/manual/make.html) build tool, [nasm](https://www.nasm.us/) and [fasm](https://flatassembler.net/) assemblers and the [ld GNU linker](https://sourceware.org/binutils/docs/).

The `make` command without args will build both versions, generating the `fasm_server` and the `nasm_server` executables. To build a individual version use the `make` command and the name of the executable to be build:

```sh
make fasm_server
```

or

```sh
make nasm_server
```

There are also the `make run_fasm` and `make run_nasm` command which builds the desired version and run it.
