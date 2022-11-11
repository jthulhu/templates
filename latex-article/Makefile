LATEX_ENGINE := lualatex

out:
	@mkdir out

out/%.pdf: src/ | out
	$(LATEX_ENGINE) -output-directory=out $@
