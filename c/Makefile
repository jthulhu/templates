CC = gcc
CFLAGS = -pedantic -Wall -Wextra -c -std=c11
LDFLAGS =

PREFIX =
TARGET = $(PREFIX)/bin

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
endif

all: build

build: out/!NAME!
run: out/!NAME!
	$^
install: out/!NAME!
	install -D -m755 $< $(TARGET)/!NAME!

clean:
	@$(RM) build/*

fclean: clean
	@$(RM) out/*
	@$(RM) shared/*

deps/%.d: src/%.c
	@mkdir -p $(@D)
	$(CC) -MT$(patsubst deps/%.d,build/%.o,$@) -MM $^ -o $@

out/%: build/%.o
	@mkdir -p $(@D)
	$(CC) -o $@ $^ $(LDFLAGS)

out/!NAME!: out/main
	@cp $< $@

build/%.o: src/%.c
	@mkdir -p $(@D)
	$(CC) -o $@ $(CFLAGS) $^

.PHONY: clean fclean build run all install
