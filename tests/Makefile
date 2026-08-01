OUTDIR   := ../dist
LATEXMK  := latexmk -xelatex -halt-on-error -interaction=nonstopmode -outdir=$(OUTDIR)
BLUEPATH := $(CURDIR)/../avicblue
REDPATH  := $(CURDIR)/../avicred

.PHONY: all blue red open clean distclean

all: blue red

blue: $(OUTDIR)/demo-blue.pdf

red: $(OUTDIR)/demo-red.pdf

$(OUTDIR)/demo-blue.pdf: demo-blue.tex content.tex $(BLUEPATH)/beamerthemeAvicBlue.sty
	TEXINPUTS="$(BLUEPATH):" $(LATEXMK) demo-blue.tex

$(OUTDIR)/demo-red.pdf: demo-red.tex content.tex $(REDPATH)/beamerthemeAvicRed.sty
	TEXINPUTS="$(REDPATH):" $(LATEXMK) demo-red.tex

open: all
	open $(OUTDIR)/demo-blue.pdf $(OUTDIR)/demo-red.pdf

clean:
	$(LATEXMK) -c demo-blue.tex demo-red.tex

distclean:
	rm -rf $(OUTDIR)
