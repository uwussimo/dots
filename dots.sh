source ./scripts/backup.sh

# Ask user if he wants to backup his dotfiles or restore them
echo "Do you want to backup your dotfiles or restore them?"
echo "(1) Backup"
echo "(2) Restore"
read -p "Enter your choice: " choice

# Regarding to choice, call the corresponding function
if [ $choice -eq 1 ]; then
    backup
elif [ $choice -eq 2 ]; then
    restore
else
    echo "Invalid choice"
fi