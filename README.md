cargo run create bootimage + run qemu to try it

```bash
cargo bootimage
dd if=target/x86/debug/bootimage-krnl.bin of=/dev/sdX && sync
```
UEFI not supported yet