TARGET_EXEC = <EXEC>
CC = clang++

SRC = $(wildcard src/*.cpp) $(wildcard src/**/*.cpp) $(wildcard src/**/**/*.cpp) $(wildcard src/**/**/**/*.cpp)
OBJ = $(SRC:.cpp=.o)
ASM = $(SRC:.cpp=.S)
BIN = bin

INC_DIR_SRC = -Isrc
INC_DIR_LIB =

DEBUGFLAGS = $(INC_DIR_SRC) $(INC_DIR_LIB) -Wall -g
RELEASEFLAGS = $(INC_DIR_SRC) $(INC_DIR_LIB) -O2
ASMFLAGS = $(INC_DIR_SRC) $(INC_DIR_LIBS) -Wall
LDFLAGS = $(LIBS) -lm -fuse-ld=mold

.PHONY: all libs clean 

all: 
	$(MAKE) -j8 bld
	$(MAKE) link

dirs:
	mkdir -p ./$(BIN)

link: $(OBJ)
	$(CC) -o $(BIN)/$(TARGET_EXEC) $^ $(LDFLAGS)

bld: 
	$(MAKE) clean
	$(MAKE) dirs
	$(MAKE) obj

obj: $(OBJ)

asm: cleanassembly $(ASM)

%.o: %.cpp
	$(CC) -std=c++20 -o $@ -c $< $(DEBUGFLAGS)

%.S: %.cpp
	$(CC) -std=c++20 -S -O -o $@ -c $< $(ASMFLAGS)

clean:
	clear
	rm -rf $(BIN) $(OBJ)

cleanassembly:
	rm -rf $(ASM)
