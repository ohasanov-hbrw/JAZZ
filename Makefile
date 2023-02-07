CC = g++ -I/usr/include/SDL2
cflags = -std=c++17 -g -O2
ldflags += -Iinclude -lstdc++ -lSDL2main -lSDL2 -lpthread 
name = JAZZ 

sources = $(wildcard src/*.cpp)
objects = $(patsubst src/%, object/%,$(sources:.cpp=.o))
deps = $(objects:.o=.d)

-include $(deps)
.PHONY: all clean

all: files $(name)

files:
	mkdir -p bin object build

run: $(name)
	bin/$(name) 

$(name): $(objects)
	$(CC) -o bin/$(name) $^ $(ldflags)

object/%.o: src/%.cpp
	$(CC) -MMD -o $@ -c $< $(cflags)

clean:
	rm -rf bin/$(name) $(objects) object/*.d 
