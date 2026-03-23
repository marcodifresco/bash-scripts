#!/bin/bash

# Define the path to one of the critical tracking files.
# We get this exact path from your error log.
LISTING_FILE="$HOME/.cache/rclone/bisync/home_marco_Documents..gdrive_.path1.lst"

# Define the common rclone arguments
RCLONE_ARGS=(
  "/home/marco/Documents"
  "gdrive:"
  "--exclude" ".git/**"
  "--exclude" ".stfolder/**"
  "--exclude" "EVE/logs/**" # <-- THE CORRECTED LINE
  "--exclude" "The Lord of the Rings Online"
  "--drive-import-formats" "docx,xlsx,pptx"
  "--drive-export-formats" "docx,xlsx,pptx"
  "--track-renames"
  "--verbose"
  "--log-file=$HOME/.local/state/rclone-bisync.log"
)

# Check if the tracking file exists
if [ -f "$LISTING_FILE" ]; then
  # File exists, run a normal sync
  echo "Tracking file found. Running normal bisync." >>"$HOME/.local/state/rclone-bisync.log"
  /usr/bin/rclone bisync "${RCLONE_ARGS[@]}"
else
  # File is missing, run a recovery --resync
  echo "Tracking file NOT found. Running recovery bisync with --resync." >>"$HOME/.local/state/rclone-bisync.log"
  /usr/bin/rclone bisync "${RCLONE_ARGS[@]}" --resync
fi
