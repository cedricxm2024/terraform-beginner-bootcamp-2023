#!/usr/bin/env bash

set -e

# Script to add an alias to shell configuration safely
# Usage: ./set_tf_alias.sh alias_name='command'
# Example: ./set_tf_alias.sh tf='terraform'

# Exit if no argument provided
if [ -z "$1" ]; then
  echo "Usage: $0 alias_name='command'"
  exit 1
fi

ALIAS_LINE="alias $1"

# Determine which shell config file to use
if [ -n "$ZSH_VERSION" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -n "$BASH_VERSION" ]; then
  SHELL_RC="$HOME/.bashrc"
else
  SHELL_RC="$HOME/.profile"
fi

# Create shell config file if it doesn't exist
touch "$SHELL_RC"

# Check if alias already exists
if grep -Fxq "$ALIAS_LINE" "$SHELL_RC"; then
  echo "Alias already exists in $SHELL_RC: $ALIAS_LINE"
else
  echo "$ALIAS_LINE" >> "$SHELL_RC"
  echo "Alias added to $SHELL_RC: $ALIAS_LINE"
fi

# Only source if running interactively
if [ -t 0 ]; then
  source "$SHELL_RC" 2>/dev/null || true
  echo "Alias applied. You can now use: $1"
else
  echo "Alias will be available in new shell sessions."
fi
