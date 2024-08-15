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

start:
	mkdir bin; \
	rm bin/*.*

serial:
	for entry in src/*.cpp ; do \
		${GCC} -Wall -static -march=rv64gcv -O2 -c -o  $$entry.o  $$entry ; \
	done
	${GCC} -Wall -static -march=rv64gcv -O2  -o $(target_ser)  src/*.cpp.o -lm;	\
	rm src/*.o; \
	${OBJDUMP} -D $(target_ser) > ./bin/dump_serial


vector:
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/CumNormalInv.o src/CumNormalInv.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/MaxFunction.o src/MaxFunction.cpp	
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/RanUnif.o src/RanUnif.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/nr_routines.o src/nr_routines.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/icdf.o src/icdf.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM_SimPath_Forward_Blocking.o src/HJM_SimPath_Forward_Blocking.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM.o src/HJM.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM_Swaption_Blocking.o src/HJM_Swaption_Blocking.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM_Securities.o src/HJM_Securities.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2   -o $(target_vec) src/*.o -lm
	rm src/*.o
	${GCC_DUMP} -D $(target_vec) > ./bin/dump_vector

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) -ns 8 -sm 512 -nt 1

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) -ns 8 -sm 512 -nt 1


clean:
	rm bin/*
