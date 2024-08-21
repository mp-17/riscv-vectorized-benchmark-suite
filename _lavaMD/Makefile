# Example
# target: dependencies
	# command 1
	# command 2
          # .
          # .
          # .
	# command n
GCC_TOOLCHAIN_DIR := /newlib/
SYSROOT_DIR := $(GCC_TOOLCHAIN_DIR)/riscv64-unknown-elf

include ../common.mk

target_ser = bin/rvv-test-serial
target_vec = bin/rvv-test-vector

ifdef OUTPUT
override OUTPUT = -DOUTPUT
endif

FLAGS = -Wall -static -march=rv64gcv -O2

serial: main_serial.o ./kernel/kernel_cpu.o ./util/num/num.o ./util/timer/timer.o
	$(GXX) $(FLAGS) main.o ./kernel/kernel_cpu.o ./util/num/num.o ./util/timer/timer.o -lm -o bin/rvv-test-serial ; \
	$(OBJDUMP) -D  bin/rvv-test-serial > bin/rvv-test-serial.dump ; \
	rm *.o ; \
	rm kernel/*.o ;

vector: main_vector.o ./kernel/kernel_vector.o ./util/num/num.o ./util/timer/timer.o
	$(GXX) $(FLAGS) -DUSE_RISCV_VECTOR main.o ./kernel/kernel_vector.o ./util/num/num.o ./util/timer/timer.o -lm -o bin/rvv-test-vector ; \
	$(OBJDUMP) -D  bin/rvv-test-vector > bin/rvv-test-vector.dump ; \
	rm *.o ; \
	rm kernel/*.o ;

# compile function files into objects (binaries)
main_serial.o:	main.h \
			main.c \
			./kernel/kernel_cpu.h \
			./kernel/kernel_cpu.c \
			./util/num/num.h \
			./util/num/num.c \
			./util/timer/timer.h \
			./util/timer/timer.c
	$(GXX) $(FLAGS) ${OUTPUT} main.c \
			-c \
			-o main.o \

main_vector.o:
	$(GXX) $(FLAGS) -DUSE_RISCV_VECTOR ${OUTPUT} main.c -c -o main.o

./kernel/kernel_cpu.o:	./kernel/kernel_cpu.h \
						./kernel/kernel_cpu.c
	$(GXX) $(FLAGS)		./kernel/kernel_cpu.c \
						-c \
						-o ./kernel/kernel_cpu.o

./kernel/kernel_vector.o:	./kernel/kernel_vector.h \
						./kernel/kernel_vector.c
	$(GXX) $(FLAGS) -DUSE_RISCV_VECTOR	./kernel/kernel_vector.c \
						-c \
						-o ./kernel/kernel_vector.o

./util/num/num.o:	./util/num/num.h \
					./util/num/num.c
	$(GXX) $(FLAGS) ./util/num/num.c \
					-c \
					-o ./util/num/num.o

./util/timer/timer.o:	./util/timer/timer.h \
						./util/timer/timer.c
	$(GXX) $(FLAGS)		./util/timer/timer.c \
						-c \
						-o ./util/timer/timer.o

# delete all object and executable files
clean:
	rm	*.o \
		./kernel/*.o \
		./util/num/*.o \
		./util/timer/*.o \
		./util/device/*.o; \
	rm bin/*.dump; \
	rm bin/*.exe;

qemu-input:
	echo "#!/usr/bin/env bash" > $(script)
