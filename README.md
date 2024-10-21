## Foundry

**Foundry is a blazing fast, portable and modular toolkit for Ethereum application development written in Rust.**

Foundry consists of:

-   **Forge**: Ethereum testing framework (like Truffle, Hardhat and DappTools).
-   **Cast**: Swiss army knife for interacting with EVM smart contracts, sending transactions and getting chain data.
-   **Anvil**: Local Ethereum node, akin to Ganache, Hardhat Network.
-   **Chisel**: Fast, utilitarian, and verbose solidity REPL.

## Documentation

https://book.getfoundry.sh/

## Usage

### Build

```shell
$ forge build
```

### Test

```shell
$ forge test
```

### Format

```shell
$ forge fmt
```

### Gas Snapshots

```shell
$ forge snapshot
```

### Anvil

```shell
$ anvil
```

### Deploy & Verify

```shell
$ forge script script/Deploy.s.sol:DeployScript --rpc-url <your_rpc_url> --private-key <your_private_key> --broadcast --verify -vvvv
```

### Deployed & Verified Contract Addresses

```shell
KingToken: 0xaFd59866dd3290293C6d0bA421c1586D7A0b3207
```

```shell
KingStakingPool: 0x1232478bC9c2715ec185160490eE1F087FD35814
```

```shell
KingCollections: 0x0F210d07867F4887425Fd5811d962c39443aff11
```

### Help

```shell
$ forge --help
$ anvil --help
$ cast --help
```
