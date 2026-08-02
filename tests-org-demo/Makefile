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

ORG  := demo.org
TEX  := $(OUTDIR)/demo.tex
PDF  := $(OUTDIR)/demo.pdf

.PHONY: all pandoc clean distclean

all: $(PDF)

# pandoc 将 org 转为 beamer LaTeX
pandoc: $(TEX)

$(TEX): $(ORG) | $(OUTDIR)
	pandoc $(ORG) -o $(TEX) --to beamer --standalone

# 编译生成的 .tex
$(PDF): $(TEX) $(THEME)/beamerthemeAvic.sty
	$(LATEXMK) $(TEX)

$(OUTDIR):
	mkdir -p $(OUTDIR)

clean:
	$(LATEXMK) -c $(TEX)

distclean:
	rm -rf $(OUTDIR)
