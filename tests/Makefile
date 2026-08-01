LATEXMK  := latexmk -xelatex -halt-on-error -interaction=nonstopmode
BLUEPATH := $(CURDIR)/../avicblue
REDPATH  := $(CURDIR)/../avicred

.PHONY: all blue red open clean distclean

all: blue red

blue: demo-blue.pdf

red: demo-red.pdf

demo-blue.pdf: demo-blue.tex content.tex $(BLUEPATH)/beamerthemeAvicBlue.sty
	TEXINPUTS="$(BLUEPATH):" $(LATEXMK) demo-blue.tex

demo-red.pdf: demo-red.tex content.tex $(REDPATH)/beamerthemeAvicRed.sty
	TEXINPUTS="$(REDPATH):" $(LATEXMK) demo-red.tex

open: all
	open demo-blue.pdf demo-red.pdf

clean:
	latexmk -c demo-blue.tex demo-red.tex

distclean:
	latexmk -C demo-blue.tex demo-red.tex
