SHELL := /usr/bin/env bash

PAGES := $(wildcard *.md)
HTML_PAGES := $(patsubst %.md,public/%.html,$(PAGES))

.PHONY: all watch
.INTERMEDIATE: index.json

all: $(HTML_PAGES) public/index.html public/style.css.gz

public/%.gz: public/%
	gzip --best --keep --force $<

public/index.html: index.md index.html base.html index.json $(PAGES)
	seite $< -T $(word 2,$^) -T $(word 3,$^) -O $@ --metadata "$$(cat index.json)"

public/%.html: %.md template.html base.html
	seite -T $(word 2,$^) -T $(word 3,$^) $< -O $@

index.json: $(PAGES)
	find . -maxdepth 1  -name '*.md' -not -name 'index.md' -type f \
	   -exec sh -c 'seite "$$1" -T <(echo "{{__tera_context}}") -O - | jq --arg file "$$1" ".file = \$$file"' -- {} \; \
	   | jq -s . \
	   > $@
