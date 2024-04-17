PAPER=pres
TEXC=pdflatex
OUTDIR=../../../assets/presentations
X=$(shell grep -oP '(?<=Capstone Meeting \\#)\d+' $(PAPER).tex)

all: $(PAPER)

$(PAPER): $(PAPER).tex
	$(TEXC) $(PAPER).tex
	mkdir -p $(OUTDIR)
	mv $(PAPER).pdf $(OUTDIR)/meeting_$(X).pdf

clean:
	rm -f *.aux *.log *.out *.toc

.PHONY: clean all
