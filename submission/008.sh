# Which public key signed input 0 in this tx:
#   `e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163`
TX_ID="e5969add849689854ac7f28e45628b89f7454b83e9699e551ce14b6f90c86163"
RAW_TX=$(bitcoin-cli getrawtransaction $TX_ID 1)

WITNESS=$(echo $RAW_TX | jq -r .vin[0].txinwitness[2])
PUBKEY=$(echo $WITNESS | cut -c 5-70)

echo $PUBKEY