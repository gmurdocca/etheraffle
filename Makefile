SRC_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.SILENT:
.PHONY: test

help:
	echo "  help        This help"
	echo "  test        Run JavaScript and Solidity tests"

test:
	truffle test --network ropsten

deploy:
	truffle migrate --network ropsten
