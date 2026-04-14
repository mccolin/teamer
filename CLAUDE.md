# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a macOS-only shell script repository with two utilities:

- **teamer.sh** — Keeps Microsoft Teams active by periodically bringing it to the foreground and simulating a keystroke (`Cmd+2`), using random intervals (33–42s) to mimic natural user activity. Uses `caffeinate` to prevent sleep.
- **keeper.sh** — A simpler wrapper around `caffeinate` that prevents sleep and prints status every 30 seconds until Ctrl-C.

Both scripts spawn `caffeinate -s -w $$` in the background (tied to the script's PID) and use a `SIGINT` trap for clean shutdown.

## Running

```sh
./teamer.sh   # Teams keepalive
./keeper.sh   # Generic keepalive
```

Both require macOS (depend on `osascript`, `caffeinate`) and executable permissions (`chmod +x`).

## Key Implementation Details

- `teamer.sh` uses `osascript` to activate Teams and send `Cmd+2` (switches to Chat tab, keeping Teams "active")
- Random interval: `$((10#${RANDOM:1:2} + 33))` — takes digits 1–2 of `$RANDOM`, interprets as base-10, adds 33 for a range of ~33–42 seconds
- No external dependencies beyond standard macOS tools
