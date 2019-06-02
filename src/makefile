all: build run

build:
	gfortran -o signal signal.f90 -Ldirectory -lfftw3
	gfortran -o sinus sinus.f90 -Ldirectory -lfftw3

run:
	./signal
	./sinus
