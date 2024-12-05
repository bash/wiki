PAGES := $(wildcard *.md)
HTML_PAGES := $(patsubst %.md,public/%.html,$(PAGES))

.PHONY: all watch

all: $(HTML_PAGES) public/style.css.gz

public/%.html: %.md template.html
	seite -T template.html $< -O $@

public/%.gz: public/%
	gzip --best --keep --force $<
