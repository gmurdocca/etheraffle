# Etheraffle

Raffle DApp on Ethereum

## Goals

To learn Solidity development using Truffle to produce a Raffle DApp.

Contract will accept limited Ether from any account. At a set future point in time (the Draw date), it will use an RNG oracle to perform a weighted random selection of 1st, 2nd and 3rd palce winners (sender accounts) based on the ratio of their inputted funds against the total pool size, and receive 70%, 20% and 10% of the pool respectively.

## Setup

- Install Node.js on your system
- run `make deps`
- Create an Infura account at [https://infura.io], Create an Ethereum project, set endpoint to `Ropsten`, note the `PROJECT ID`
- Install MetaMask browser plugin, select Ropsten network, grab mnemonic value from Settings -> Security and Privacy -> Reveal Seed Phrase
- Copy `.secrets.json.example` to `.secrets.json`, set `project_id` and `mnemonic` values from above steps
- Add some fake ETH funds to your test wallet via [https://faucet.metamask.io/]
- Run `make test`
- Deploy the contract to Ropsten network: `make deploy`

Notes:
- If you already use MetaMask, consider installing a separate browser, eg. IceCat (Firefox fork), and installing the MetaMask addon on that.
- If you want to re-deploy the Contract, run `make deploy ARGS="--reset"`
