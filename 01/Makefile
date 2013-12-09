DTRACE=dtrace
CC=clang -g
DFILE=dtrace_demo.d

all:
	$(DTRACE) -h -s ${DFILE}
	$(CC) -c main.c -DENABLE_DTRACE
	$(DTRACE) -G -s ${DFILE} main.o
	$(CC) -lelf main.o dtrace_demo.o -o demo

clean:
	rm dtrace_demo.h
	rm dtrace_demo.o
	rm main.o
	rm demo
	rm *.core
	
