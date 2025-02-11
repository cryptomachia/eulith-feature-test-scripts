#!/bin/bash

function show_help() {
  echo -e "\nYou can run a variety of Eulith examples from this script. Here are the options:\n"
  echo "  -e               |  ERC20 handling"
  echo "  -k               |  KMS"
  echo "  -s               |  Swap"
  echo "  -t <TO_ADDRESS>  |  Simple Transfer"
  echo "  -c               |  Transfer from toolkit contract"
  echo "  -u               |  Get Uniswap quotes (float price and sqrt limit) for a given volume without executing the trade"
  echo "  -a               |  Atomic transaction(all or nothing individual transactions sent as a bundle)"
  echo "  -m               |  Getting market data: prices, spread, gas fees, etc. Use for analysis"
  echo "  -g               |  Gas fee calculations"
  echo "  -z               |  Stablecoin base arbitrage"
  echo -e "\nIf you would like to examine the code for the examples, have a look at the files in the examples folder.\n"
}

function run_simple_transfer() {
  python examples/simple_transfer.py "$1"
}

if [ $# -eq 0 ]; then
    show_help
    exit 1
fi

source venv/bin/activate

while getopts "h?ekst:cuamgz" opt; do
  case "$opt" in
    h|\?)
      show_help
      exit 0
      ;;
    e) python examples/erc20_handling.py
      ;;
    k) python examples/kms_signer.py
      ;;
    s) python examples/swap.py
      ;;
    t) run_simple_transfer $OPTARG
      ;;
    c) python examples/transfer_from_toolkit.py
      ;;
    u) python examples/uniswap_sqrtlimit_quote.py
      ;;
    a) python examples/atomic_transactions.py
      ;;
    m) python examples/market_data.py
      ;;
    g) python examples/transaction_gas_fees.py
      ;;
    z) python examples/stablecoin_base_arbitrage.py
      ;;
  esac
done