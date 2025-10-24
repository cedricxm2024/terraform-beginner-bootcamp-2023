#!/usr/bin/env bash
# Script to add an alias to ~/.zshrc safely

# Usage: ./add_alias.sh alias_name='command'
# Example: ./add_alias.sh tf='terraform'

# Exit if no argument provided
if [ -z "$1" ]; then
  echo "Usage: $0 alias_name='command'"
  exit 1
fi

ALIAS_LINE="alias $1"
ZSHRC="$HOME/.zshrc"

# Check if alias already exists
if grep -Fxq "$ALIAS_LINE" "$ZSHRC"; then
  echo "Alias already exists in $ZSHRC: $ALIAS_LINE"
else
  echo "$ALIAS_LINE" >> "$ZSHRC"
  echo "Alias added to $ZSHRC: $ALIAS_LINE"
fi

# Reload .zshrc to apply the alias
source "$ZSHRC"
echo "Alias applied. You can now use: $1"
