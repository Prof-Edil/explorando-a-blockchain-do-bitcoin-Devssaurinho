# How many new outputs were created by block 123,456?

BLOCK_HASH=$(bitcoin-cli getblockhash 123456)
TRANSACTION_IDS=$(bitcoin-cli getblock $BLOCK_HASH | jq -r '.tx[]')

TOTAL_OUTPUTS=0

for TRANSACTION_ID in $TRANSACTION_IDS; do
    RAW_TRANSACTION=$(bitcoin-cli getrawtransaction $TRANSACTION_ID)
    OUTPUT_COUNT=$(bitcoin-cli decoderawtransaction $RAW_TRANSACTION | jq '.vout | length')
    TOTAL_OUTPUTS=$((TOTAL_OUTPUTS + OUTPUT_COUNT))
done

echo $TOTAL_OUTPUTS
