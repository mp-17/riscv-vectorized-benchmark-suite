#makefile
# GCC_TOOLCHAIN_DIR := /newlib/
# SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

# LLVM := /llvm/build/
target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

serial:
	${GCC} -Wall -static -march=rv64gcv -O2 -c -o src/axpy.o src/axpy.c
	${GCC} -Wall -static -march=rv64gcv -O2 -c -o src/main.o src/main.c
	${GCC} -Wall -static -march=rv64gcv -O2 -c -o src/utils.o src/utils.c
	${GCC} -Wall -static -march=rv64gcv -O2 -o $(target_ser) src/*.o -lm
	${OBJDUMP} -D $(target_ser) > $(target_ser).dump

vector:
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/utils.o src/utils.c
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/axpy.o src/axpy.c
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/main.o src/main.c
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -o $(target_vec) src/*.o -lm
	${OBJDUMP} -D $(target_vec) > $(target_vec).dump

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) 256

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) 256
