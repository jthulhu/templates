all: build

build: out/!NAME!

clean:
	dune clean
	$(RM) out/*

run: out/!NAME!
	@$<
out:
	@mkdir $@

out/%.exe: src/ | out
	dune build $(patsubst out/%.exe,src/%.exe,$@)

out/%: out/%.exe
	cp $< $@

.PHONY: all build clean run
