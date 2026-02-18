#!/bin/bash
# Check if session 'base' exists. If not, create it detached.
if ! tmux has-session -t main 2>/dev/null; then
  tmux new-session -d -s main
fi
