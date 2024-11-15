# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`

TX_ID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
TX=$(bitcoin-cli getrawtransaction $TX_ID 1)

keys=()
for i in {0..3}; do
    keys+=($(echo $TX | jq -r ".vin[$i].txinwitness[1]"))
done

address_P2SH=$(bitcoin-cli createmultisig 1 "$(printf '[%s]' "$(IFS=,; echo "${keys[*]}")")" "legacy" | jq -r .address)

echo $address_P2SH
