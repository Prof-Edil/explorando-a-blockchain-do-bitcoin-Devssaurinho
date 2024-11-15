# Only one single output remains unspent from block 123,321. What address was it sent to?
BLOCK_HASH=$(bitcoin-cli getblockhash 123321)
readarray -t GET_TRANSACTIONS < <(bitcoin-cli getblock $BLOCK_HASH | jq -r .tx[])

for TX_ID in "${GET_TRANSACTIONS[@]}"
do  
    RAW_TX=$(bitcoin-cli getrawtransaction "$TX_ID" 1 | jq -c .)
    readarray -t GET_OUTPUTS < <(echo "$RAW_TX" | jq -c .vout[])

    for GET_OUTPUT in "${GET_OUTPUTS[@]}"
    do
        VOUT_INDEX=$(echo $GET_OUTPUT | jq -r .n)
        UNSPENT_OUTPUT=$(bitcoin-cli gettxout $TX_ID $VOUT_INDEX)

        if [[ $UNSPENT_OUTPUT ]]
        then
            GET_ADDRESS=$(echo $UNSPENT_OUTPUT | jq -r .scriptPubKey.address)
            echo $GET_ADDRESS
        fi
    done
done