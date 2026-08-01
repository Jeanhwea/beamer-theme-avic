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

# 四种组合：配色 blue/red × 标题带 plain/gradient
DEMOS := blue-plain blue-gradient red-plain red-gradient
TEXS  := $(patsubst %,demo-%.tex,$(DEMOS))
PDFS  := $(patsubst %,$(OUTDIR)/demo-%.pdf,$(DEMOS))

.PHONY: all $(DEMOS) open clean distclean

all: $(PDFS)

# 便捷目标：make red-gradient 等
$(DEMOS): %: $(OUTDIR)/demo-%.pdf

$(OUTDIR)/demo-%.pdf: demo-%.tex content.tex $(THEME)/beamerthemeAvic.sty
	$(LATEXMK) demo-$*.tex

open: all
	open $(PDFS)

clean:
	$(LATEXMK) -c $(TEXS)

distclean:
	rm -rf $(OUTDIR)
