#makefile
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

start:
	mkdir bin; \
	rm bin/*.*

serial:
	${GXX} -Wall -static -march=rv64gcv -O2 -c -o src/particlefilter_serial.o src/particlefilter.c
	${GXX} -Wall -static -march=rv64gcv -O2 -o $(target_ser) src/particlefilter_serial.o -lm
	${OBJDUMP} -D $(target_ser) > $(target_ser).dump
	rm src/*.o

vector:
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -DMVL_$$mvl -march=rv64gcv -O2 -c -o src/particlefilter.o src/particlefilter.c ; \
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -DMVL_$$mvl -march=rv64gcv -O2 -o $(target_vec) src/*.o -lm ; \
	${OBJDUMP} -D $(target_vec) > $(target_vec).dump
	rm src/*.o

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) -x 128 -y 128 -z 2 -np 256

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) -x 128 -y 128 -z 2 -np 256


clean:
	rm bin/*

qemu-input:
	echo "#!/usr/bin/env bash" > $(script)
