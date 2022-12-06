## Example of C++ usage with lua API.
## Author: Achengli Yassin

CC = g++
FLAGS = -std=c++11 -g -fpic -Wall
LIBS = -llua
INC = /usr/include/

all: $(patsubst %.cpp,%.so,$(wildcard *.cpp))
	@echo "compilation done"

%.o : $(wildcard *.cpp)
	$(CC) $(FLAGS) -I $(INC) -c $< -o $@

%.so : $(patsubst %.cpp,%.o,$(wildcard *.cpp))
	$(CC) $(FLAGS) $(LIBS) -shared -o $@ $<

.PHONY: clean all

clean:
	@rm -rf *.{so,o}
	@echo "all object and shared library files have been removed"

release:
	@echo "moving .so files in build directory"
	@mkdir -p build
	@mv *.so build/
