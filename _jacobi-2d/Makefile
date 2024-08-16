#makefile
# MOIMFELD: maybe need to add

include ../common.mk

start:
	mkdir -p bin; \
	rm bin/*.*

serial:
	${GXX} -Wall -static -O2 -c -o src/jacobi-2d.o src/jacobi-2d.cpp; \
	${GXX} -Wall -static -march=rv64g -O2 -o bin/jacobi-2d_serial.exe src/*.o -lm; \
	rm src/*.o; \
	${OBJDUMP} -D bin/jacobi-2d_serial.exe > bin/jacobi-2d_serial.dump

vector:
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gv -O2 -c -o src/jacobi-2d.o src/jacobi-2d.cpp; \
	${GXX} -Wall -static -DUSE_RISCV_VECTOR -march=rv64gv -O2 -o bin/jacobi-2d_vector.exe src/*.o -lm ; \
	rm src/*.o ; \
	${OBJDUMP} -D bin/jacobi-2d_vector.exe > bin/jacobi-2d_vector.dump ; \

host:
	g++ -O2 -g -Wall -c -o  src/jacobi-2d.o  src/jacobi-2d.cpp ; \
	g++ -O2 -g -Wall -o  bin/jacobi-2d_host.exe  src/*.o  -lm; \
	rm src/*.o; \
	objdump -dC bin/jacobi-2d_host.exe > bin/jacobi-2d_host.dump ;

runspike-ser:
	$(SPIKE) --isa=rv64gcv $(PK) bin/jacobi-2d_serial.exe 128 1 out-ser.txt

runspike-vec:
	$(SPIKE) -d --isa=rv64gcv $(PK) bin/jacobi-2d_vector.exe 128 1 out-vec.txt

copy:
	rm -r ../../Test/_jacobi-2d/bin/*.exe; \
	cp -r bin/*exe ../../Test/_jacobi-2d/bin/;

clean:
	rm bin/*.dump; \
	rm bin/*.exe;
