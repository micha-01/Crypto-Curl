#!/bin/sh

API="https://api.kraken.com/0/public/Ticker"

if [ "$1" = "bitcoin" ]; then
    CURRENCY="BTC"
    second="BTZ"
    FILE=$HOME/.scripts/crypto/history_BTC.txt
elif [ "$1" = "monero" ]; then
    CURRENCY="XMR"
    second="MRZ"
    FILE=$HOME/.scripts/crypto/history_XMR.txt
else
    echo "Something went wrong "
    exit 1
fi

quote=$(curl -sf $API?pair=${CURRENCY}EUR | jq -r ".result.XX${second}EUR.c[0]")
quote=$(LANG=C printf "%.2f" "$quote")

DATE=$(date)
NUMBER=$(cat $FILE | wc -l) 

if [ "$NUMBER" = "0" ]; then
    echo "$CURRENCY,$quote,$DATE,$quote" >> $FILE
    echo "$quote€"
else
    LAST_LINE=$(sed "$NUMBER q;d" $FILE)
    IFS=','
    LAST=( $LAST_LINE )
    LAST_AVG=${LAST[3]}
    SUM=$(echo "${LAST[3]} * $NUMBER + $quote" | bc)
    AVG=$(echo "$SUM / ($NUMBER + 1)" | bc)
    echo "$CURRENCY,$quote,$DATE,$AVG" >> $FILE
    if (( $(echo "$AVG > $LAST_AVG" | bc -l) )); then
        echo "%{F#1dd05d}%{F-} $quote€"
    else
	    echo "%{F#FF004B}%{F-} $quote€"
    fi
fi
