start-regtest:
  bitcoind -regtest -txindex

load wallet="ord":
  bitcoin-cli -regtest -rpcwallet={{wallet}} loadwallet {{wallet}}

mine blocks="1" wallet="ord":
  #!/usr/bin/env bash
  set -euxo pipefail
  address="$(bitcoin-cli -regtest -rpcwallet={{wallet}} getrawchangeaddress "bech32m")"
  bitcoin-cli -regtest generatetoaddress {{blocks}} $address

dump wallet="ord":
  RUST_LOG=info cargo run -- --regtest wallet dump
