# Dotfiles

## Summary

This folder is used to store the dotfiles (e.g., .vimrc) which keep my user environment synced
across different computers. Some of the systems may have different settings they need to use, but
I've found in general that I can sync these up across MacOS and Linux distros. 

Currently only set up for tmux, vim (neovim is checked for as well) and zsh (checking for oh-my-zsh).

Use the setup.sh file to check for any pre-existing dotfiles and move them into a new dotfiles/old
folder for storage. Symlink the included config files into the home directory.

## Problems

None, because I just solved the problem with neovim not reading my vimrc file!

### If using Neovim

You need to create ~/.config/nvim/init.vim with these contents:

```
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
```

This file will allow you to use the vimrc file inside of Neovim.

## TODO

Incorporate the three lines above along with the file creation inside the setup.sh file.
