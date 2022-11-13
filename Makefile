SOURCES = $(realpath sources.txt)

doc: doc-html doc-txt

doc-html: doc-prep
	makeinfo --html --no-split start.texi -o build/out/index.html

doc-txt: doc-prep
	makeinfo --plaintext start.texi -o build/out

doc-prep: prep

prep:
	mkdir -p build/out

readme: prep diagram
	bash build.sh

diagram:
	dot -Tsvg deps.dot > build/deps.svg

.PHONY: clean

clean:
	rm -rf build/*
