#makefile
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

serial:
	${GXX} -static -march=rv64gcv -O2 -o $(target_ser) src/blackscholes.cpp -lm
	${OBJDUMP} -D $(target_ser) > $(target_ser).dump

vector:
	${GXX} -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -o $(target_vec)  src/blackscholes.cpp -lm
	${OBJDUMP} -D $(target_vec) > $(target_vec).dump

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) 1 ./input/in_64K.input prices.txt &> out-ser.txt

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) 1 ./input/in_64K.input prices.txt &> out-vec.txt

qemu-input:
	cp input/in_64K.input $(rootfs)/usr/bin
	echo "#!/usr/bin/env bash" > $(script)
	echo "debugfs -w busybox.img <<EOF" >> $(script)
	echo "cd /usr/bin" >> $(script)
	echo "write $(shell pwd)/input/in_64K.input in_64K.input" >> $(script)
	echo "quit" >> $(script)
	echo "EOF" >> $(script)
