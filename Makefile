TEXC=pdflatex
CFLAGS=-interaction=nonstopmode -halt-on-error -file-line-error
BIBC=bibtex
PAPER=abstract
BIBLIO=references
EXAMPLES=coin.links
LINKS=$(HOME)/projects/links/compiler/links
LFLAGS=--config=$(HOME)/projects/links/compiler/default.config -c --native

all: $(PAPER).pdf

snippets: $(EXAMPLES)
	mkdir -p snippets
	bash mksnippets.sh $(EXAMPLES) snippets

$(PAPER).aux: $(PAPER).tex
	$(TEXC) $(CFLAGS) $(PAPER)

$(BIBLIO).bbl: $(PAPER).aux $(BIBLIO).bib
	$(TEXC) $(CFLAGS) $(PAPER)
	$(BIBC) $(PAPER)

$(PAPER).pdf: snippets $(PAPER).aux $(BIBLIO).bbl 
	$(TEXC) $(CFLAGS) $(PAPER)
	$(TEXC) $(CFLAGS) $(PAPER)

camera-ready: all
	$(LINKS) $(LFLAGS) $(EXAMPLES)

clean:
	rm -f *.log *.aux *.toc *.out
	rm -f *.bbl *.blg *.fls *.xml
	rm -f *.fdb_latexmk
	rm -f $(PAPER).pdf
	rm -f *.o *.cmx *.cmo
	rm -rf snippets
