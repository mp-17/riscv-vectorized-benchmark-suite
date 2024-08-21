GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

FLAGS = -Wall -static -march=rv64gcv -O2

LDFLAGS = -lm -static
IFLAGS = -I ./ -I ${VEHAVE_TOOLCHAIN}/include/vehave/ -I ${VEHAVE_TOOLCHAIN}/include/vehave-user/

serial: rvv-test-serial rvv-test-serial.dump
vector: rvv-test-vector rvv-test-vector.dump

rvv-test-serial: main.seq.o somier.o utils.o forces.o
	$(GCC) $(FLAGS) -o bin/$@ $+ $(LDFLAGS)

rvv-test-vector: main.vec.o somier.o utils.o forces_prevec_lmul1.o somier_intr_lmul1.o
	$(GCC) $(FLAGS) -o bin/$@ $+ $(LDFLAGS)

main.seq.o: main.c utils.h
	$(GCC) $(FLAGS) $(IFLAGS) -DSEQ -c -o $@ $<

main.vec.o: main.c utils.h
	$(GCC) $(FLAGS) $(IFLAGS) -c -o $@ $<

somier.o: omp/somier.c utils.h
	$(GCC) $(FLAGS) $(IFLAGS) -c -o $@ $<

somier_intr_lmul1.o: intrinsics/somier_intr_lmul1.c intrinsics/somier_v.h utils.h
	$(GCC) $(FLAGS) -DUSE_RISCV_VECTOR $(IFLAGS) -c -o $@ $<

utils.o: utils.c utils.h
	$(GCC) $(FLAGS) -c -o $@ $<

forces.o: forces.c utils.h
	$(GCC) $(FLAGS) -c -o $@ $<

forces_prevec_lmul1.o: intrinsics/forces_prevec_lmul1.c utils.h
	$(GCC) $(FLAGS) -DUSE_RISCV_VECTOR $(IFLAGS) -c -o $@ $<

rvv-test-serial.dump:
	${OBJDUMP} -D bin/rvv-test-serial > bin/rvv-test-serial.dump

rvv-test-vector.dump:
	${OBJDUMP} -D bin/rvv-test-vector > bin/rvv-test-vector.dump

clean_o:
	rm -f *.o

clean:
	rm -f *.o
	rm -f *.exe

qemu-input:
	echo "#!/usr/bin/env bash" > $(script)
