OUTDIR  := ../dist
THEME   := $(CURDIR)/../avic
LATEXMK := latexmk -xelatex -halt-on-error -interaction=nonstopmode -outdir=$(OUTDIR)

# kpathsea uses ';' as the path separator on Windows, ':' elsewhere.
# The trailing separator is what tells kpathsea to also search the default paths.
ifeq ($(OS),Windows_NT)
KPSESEP := ;
else
KPSESEP := :
endif

export TEXINPUTS := $(THEME)$(KPSESEP)

.PHONY: all blue red open clean distclean

all: blue red

blue: $(OUTDIR)/demo-blue.pdf

red: $(OUTDIR)/demo-red.pdf

$(OUTDIR)/demo-%.pdf: demo-%.tex content.tex $(THEME)/beamerthemeAvic.sty
	$(LATEXMK) demo-$*.tex

open: all
	open $(OUTDIR)/demo-blue.pdf $(OUTDIR)/demo-red.pdf

clean:
	$(LATEXMK) -c demo-blue.tex demo-red.tex

distclean:
	rm -rf $(OUTDIR)
