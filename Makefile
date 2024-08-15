BASE_DIR := $(shell pwd)

APPLICATION_DIRS := _blackscholes _swaptions _streamcluster _canneal _particlefilter _pathfinder _jacobi-2d _matmul _axpy

all: blackscholes swaptions streamcluster canneal pathfinder jacobi-2d axpy # particlefilter matmul

blackscholes:
	cd _blackscholes; 	\
	make vector; 		\
	make serial;


swaptions:
	cd _swaptions; 		\
	make vector; 		\
	make serial;

streamcluster:
	cd _streamcluster; 	\
	make vector; 		\
	make serial;

canneal:
	cd _canneal; 		\
	make vector; 		\
	make serial;

particlefilter: # MOIMFELD: currently not compiling
	cd _particlefilter;	\
	make vector; 		\
	make serial;

pathfinder:
	cd _pathfinder;		\
	make vector; 		\
	make serial;

jacobi-2d:
	cd _jacobi-2d;		\
	make vector; 		\
	make serial;

matmul: # kernel does not exist :o
	cd _matmul; 		\
	make vector; 		\
	make serial;

axpy:
	cd _axpy; 			\
	make vector; 		\
	make serial;

clean:
	for dir in $(APPLICATION_DIRS) ; do cd $$dir ; make clean ; cd .. ; done
