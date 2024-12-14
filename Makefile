KERNEL=target/x86_64-unknown-none/release/krnl
ISO=krnl.iso
ISO_BIN=iso/boot/krnl
.PHONY: all run clean

all: $(ISO)

$(KERNEL):
	cargo build --release --target x86_64-unknown-none

iso/boot/kernel: $(KERNEL)
	mkdir -p iso/boot/grub
	cp $< $@

iso/boot/grub/grub.cfg:
	echo -e 'set gfxpayload=keep\nmenuentry "KRNL" { multiboot /boot/kernel }' > $@

$(ISO): iso/boot/kernel iso/boot/grub/grub.cfg
	grub-mkrescue -o $@ iso

run: $(ISO)
	qemu-system-x86_64 -cdrom $<

clean:
	cargo clean
	rm -rf iso $(ISO)
