#makefile
# MOIMFELD: maybe need to add
GCC   ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-g++
GCC_DUMP ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-objdump
SPIKE   := /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/rvv_progs/rivec/tools/install-spike/bin/spike
PK      := /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/rvv_progs/rivec/tools/install-pk/riscv64-unknown-elf/bin/pk


start:
	mkdir -p bin; \
	rm bin/*.*
	
serial:
	${GCC} -Wall -static -O2 -c -o src/jacobi-2d.o src/jacobi-2d.cpp; \
	${GCC} -Wall -static -march=rv64g -O2 -o bin/jacobi-2d_serial.exe src/*.o -lm; \
	rm src/*.o; \
	${GCC_DUMP} -D bin/jacobi-2d_serial.exe > bin/jacobi-2d_serial.dump

vector:
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gv -O2 -c -o src/jacobi-2d.o src/jacobi-2d.cpp; \
	${GCC} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gv -O2 -o bin/jacobi-2d_vector.exe src/*.o -lm ; \
	rm src/*.o ; \
	${GCC_DUMP} -D bin/jacobi-2d_vector.exe > bin/jacobi-2d_vector.dump ; \

host:
	g++ -O2 -g -Wall -std=c99 -c -o  src/jacobi-2d.o  src/jacobi-2d.cpp ; \
	g++ -O2 -g -Wall -std=c99 -o  bin/jacobi-2d_host.exe  src/*.o  -lm; \
	rm src/*.o; \
	objdump -dC bin/jacobi-2d_host.exe > bin/jacobi-2d_host.dump ;

runspike-vec:
	$(SPIKE) --isa=rv64gcv $(PK) bin/jacobi-2d_serial.exe 2 128 1 out-ser.txt

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) bin/jacobi-2d_vector.exe 2 128 1 out-vec.txt

copy:
	rm -r ../../Test/_jacobi-2d/bin/*.exe; \
	cp -r bin/*exe ../../Test/_jacobi-2d/bin/;

clean:
	rm bin/*.dump; \
	rm bin/*.exe;