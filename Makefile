SHELL := bash
PAGES := $(wildcard *.md)
HTML_PAGES := $(patsubst %.md,public/%/index.html,$(PAGES))

.PHONY: all serve
.INTERMEDIATE: index.json

all: $(HTML_PAGES) public/index.html public/sitemap.xml public/style.css.gz

serve:
	python3 -m http.server -d public

public/%.gz: public/%
	gzip --best --keep --force $<

public/index.html: index.md index.html base.html index.json
	seite $< -T $(word 2,$^) -T $(word 3,$^) -O $@ \
		--metadata "$$(cat index.json | jq --arg filename $< '{ "filename": $$filename, "pages": . }')"

public/%/index.html: %.md template.html base.html
	mkdir -p $(@D)
	seite -T $(word 2,$^) -T $(word 3,$^) $< -O $@ \
	   --metadata "$$(jq --null-input --arg filename $< '{ "filename": $$filename }')"

public/sitemap.xml: sitemap.xml index.json
	seite -T $< <(echo "") --metadata "$$(cat index.json)" -O $@

index.json: $(PAGES)
	find . -maxdepth 1  -name '*.md' -not -name 'index.md' -type f \
	   -exec bash -c 'seite "$$1" -T <(echo "{{__tera_context}}") -O - | jq --arg file "$$1" ".file = \$$file"' -- {} \; \
	   | jq -s . \
	   > $@
