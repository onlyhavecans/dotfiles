#!/bin/bash

TOKEN="apikey"        # The API v2 OAuth token
ACCOUNT_ID="00000"    # Replace with your account ID
ZONE_ID="example.com" # The zone ID is the name of the zone (or domain)
RECORD_ID="000000"    # Replace with the Record ID
IP=$(curl -4 -s http://icanhazip.com/)

# shellcheck disable=SC1090
source "$HOME/.config/ddns.conf"

curl -H "Authorization: Bearer $TOKEN" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -X "PATCH" \
     -i "https://api.dnsimple.com/v2/$ACCOUNT_ID/zones/$ZONE_ID/records/$RECORD_ID" \
     -d "{\"content\":\"$IP\"}"
