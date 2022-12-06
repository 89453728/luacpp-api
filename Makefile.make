## Example of C++ usage with lua API.
## Author: Achengli Yassin

CC = clang++

FLAGS = -std=c++11 -g -fpic -Wall 
LIBS = -L/usr/local/lib/ -llua5.3
INC = -I/usr/local/include/lua-5.3/

OCT = none
BLAS = none
#
ifeq ($(OCT),yes)
FLAGS += -D MATRIX=1
LIBS += -L/usr/local/lib/octave/5.2.0/ -loctave
INC += -I/usr/local/include/octave-5.2.0/
endif

ifeq ($(BLAS),yes)
INC += -I/usr/local/include/boost/numeric/ -I/usr/local/include/
FLAGS += -D BLAS=1
endif

FILES = hello.cpp

all: $(patsubst %.cpp,%.so,$(FILES))
	@echo "compilation done"
	@echo "running test file"
	@lua test.lua
%.o : $(FILES)
	$(CC) $(FLAGS) $(INC) -c $< -o $@

%.so : $(patsubst %.cpp,%.o,$(FILES))
	$(CC) $(FLAGS) $(LIBS) -shared -o $@ $<

.PHONY: clean all release

clean:
	@rm -rf *.{so,o}
	@echo "all object and shared library files have been removed"

release:
	@echo "moving .so files in build directory"
	@mkdir -p build
	@mv *.so build/
