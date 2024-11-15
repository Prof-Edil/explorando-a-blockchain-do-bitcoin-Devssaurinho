# Create a 1-of-4 P2SH multisig address from the public keys in the four inputs of this tx:
#   `37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517`
TX_ID="37d966a263350fe747f1c606b159987545844a493dd38d84b070027a895c4517"
TX=$(bitcoin-cli getrawtransaction $TX_ID 1)

KEY_0=$(echo $TX | jq .vin[0].txinwitness[1])

KEY_1=$(echo $TX | jq .vin[1].txinwitness[1])

KEY_2=$(echo $TX | jq .vin[2].txinwitness[1])

KEY_3=$(echo $TX | jq .vin[3].txinwitness[1])


address_P2SH=$(bitcoin-cli createmultisig 1 "[$KEY_0, $KEY_1, $KEY_2, $KEY_3]" "legacy" | jq -r .address)

echo $address_P2SH
