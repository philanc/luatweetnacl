
# ----------------------------------------------------------------------
# adjust the following according to your Lua install
#
#	LUADIR can be defined. In that case, 
#	Lua binary and include files are to be found repectively in 
#	$(LUADIR)/bin and $(LUADIR)/include
#
#	Or LUA and LUAINC can be directly defined as the path of the 
#	Lua executable and the path of the Lua include directory,
#	respectively.

LUADIR ?= ../lua
LUA ?= $(LUADIR)/bin/lua
LUAINC ?= $(LUADIR)/include

# ----------------------------------------------------------------------

CC= gcc
AR= ar

CFLAGS= -Os -fPIC -I$(LUAINC) 
LDFLAGS= -fPIC

OBJS= luatweetnacl.o randombytes.o tweetnacl.o

luatweetnacl.so:  *.c *.h
	$(CC) -c $(CFLAGS) *.c
	$(CC) -shared $(LDFLAGS) -o luatweetnacl.so $(OBJS)

test:  luatweetnacl.so
	$(LUA) smoketest.lua
	
clean:
	rm -f *.o *.a *.so

.PHONY: clean test

