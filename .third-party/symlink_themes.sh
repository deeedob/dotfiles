#!/bin/bash

# Function to symlink files
symlink_files() {
  local source_dir=$1
  local target_dir=$2
  # Create target directory if it doesn't exist
  mkdir -p "$target_dir"

  # Symlink all files in source directory to target directory
  for file in "$source_dir"/*; do
    ln -svf "$file" "$target_dir"
  done
}

# Directory containing the themes
themes_dir="$HOME/Dotfiles/.third-party"

# Directory for icons and themes in the user's home directory
icons_dir="$HOME/.icons"
themes_home_dir="$HOME/.themes"

# Loop through directories in themes_dir
for theme_dir in "$themes_dir"/*Theme*; do
  if find $theme_dir -mindepth 1 -maxdepth 1 | read; then
    symlink_files "$theme_dir/icons" "$icons_dir"
    symlink_files "$theme_dir/themes" "$themes_home_dir"
  else
    echo "Theme Submodules are empty!"
  fi
done
