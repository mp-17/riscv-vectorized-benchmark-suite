# Common tools
GCC     ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-gcc
GXX     ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-g++
OBJDUMP ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-objdump
SPIKE   := /usr/scratch/tokyo/mperotti/processor/temp/rivec/deps/install/riscv-isa-sim/bin/spike
PK      := /usr/scratch/tokyo/mperotti/processor/temp/rivec/deps/install/riscv-pk/riscv64-unknown-elf/bin/pk

# QEMU
rivec  := ..
app    := $(shell basename $(shell pwd))
rootfs := $(rivec)/qemu/rootfs
script := $(rivec)/qemu/$(app).sh

qemu-bin: qemu-input
	$(MAKE) serial vector
	cp bin/rvv-test-serial $(rootfs)/usr/bin
	cp bin/rvv-test-vector $(rootfs)/usr/bin
	echo "debugfs -w busybox.img <<EOF" >> $(script)
	echo "cd /usr/bin" >> $(script)
	echo "write $(shell pwd)/bin/rvv-test-serial $(app)-s" >> $(script)
	echo "write $(shell pwd)/bin/rvv-test-vector $(app)-v" >> $(script)
	echo "quit" >> $(script)
	echo "EOF" >> $(script)
	chmod +x $(script)
