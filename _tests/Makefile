#makefile

GCC   ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-g++
GCC_DUMP   ?= /usr/scratch2/pisoc12/msc24f10/workspace/upstream_linux_bringup/cva6-sdk-vinc-replicate/buildroot/output/host/bin/riscv64-linux-objdump

start:
	mkdir bin; \
	rm bin/*.*

serial:
	${GCC} -Wall -march=rv64g -O2 -c -o src/tests.o src/tests.cpp
	${GCC} -Wall -march=rv64g -O2 -o bin/tests_serial.exe src/tests_serial.o -lm
	rm src/*.o
	${GCC_DUMP} -ds  bin/tests_serial.exe > bin/tests_serial.dump
vector:
	${GCC} -Wall -DUSE_RISCV_VECTOR -march=rv64gv -O2 -c -o src/tests.o src/tests.cpp ; \
	${GCC} -Wall -DUSE_RISCV_VECTOR -march=rv64gv -O2 -o bin/tests_vector.exe src/*.o -lm ; \
	rm src/*.o ; \
	${GCC_DUMP} -ds   bin/tests_vector.exe > bin/tests_vector.dump ;

host:
	gcc -O2 -fopenmp src/tests.cpp -o bin/tests_host.exe -lm ;

copy:
	rm -r ../../Test/_tests/bin/*.exe; \
	cp -r bin/*exe ../../Test/_tests/bin;

clean:
	rm bin/*.dump; \
	rm bin/*.exe;
