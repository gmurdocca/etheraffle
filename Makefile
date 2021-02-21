SRC_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.SILENT:
.PHONY: test

help:
	echo "  help        This help"
	echo "  test        Run JavaScript and Solidity tests"
	echo "  mnemonic    Create a randmon mnemonic (eg. to store in .secret)"

test:
	truffle test --network ropsten

mnemonic:
	which virtualenv >/dev/null || (echo "Please install virtualenv (`pip install virtualenv`)" && exit 1)
	test -d .env || virtualenv -p python3 .env >/dev/null 2>&1
	. .env/bin/activate >&2 && \
	pip install -r requirements.txt >/dev/null 2>&1 && \
    python3 -c "from hdwallet.utils import generate_mnemonic; print(generate_mnemonic('english', 128))"
