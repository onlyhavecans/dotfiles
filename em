#!/usr/bin/env sh

SUBJECT="$*"
BODY="$*"

printf "Subject: [emailme] %s\n%s" "$SUBJECT" "$BODY" | msmtp -- default
