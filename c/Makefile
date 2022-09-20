CC = gcc
CFLAGS = -pedantic -Wall -Wextra -c -std=c11
LDFLAGS =

ifdef DEBUG
    CFLAGS += -Og -g
else
    CFLAGS += -O2
endif

NODEPS = clean fclean
SUFFIXES = .d

SOURCES = $(wildcard src/*.c)
DEPFILES = $(patsubst src/%.c,deps/%.d,$(SOURCES))

ifeq (0, $(words $(findstring $(MAKECMDGOALS), $(NODEPS))))
    -include $(DEPFILES)
    -include $(TESTDEPFILES)
endif

build: out/!NAME!
run: out/!NAME!
	$^

clean:
	$(RM) build/*

fclean: clean
	$(RM) out/*
	$(RM) shared/*

deps/%.d: src/%.c
	$(CC) -MT$(patsubst deps/%.d,build/%.o,$@) -MM $^ -o $@

out/%: build/%.o
	$(CC) -o $@ $^ $(LDFLAGS)

out/!NAME!: build/main.o

build/%.o: src/%.o
	$(CC) -o $@ $(CFLAGS) $^

.PHONT: clean fclean build run
