# openbuild Task1

1. Step1: config your own env file
```shell
SEPOLIA_RPC_URL=xxx
PRIVATE_KEY=xxx
ETHERSCAN_API_KEY=xxx
```

2. Step2: deploy this contract

If you use `forge script`,please run `source .env` first
If you use `make deploy`,please run `npm i -g make` first,then check the version of `make`(`make --version`)

>If you wanna deploy on the local chain

run the `forge script script/DeployOBC.s.sol:DeployOBC` or `make deploy`

>If you wanna deploy on the test chain like `sepolia`

run the `forge script script/DeployOBC.s.sol:DeployOBC --rpc-url SEPOLIA_RPC_URL --private-key PRIVATE_KEY --broadcast` or `make deploy ARGS="--network sepolia"`

## on sepolia

This contract deployed at https://sepolia.etherscan.io/address/0xed67aa719b638bbda8ae50071ca57694c9f1becd# openbuild-task-erc20
