#makefile

GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GXX_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

start:
	mkdir bin; \
	rm bin/*.*

serial:
	for entry in src/*.cpp ; do \
		${GXX} -Wall -static -march=rv64gcv -O2 -c -o  $$entry.o  $$entry ; \
	done
	${GXX} -Wall -static -march=rv64gcv -O2  -o $(target_ser)  src/*.cpp.o -lm;	\
	rm src/*.o; \
	${OBJDUMP} -D $(target_ser) > ./bin/dump_serial


vector:
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/CumNormalInv.o src/CumNormalInv.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/MaxFunction.o src/MaxFunction.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/RanUnif.o src/RanUnif.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/nr_routines.o src/nr_routines.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/icdf.o src/icdf.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM_SimPath_Forward_Blocking.o src/HJM_SimPath_Forward_Blocking.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM.o src/HJM.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM_Swaption_Blocking.o src/HJM_Swaption_Blocking.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/HJM_Securities.o src/HJM_Securities.cpp
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2   -o $(target_vec) src/*.o -lm
	rm src/*.o
	${OBJDUMP} -D $(target_vec) > ./bin/dump_vector

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) -ns 8 -sm 512 -nt 1

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) -ns 8 -sm 512 -nt 1


clean:
	rm bin/*

qemu-input:
	echo "#!/usr/bin/env bash" > $(script)
