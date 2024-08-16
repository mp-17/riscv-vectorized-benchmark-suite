#makefile
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

start:
	mkdir bin ; \
	rm bin/*.*;

serial:
	for entry in src/*.cpp ; do \
		${GCC} -Wall -static -march=rv64gcv -O2 -c -o  $$entry.o  $$entry ; \
	done
	${GCC} -Wall -static -march=rv64gcv -O2 -o $(target_ser) src/*.cpp.o -lm
	${OBJDUMP} -D $(target_ser) > $(target_ser).dump
	rm src/*.o

vector:
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/annealer_thread.o src/annealer_thread.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/main.o src/main.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/netlist.o src/netlist.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/netlist_elem.o src/netlist_elem.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2 -c -o src/rng.o src/rng.cpp
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gcv -O2    -o $(target_vec) src/*.o -lm
	${OBJDUMP} -D $(target_vec) > $(target_vec).dump
	rm src/*.o

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_ser) 1 100 300 input/100.nets 8

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) $(target_vec) 1 100 300 input/100.nets 8


clean:
	rm bin/*
