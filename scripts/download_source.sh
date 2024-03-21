# Download Spider zip into ./source

DOC_ID="1TqleXec_OykOYFREKKtschzY29dUcVAQ"

wget \
    --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$( \
        wget --quiet \
            --save-cookies /tmp/cookies.txt \
            --keep-session-cookies \
            --no-check-certificate 'https://docs.google.com/uc?export=download&id=$DOC_ID' -O- | \
        sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p' \
    )&id=$DOC_ID" \
    -O ./source/spider.zip

rm -rf /tmp/cookies.txt
