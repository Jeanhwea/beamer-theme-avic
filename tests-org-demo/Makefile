OUTDIR  := out
DISTDIR := ../dist
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
PDF  := $(DISTDIR)/demo.pdf

.PHONY: all pandoc clean distclean

all: $(PDF)

# pandoc 将 org 转为 beamer LaTeX
pandoc: $(TEX)

$(TEX): $(ORG) | $(OUTDIR)
	pandoc $(ORG) -o $(TEX) --to beamer --standalone

# 编译生成的 .tex，再将 PDF 复制到 dist
$(PDF): $(TEX) $(THEME)/beamerthemeAvic.sty | $(DISTDIR)
	$(LATEXMK) $(TEX)
	cp $(OUTDIR)/demo.pdf $(PDF)

$(OUTDIR):
	mkdir -p $(OUTDIR)

$(DISTDIR):
	mkdir -p $(DISTDIR)

clean:
	$(LATEXMK) -c $(TEX)

distclean:
	rm -rf $(OUTDIR) $(PDF)
