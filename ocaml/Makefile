all: !NAME!

out:
	@mkdir $@

out/%.exe: src/ | out
	dune build $(patsubst out/%.exe,src/%.exe,$@)

out/%: out/%.exe
	cp $< $@

clean:
	dune clean
	$(RM) out/*

all: out/!NAME!

.PHONY: all clean
