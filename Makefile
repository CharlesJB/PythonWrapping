GXX=g++
NGS_PATH=/home/cjbparlant/git-clones/class
NGS_INGLUDE=-Wl,--whole-archive $(NGS_PATH)/libs/libNGS.a -Wl,--no-whole-archive
CFLAGS=-O3 -Wall -std=c++11 -c -fPIC
LFLAGS=-shared -Wl,-soname,libfoo.so -lz
INCLUDE=-I$(NGS_PATH) -I$(NGS_PATH)/NGS

.PHONY: all
all: libfoo.so

.PHONY: clean
clean:
	rm -f foo.o libfoo.so

.PHONY: exec
exec: libfoo.so
	./fooWrapper.py

libfoo.so: foo.o
	$(GXX) $(LFLAGS) -o libfoo.so foo.o $(NGS_INGLUDE)

foo.o: foo.cpp
	$(GXX) $(CFLAGS) $(INCLUDE) foo.cpp -o foo.o
