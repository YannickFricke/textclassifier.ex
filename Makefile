.PHONY: clear build run test

clear:
	clear

build: clear
	mix escript.build

run: build
	./textclassifier

test:
	mix test
