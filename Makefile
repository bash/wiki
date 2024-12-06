SHELL := /usr/bin/env bash

PAGES := $(wildcard *.md)
HTML_PAGES := $(patsubst %.md,public/%.html,$(PAGES))

.PHONY: all watch

all: $(HTML_PAGES) public/index.html public/style.css.gz

public/%.gz: public/%
	gzip --best --keep --force $<

public/index.html: index.md index.html base.html $(PAGES)
	seite $< -T $(word 2,$^) -T $(word 3,$^) -O $@ --metadata \
	   "$$(find . -maxdepth 1  -name '*.md' -not -name 'index.md' -type f \
	   	   -exec sh -c 'seite "$$1" -T <(echo "{{__tera_context}}") -O - | jq --arg file "$$1" ".file = \$$file"' -- {} \; \
	       | jq -s .)"

public/%.html: %.md template.html base.html
	seite -T $(word 2,$^) -T $(word 3,$^) $< -O $@
