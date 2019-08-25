#!/bin/sh -x

gcc -O4 -march=native -o dcraw dcraw.c \
	-Wall -Wno-unused-result -Wno-array-bounds -Wno-uninitialized \
	-Wno-unused-const-variable \
	-lm -DNODEPS

strip dcraw