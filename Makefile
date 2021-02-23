SRC_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.SILENT:
.PHONY: test

NETWORK ?= ropsten

help:
	echo "Makefile targets:"
	echo "  help        	This help"
	echo "  deps        	Install dependencies into node_modules/"
	echo "  test        	Run JavaScript and Solidity tests"
	echo "  deploy      	Deploy Contracts to Ethereum."
	echo "Options:"	
	echo "  Modify the target network (specified in truffle-config.js) via NETWORK arg, eg: NETWORK=ganache"
	echo "  Add any Truffle args to \`test\` and \`deploy\` targets via ARGS arg, eg ARGS=\"--reset\" to deploy the contract from the beginning (first migration)"

deps:
	which npm >/dev/null 2>&1 || (echo "Please install Node.js" && exit 1)
	npm install package-json	

test:
	$$(npm bin)/truffle test $(ARGS) --network $(NETWORK)

deploy:
	echo "*** $$(date) - Starting Deployment" >> deploy.log
	$$(npm bin)/truffle migrate $(ARGS) --network $(NETWORK) 2>&1 | tee -a deploy.log
	echo "Wrote logs to ./deploy.log"

debug:
	$$(npm bin)/truffle debug
