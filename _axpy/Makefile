#makefile
# GCC_TOOLCHAIN_DIR := /newlib/
# SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

# LLVM := /llvm/build/
GCC     ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-gcc
OBJDUMP ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-objdump
SPIKE   := /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/rvv_progs/rivec/tools/install-spike/bin/spike
PK      := /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/rvv_progs/rivec/tools/install-pk/riscv64-unknown-elf/bin/pk

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
