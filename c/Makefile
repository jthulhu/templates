CC = gcc
CFLAGS = -pedantic -Wall -Wextra -c -std=c11
LDFLAGS =

DESTDIR = 
PREFIX = /usr/local
BINDIR = $(DESTDIR)$(PREFIX)/bin

ifdef DEBUG
    CFLAGS += -Og -g
else
    CFLAGS += -O2
endif

NODEPS = clean distclean
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
	install -D -m755 $< $(BINDIR)/!NAME!

clean:
	@$(RM) out/*

distclean: clean
	@$(RM) deps/*

deps/%.d: src/%.c | deps
	$(CC) -MT$(patsubst deps/%.d,out/%.o,$@) -MM $^ -o $@

out/%: out/%.o | out
	$(CC) -o $@ $^ $(LDFLAGS)

out/!NAME!: out/main | out
	@cp $< $@

out/%.o: src/%.c | out
	$(CC) -o $@ $(CFLAGS) $^

out deps:
	@mkdir $@

.PHONY: clean distclean build run all install
