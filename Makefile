SHELL := bash
SEITE := seite
PAGES := $(filter-out index.md, $(wildcard *.md))
HTML_PAGES := $(patsubst %.md,public/%/index.html,$(PAGES))

.PHONY: all serve
.INTERMEDIATE: index.json

all: $(HTML_PAGES) public/index.html public/sitemap.xml public/style.css.gz public/syntax-light.css public/syntax-light.css.gz public/syntax-dark.css public/syntax-dark.css.gz

serve:
	python3 -m http.server -d public

public/%.gz: public/%
	gzip --best --keep --force $<

public/index.html: index.md templates/index.html templates/base.html index.json
	$(SEITE) $< -T $(word 2,$^) -T $(word 3,$^) -O $@ \
		--metadata "$$(cat index.json | jq --arg filename $< '{ "filename": $$filename, "pages": . }')"

public/%/index.html: %.md templates/template.html templates/base.html
	mkdir -p $(@D)
	$(SEITE) -T $(word 2,$^) -T $(word 3,$^) $< -O $@ \
	   --metadata "$$(jq --null-input --arg filename $< '{ "filename": $$filename }')" \
	   --highlight-command 'sh -c '"'"'printf "<pre class=hl><code>" && highlight --syntax "$$1" -O html --fragment && printf "</code></pre>"'"'"' -- {}'

public/sitemap.xml: templates/sitemap.xml index.json
	$(SEITE) -T $< <(echo "") --metadata "$$(cat index.json)" -O $@

index.json: $(PAGES)
	echo "$^" \
		| xargs -n1 bash -c '$(SEITE) "$$1" -T <(echo "{{__tera_context}}") -O - | jq --arg file "$$1" ".file = \$$file"' -- \
		| jq -s . \
		> $@

public/syntax-dark.css:
	highlight  --print-style -O html -s andes --stdout > $@

public/syntax-light.css:
	highlight  --print-style -O html -s github --stdout > $@
