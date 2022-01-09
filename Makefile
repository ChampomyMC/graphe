
srcdir=src
bindir=bin

SRC=$(wildcard src/*.dot)

DOT=$(SRC:.dot=-dot.dot)
NEATO=$(SRC:.dot=-neato.dot)
TWOPI=$(SRC:.dot=-twopi.dot)
CIRCO=$(SRC:.dot=-circo.dot)
FDP=$(SRC:.dot=-fdp.dot)
SFDP=$(SRC:.dot=-sfdp.dot)
PATCHWORK=$(SRC:.dot=-patchwork.dot)
OSAGE=$(SRC:.dot=-osage.dot)

ALL=${DOT} ${NEATO} ${TWOPI} ${CIRCO} ${FDP} ${PATCHWORK} ${OSAGE}

SVG=$(subst $(srcdir),$(bindir),$(ALL:.dot=.svg))
PNG=$(subst $(srcdir),$(bindir),$(ALL:.dot=.png))


all: $(SVG) $(PNG)

$(bindir)/%-dot.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	dot -Tsvg $< > $@


$(bindir)/%-neato.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	neato -Tsvg $< > $@


$(bindir)/%-twopi.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	twopi -Tsvg $< > $@


$(bindir)/%-circo.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	circo -Tsvg $< > $@

	
$(bindir)/%-fdp.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	fdp -Tsvg $< > $@


$(bindir)/%-sfdp.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	sfdp -Tsvg $< > $@

	
$(bindir)/%-patchwork.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	patchwork -Tsvg $< > $@


$(bindir)/%-osage.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	osage -Tsvg $< > $@






$(bindir)/%-dot.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	dot -Tpng $< > $@


$(bindir)/%-neato.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	neato -Tpng $< > $@


$(bindir)/%-twopi.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	twopi -Tpng $< > $@


$(bindir)/%-circo.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	circo -Tpng $< > $@

	
$(bindir)/%-fdp.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	fdp -Tpng $< > $@


$(bindir)/%-sfdp.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	sfdp -Tpng $< > $@

	
$(bindir)/%-patchwork.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	patchwork -Tpng $< > $@


$(bindir)/%-osage.png: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	osage -Tpng $< > $@



clean:
	rm -rf $(bindir)

.PHONY: all clean
