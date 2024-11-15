# Which tx in block 257,343 spends the coinbase output of block 256,128?
BLOCK_HASH_1=$(bitcoin-cli getblockhash 256128)
TXID_1=$(bitcoin-cli getblock $BLOCK_HASH_1 | jq -r .tx[0])
VOUT_1=0

BLOCK_HASH_2=$(bitcoin-cli getblockhash 257343)
TX_LIST=$(bitcoin-cli getblock $BLOCK_HASH_2 | jq -r .tx[])

for TX in $TX_LIST
do
    readarray -t INPUTS < <(bitcoin-cli getrawtransaction $TX 1 | jq -c .vin[])
    
    for INPUT in "${INPUTS[@]}"
    do
        PREVOUT_TXID=$(echo "$INPUT" | jq -r .txid)
        PREVOUT_VOUT=$(echo "$INPUT" | jq -r .vout)
        if [[ $TXID_1 == $PREVOUT_TXID && $VOUT_1 == $PREVOUT_VOUT ]]
        then
            echo $TX
            exit 0
        fi
    done
done