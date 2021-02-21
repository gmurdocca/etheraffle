SRC_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
.SILENT:
.PHONY: test

help:
	echo "  help        	This help"
	echo "  test        	Run JavaScript and Solidity tests"
	echo "  deps        	Install dependencies into node_modules/"
	echo "  deploy      	Deploy Contracts to Ethereum. Add ARGS=\"--reset\" to deploy from the beginning (first migration)"

deps:
	which npm >/dev/null 2>&1 || (echo "Please install Node.js" && exit 1)
	npm install package-json	

test:
	$$(npm bin)/truffle test --network ropsten

deploy:
	echo "$$(date) - Starting Deployment" >> deploy.log
	$$(npm bin)/truffle migrate $(ARGS) --network ropsten 2>&1 | tee -a deploy.log
	echo "Wrote logs to ./deploy.log"
