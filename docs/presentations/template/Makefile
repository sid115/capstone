MAIN=pres
TEXC=pdflatex
OUTDIR=../../../assets/presentations
OUTNAME=$(shell basename `pwd`)

all: $(MAIN)

$(MAIN): $(MAIN).tex
	$(TEXC) $(MAIN).tex
	mkdir -p $(OUTDIR)
	mv $(MAIN).pdf $(OUTDIR)/$(OUTNAME).pdf

clean:
	rm -f *.aux *.log *.out *.toc

.PHONY: clean all
