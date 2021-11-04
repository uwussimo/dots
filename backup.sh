#!/bin/bash
cd "$( dirname "$0" )" || exit

# Find out script path
SCRIPT_PATH="`dirname \"$0\"`"
SCRIPT_PATH="`( cd \"$SCRIPT_PATH\" && pwd )`"

# Stop the program if path of script not found
if [ -z "$SCRIPT_PATH" ] ; then
  echo "Script path not found!"
  exit 1
fi

# Files to copy
files=(
    ".zshrc"
    ".vimrc"
    ".zprofile"
    ".vimrc.bundles"
    ".vimrc.bundles.local"
    ".gitconfig"
)

# Folder to copy and zip
# folders=(
#     ".oh-my-zsh"
#     ".vim/colors"
# )

# Destination to copy files to
destination="$SCRIPT_PATH/data"

echo "Backing up all dotfiles!"

# Copying the files to the destination
for i in "${files[@]}"; do
    echo "Backing up $i"
    cp "$HOME/$i" "$destination/files"
done

# Copying the folders to the destination
# for i in "${folders[@]}"; do
#     echo "Backing up $i"
#     zip -r "$destination/folders/$i.zip" "$HOME/$i"
# done

# Completed!
echo "Backing up completed..."

# Ask user if he wants to push the backup to the git repo
read -p "Do you want to push the backup to the git repo? [y/n] " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Pushing backup to git repo..."
    cd "$destination" || exit
    git add .
    git commit -m "Backup $(date)"
    git push
    echo "Pushing backup to git repo completed!"
fi
