#!/bin/bash

set -euo pipefail

OS="$(uname -s)"
echo "Detected OS: $OS"

# Function to link a file or directory
link_item() {
  local source="$1"
  local target="$2"

  if [[ -e "$target" || -L "$target" ]]; then
    echo "Removing existing: $target"
    rm -rf "$target"
  fi

  echo "Linking $source -> $target"
  ln -sv "$source" "$target"
}

# Function to recursively link all contents of a directory
link_structure() {
  local source_dir="$1"
  local target_dir="$2"
  mkdir -p "$target_dir"
  shopt -s dotglob
  for item in "$source_dir"/*; do
    local name="$(basename "$item")"
    link_item "$item" "$target_dir/$name"
  done
  shopt -u dotglob
}

# Base path of this script
BASE_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Link individu0al files and directories preserving structure
link_structure "$BASE_DIR/Qt" "$HOME/Qt"
link_structure "$BASE_DIR/Libs" "$HOME/Libs"
link_structure "$BASE_DIR/Wallpaper" "$HOME/Wallpaper"
link_structure "$BASE_DIR/.config" "$HOME/.config"
link_structure "$BASE_DIR/.ssh" "$HOME/.ssh"
link_item "$BASE_DIR/.zshenv" "$HOME/.zshenv"
link_item "$BASE_DIR/.zprofile" "$HOME/.zprofile"

case "$(uname)" in
Linux)
  link_item "$BASE_DIR/.local/share/dbus-1" "$HOME/.local/share/dbus-1"

    echo "Running Linux-only root-level copies..."
    if [[ $EUID -ne 0 ]]; then
      echo "Root permissions required to copy icons/themes/restic. Re-run with sudo if needed."
    else
      cp -vr "$BASE_DIR/usr/share/icons/"* /usr/share/icons/
      cp -vr "$BASE_DIR/usr/share/themes/"* /usr/share/themes/
      cp -vr "$BASE_DIR/etc/restic/"* /etc/restic/
    fi
    ;;
Darwin)
    ;;
esac

