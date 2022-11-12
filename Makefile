SOURCES = $(realpath sources.txt)

all: html txt

html: prep
	makeinfo --html --no-split start.texi -o build/out/index.html

txt: prep
	makeinfo --plaintext start.texi -o build/out

prep:
	mkdir -p build/out
	#perl setup.pl $(SOURCES) build

.PHONY: clean

clean:
	rm -rf build/*
