#!/bin/bash
# Teamer - A script to keep Microsoft Teams active on macOS
# Prevents Teams from going idle by periodically bringing it to the foreground
# and simulating a keystroke, with random wait intervals to mimic user activity.

echo "$(date) Starting Teamer keep-active script with pid=$$, Ctrl-C to stop."

caffeinate -s -w $$ &

let n=0

function signal_handler() 
{
  echo
  echo "Stopped after ${n} sleep preventions."
  exit 0
}

trap 'signal_handler' SIGINT

while true;
do
  let n++
  interval=$((10#${RANDOM:1:2} + 33))
  osascript -e 'tell application "Microsoft Teams" to activate'
  osascript -e 'tell application "System Events" to keystroke "2" using {command down}'
  echo "$(date) Teams status refreshed; Sleeping for ${interval} seconds (${n})"
  sleep ${interval}
done

