#!/usr/bin/env bash
# Desktop notifications for Claude Code Stop + Notification hooks.
set -euo pipefail

input=$(cat)
event=$(jq -r '.hook_event_name // ""' <<<"$input")
project=$(basename "$(jq -r '.cwd // ""' <<<"$input")")
title="Claude Code${CLAUDE_JOB_DIR:+ (bg)}${project:+ · $project}"

case "$event" in
  Stop)
    # Turn ended but background tasks / crons will wake the session again:
    # nothing for the user to do yet.
    pending=$(jq -r '((.background_tasks // []) + (.session_crons // [])) | length' <<<"$input")
    [[ "$pending" != "0" ]] && exit 0
    body=$(jq -r '.last_assistant_message // "Task completed" | .[0:200]' <<<"$input")
    notify-send -a 'Claude Code' -u normal "$title" "$body"
    ;;
  Notification)
    body=$(jq -r '.message // "Awaiting your input"' <<<"$input")
    notify-send -a 'Claude Code' -u critical "$title" "$body"
    ;;
esac
