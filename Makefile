
srcdir=src
bindir=bin
SRC=$(wildcard src/*.dot)
SVG=$(subst $(srcdir),$(bindir),$(SRC:.dot=.svg))

all: $(SVG)
	echo "$(SVG)"

$(bindir)/%.svg: $(srcdir)/%.dot
	@mkdir -p $(bindir)
	dot -Tsvg $< > $@

clean:
	rm -rf $(bindir)

.PHONY: all clean
