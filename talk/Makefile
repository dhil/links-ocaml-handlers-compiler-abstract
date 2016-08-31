TEXC=pdflatex
CFLAGS=-interaction=nonstopmode -halt-on-error -file-line-error
BIBC=bibtex
PAPER=compilinghandlers
BIBLIO=$(PAPER)

all: $(PAPER).pdf

$(PAPER).aux: $(PAPER).tex
	$(TEXC) $(CFLAGS) $(PAPER)

$(BIBLIO).bbl: $(PAPER).aux $(BIBLIO).bib
	$(TEXC) $(CFLAGS) $(PAPER)
	$(BIBC) $(PAPER)

$(PAPER).pdf: $(PAPER).aux $(BIBLIO).bbl 
	$(TEXC) $(CFLAGS) $(PAPER)
	$(TEXC) $(CFLAGS) $(PAPER)

clean:
	rm -f *.log *.aux *.toc *.out
	rm -f *.bbl *.blg *.fls *.xml
	rm -f *.nav *.snm *.vrb
	rm -f *.fdb_latexmk
	rm -f $(PAPER).pdf
	rm -f *.o *.cmx *.cmo
