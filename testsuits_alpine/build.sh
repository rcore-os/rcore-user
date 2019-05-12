gcc -c dlmain.c -o dlmain.o
gcc -c func.c -o func.o
cc -shared -fPIC func.c -o libfunc.so
gcc dlmain.c libfunc.so -o dlmain

go build hello.go

javac HelloWorld.java

#java HelloWorld
