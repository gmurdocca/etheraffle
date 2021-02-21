# Etheraffle

Raffle DApp on Ethereum

## Setup

- Create an account at infura.io
- Create an Ethereum project at infura.io, set endpoint to Ropsten, note the PROJECT ID
- Install MetaMask browser plugin, select Ropsten network, create a wallet, grab mnemonic value from Settings -> Security and Privacy -> Reveal Seed Phrase
- Copy `.secrets.json.example` to `.secrets.json`, set `project_id` and `mnemonic` values from above steps
- Run `make test`
