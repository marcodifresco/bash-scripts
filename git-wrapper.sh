#!/bin/sh

# Set the crucial environment variable to the correct path for the gpg-agent socket.
# This injects the correct context that the IDE's GUI process is missing.
export SSH_AUTH_SOCK="${XDG_RUNTIME_DIR}/gnupg/S.gpg-agent.ssh"

# Execute the real git command, passing along all the arguments we received ("$@").
exec /usr/bin/git "$@"
