#!/bin/bash
# Keeper - Adapted from teamer script, this script prevents the computer from
# sleeping until it is closed, printing out periodic status updates every few
# seconds.

echo "$(date) Starting Keeper keep-alive script with pid=$$, Ctrl-C to stop."

caffeinate -s -w $$ &

function signal_handler() 
{
  echo
  echo "Stopping keeper and releasing the keep-alive process."
  exit 0
}

trap 'signal_handler' SIGINT

interval=30

while true;
do
  echo "$(date) Keep-alive still active; Sleeping for ${interval} seconds"
  sleep ${interval}
done

