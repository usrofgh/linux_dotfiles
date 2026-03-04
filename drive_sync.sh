#!/bin/bash

LOCAL="$HOME/Gdrive"
REMOTE="gdrive:ObsidianVault"

while inotifywait -r -e modify, create, delete, move '$LOCAL'; do
	rclone sync "$LOCAL" "$REMOTE" --fast-list --transfers 8 --checkers 16
done
