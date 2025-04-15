CC = gcc
CFLAGS = -Wall -O2 $(shell pkg-config --cflags glfw3 libgl)
LDFLAGS = $(shell pkg-config --libs glfw3 libgl)
SOURCES = src/main.c
TARGET = game

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CC) $(CFLAGS) $(SOURCES) -o $(TARGET) $(LDFLAGS)

clean:
	rm -f $(TARGET)

.PHONY: all clean
