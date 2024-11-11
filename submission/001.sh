# What is the hash of block 654,321?
block_hash=$(bitcoin-cli getblockhash 654321)
echo $block_hash