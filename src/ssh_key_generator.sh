#!/bin/bash

# Function to generate an SSH key
generate_ssh_key() {
  ssh-keygen -t rsa -b 4096 -C "$1" -f "$2" -q -N ""
}

# Function to copy the SSH key to the clipboard
copy_to_clipboard() {
  if command -v pbcopy >/dev/null 2>&1; then
    cat "$1" | pbcopy
  elif command -v xclip >/dev/null 2>&1; then
    cat "$1" | xclip -selection clipboard
  elif command -v clip.exe >/dev/null 2>&1; then
    cat "$1" | clip.exe
  else
    echo "Clipboard not supported. The SSH key is stored in the file: $1"
  fi
}

# Prompt for the email address
read -p "Enter your email address: " email

# Generate the SSH key with the email address as a comment
ssh_key_file="/tmp/id_rsa"
generate_ssh_key "$email" "$ssh_key_file"

# Copy the SSH key to the clipboard
copy_to_clipboard "$ssh_key_file.pub"

echo "A newly generated SSH key has been copied to the clipboard."
