#makefile
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

serial:
	${GXX} -static -march=rv64gcv -O2 -o $(target_ser) src/streamcluster.cpp -lm
	${OBJDUMP} -D $(target_ser) > ./bin/dump_serial

vector:
	${GXX} -static -DUSE_RISCV_VECTOR   -march=rv64gcv -O2 -o $(target_vec)  src/streamcluster.cpp -lm
	${OBJDUMP} -D $(target_vec) > ./bin/dump_vector # maybe need to remove +experimental-v

runspike-ser:
	echo >output.txt; \
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) 3 10 128 128 128 10 none 1

runspike-vec:
	echo >output.txt; \
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) 3 10 128 128 128 10 none 1

qemu-input:
	echo "#!/usr/bin/env bash" > $(script)
