SOURCES := $(wildcard src/**/*.rs)

BUILD_FLAGS :=
ifdef RELEASE
TARGET := out/!NAME!
ACTUAL_LOCATION := target/release/!NAME!
BUILD_FLAGS += --release
else
TARGET := out/!NAME!-debug
ACTUAL_LOCATION := target/debug/!NAME!
endif

all: build
build: $(TARGET)

check:
	@cargo clippy

clean:
	cargo clean
	$(RM) out

test:
	@cargo test

out:
	@mkdir out

$(TARGET): $(ACTUAL_LOCATION) | out
	@cp $< $@

$(ACTUAL_LOCATION): $(SOURCES)
	cargo build $(BUILD_FLAGS)

.PHONY: all build check clean run test
