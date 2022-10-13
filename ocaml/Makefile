all: !NAME!

out/!NAME.exe:
	dune build

%: out/%.exe
	cp $< $@

clean:
	dune clean
	rm out/*
	rm !NAME!

.PHONY: all clean out/!NAME!.exe
