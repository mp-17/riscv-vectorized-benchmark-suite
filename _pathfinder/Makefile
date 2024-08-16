#makefile
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

serial:
	${GCC} -static -march=rv64gcv -O2 -o $(target_ser) src/pathfinder.cpp

vector:
	${GCC} -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -o $(target_vec)  src/pathfinder.cpp


runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) 32 32 out

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) 32 32 out
