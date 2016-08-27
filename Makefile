
# Build a completely static 'slua' on Linux with the Musl C library 
# (with the 'musl-gcc' wrapper provided with Musl C)
#
# This build requires only
#   - the musl libc installed with the linux headers
#   - make, gcc and associated tools
#
# A script building the musl libc and its gcc wrapper is available
# in directory 'tools'. Check it before using it! :-)
#
# Building statically with Glibc:  TL;DR: Don't do it.  :-)
# The minisock library requires functions that cannot be linked 
# statically (getaddrinfo, gethostbyaddr, gesthostbyname). 
# In addition, the executable would be _much_ larger with Glibc,
# eg.  988KB with glibc vs 326KB with musl libc.
# 
# note: to build with glibc or uClibc, must add " -lpthread -lm " at 
# the end of the link lines for slua and sluac.
#
# ----------------------------------------------------------------------

#CC= /f/b/musl1114/bin/musl-gcc
CC= gcc
AR= ar
INCFLAGS= -I../lua/include
CFLAGS= -Os -fPIC $(INCFLAGS) -DLUA_USE_POSIX -DLUA_USE_STRTODHEX \
         -DLUA_USE_AFORMAT -DLUA_USE_LONGLONG
LDFLAGS= -fPIC

LUATWEETNACL_O= luatweetnacl.o randombytes.o tweetnacl.o

tweetnacl.so:  *.c *.h
	$(CC) -c $(CFLAGS) *.c
	$(CC) -shared $(LDFLAGS) -o luatweetnacl.so $(LUATWEETNACL_O)

clean:
	rm -f *.o *.a *.so

.PHONY: clean smoketest

