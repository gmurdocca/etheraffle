# Etheraffle

Raffle DApp on Ethereum

## Setup

- Install Truffle at [https://www.trufflesuite.com/truffle]
- Create an Infura account at [https://infura.io], Create an Ethereum project, set endpoint to `Ropsten`, note the `PROJECT ID`
- Install MetaMask browser plugin, select Ropsten network, grab mnemonic value from Settings -> Security and Privacy -> Reveal Seed Phrase
- Copy `.secrets.json.example` to `.secrets.json`, set `project_id` and `mnemonic` values from above steps
- Add some fake ETH funds to your test wallet via [https://faucet.metamask.io/]
- Run `make test`
- Deploy the contract to Ropsten network: `make deploy`

Note: If you already use MetaMask, consider installing a separate browser, eg. IceCat (Firefox fork), and installing the MetaMask addon on that.

