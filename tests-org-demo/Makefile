OUTDIR  := ../dist
THEME   := $(CURDIR)/../avic
LATEXMK := latexmk -xelatex -halt-on-error -interaction=nonstopmode -outdir=$(OUTDIR)

# kpathsea uses ';' as the path separator on Windows, ':' elsewhere.
ifeq ($(OS),Windows_NT)
KPSESEP := ;
else
KPSESEP := :
endif

export TEXINPUTS := $(THEME)$(KPSESEP)

ORG := demo.org
TEX := demo.tex
PDF := $(OUTDIR)/demo.pdf

.PHONY: all pandoc clean distclean

all: $(PDF)

# pandoc 将 org 转为 beamer LaTeX
pandoc: $(TEX)

$(TEX): $(ORG)
	pandoc $(ORG) -o $(TEX) --to beamer --standalone

# 编译生成的 .tex
$(PDF): $(TEX) $(THEME)/beamerthemeAvic.sty
	$(LATEXMK) demo.tex

clean:
	$(LATEXMK) -c demo.tex

distclean:
	rm -rf $(OUTDIR)
