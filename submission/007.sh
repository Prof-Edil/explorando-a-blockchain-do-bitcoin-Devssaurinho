# Only one single output remains unspent from block 123,321. What address was it sent to?
BLOCK_HASH=$(bitcoin-cli getblockhash 123321)
TX_IDS=$(bitcoin-cli getblock $BLOCK_HASH | jq -r .tx[])

for TX_ID in $TX_IDS; do
    RAW_TX=$(bitcoin-cli getrawtransaction "$TX_ID" 1 | jq -c .)
    OUTPUTS_LIST=$(echo "$RAW_TX" | jq -c .vout[])

    for OUTPUT in $OUTPUTS_LIST; do
        VOUT_INDEX=$(echo $OUTPUT | jq -r .n)
        UNSPENT_OUTPUT=$(bitcoin-cli gettxout $TX_ID $VOUT_INDEX)

        if [[ $UNSPENT_OUTPUT ]]; then
            RECEIVER_ADDRESS=$(echo $UNSPENT_OUTPUT | jq -r .scriptPubKey.address)
            echo $RECEIVER_ADDRESS
        fi
    done
done
