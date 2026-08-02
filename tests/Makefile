OUTDIR  := out
DISTDIR := ../dist
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
PDFS  := $(patsubst %,$(DISTDIR)/demo-%.pdf,$(DEMOS))

# org-mode 示例
ORG    := demo-org-example.org
ORGTEX := $(OUTDIR)/demo-org-example.tex
ORGPDF := $(DISTDIR)/demo-org-example.pdf

.PHONY: all $(DEMOS) org pandoc open clean distclean

all: $(PDFS) $(ORGPDF)

# 便捷目标：make red-gradient 等
$(DEMOS): %: $(DISTDIR)/demo-%.pdf

$(DISTDIR)/demo-%.pdf: demo-%.tex content.tex $(THEME)/beamerthemeAvic.sty | $(OUTDIR) $(DISTDIR)
	$(LATEXMK) demo-$*.tex
	cp $(OUTDIR)/demo-$*.pdf $(DISTDIR)/

# org-mode: pandoc 转 beamer LaTeX
pandoc: $(ORGTEX)

$(ORGTEX): $(ORG) | $(OUTDIR)
	pandoc $(ORG) -o $(ORGTEX) --to beamer --standalone

$(ORGPDF): $(ORGTEX) $(THEME)/beamerthemeAvic.sty | $(OUTDIR) $(DISTDIR)
	$(LATEXMK) $(ORGTEX)
	cp $(OUTDIR)/demo-org-example.pdf $(DISTDIR)/

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(DISTDIR):
	mkdir -p $(DISTDIR)

open: all
	open $(PDFS) $(ORGPDF)

clean:
	$(LATEXMK) -c $(TEXS) $(ORGTEX)

distclean:
	rm -rf $(OUTDIR) $(DISTDIR)
