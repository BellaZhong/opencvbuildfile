#!/bin/bash

if [ $# -gt 0 ] ; then
    c_fs=c
    cpp_fs=p
    filename=$1
    length=${#filename}
    end=${filename:$length-1:1}		
    base=`basename $1 .c`
    if [ $end = $c_fs ]; then
	gcc -ggdb `pkg-config opencv --cflags --libs` $base.c -o $base
	echo "compile $base .c"
    elif [ $end = $cpp_fs ]; then
	g++ -ggdb `pkg-config --cflags opencv` -o `basename $base .cpp` $base `pkg-config --libs opencv`;
    	echo "compile $base .cpp"
    else
	echo "unknown build type."
	echo "Please retry."
    fi


else
    for i in *.c; do
        echo "compiling $i +++++"
        gcc -ggdb `pkg-config --cflags opencv` -o `basename $i .c` $i `pkg-config --libs opencv`;
    done
    for i in *.cpp; do
        echo "compiling $i"
        g++ -ggdb `pkg-config --cflags opencv` -o `basename $i .cpp` $i `pkg-config --libs opencv`;
    done
fi
