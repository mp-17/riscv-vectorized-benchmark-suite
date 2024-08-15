#makefile
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

# LLVM := /llvm/build/
GCC   ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-g++
OBJDUMP ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-objdump
SPIKE   := /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/rvv_progs/rivec/tools/install-spike/bin/spike
PK      := /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/rvv_progs/rivec/tools/install-pk/riscv64-unknown-elf/bin/pk


target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

serial:
	${GCC} -static -march=rv64gcv -O2 -o $(target_ser) src/streamcluster.cpp -lm
	${OBJDUMP} -D $(target_ser) > ./bin/dump_serial

vector:
	${GCC} -static -DUSE_RISCV_VECTOR   -march=rv64gcv -O2 -o $(target_vec)  src/streamcluster.cpp -lm
	${OBJDUMP} -D $(target_vec) > ./bin/dump_vector # maybe need to remove +experimental-v

runspike-ser:
	echo >output.txt; \
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) 3 10 128 128 128 10 none output.txt 1

runspike-vec:
	echo >output.txt; \
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) 3 10 128 128 128 10 none output.txt 1
