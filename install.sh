#!/bin/bash

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo "This script requires git"
    exit 1
# Check if curl is installed (required by Vundle)
elif ! command -v curl &> /dev/null; then
    echo "This script requires curl"
    exit 1
fi

# Construct the path to the user's home
if [[ $EUID -ne 0 ]]; then
    home="$HOME"
else
    home="/root"
fi

# Vundle repo and destinaton
vundle_repo="https://github.com/VundleVim/Vundle.vim.git"
vundle_dest="$home/.vim/bundle/Vundle.vim"

# Absolute path of the current directory
cur_dir=$(echo $PWD)

# List dotfiles in the directory and copy them in the user's home
# Warn : Does NOT support folders atm, only files
dotfiles_list=$(find $cur_dir -maxdepth 1 -type f ! -iname "*.sh"  ! -iname "\.*" -printf '%f\n')

for dotfile_name in ${dotfiles_list[@]}; do
    # Backup the original dotfile if it exists
    if [ -f $home/.$dotfile_name ]; then
        echo "The file $dotfile_name already exists, backing up"
        mv $home/.$dotfile_name $home/$dotfile_name.bckp
    fi

    # Copy dotfile to the user's home
    echo "Copying $dotfile_name to $home/.$dotfile_name"
    cp $cur_dir/$dotfile_name $home/.$dotfile_name

done

# Backup the .vim folder if it already exists
if [ -d $home/.vim ]; then
    echo "Vim folder already exists, backing up"
    mv $home/.vim $home/vim-bckp
fi

echo "Creating a fresh vim folder"
# Creates any parent directory if necessary
mkdir -p $home/.vim/bundle

echo "Cloning Vundle in $vundle_dest"
git clone --quiet $vundle_repo $vundle_dest

echo "All done"
echo "Launch Vim and run ':PluginInstall' to install the plugins"
