#!/bin/sh -x

gcc -O3 -o dcraw dcraw.c -lm -DNODEPS

strip dcraw