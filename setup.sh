#!/bin/bash

# make sure we're in right area and create dotfiles/old/
cd $HOME/dotfiles
if ! [ -e 'old/' ]; then
  mkdir old/
fi

# create list of files to move

FILES=('.zshrc' '.tmux.conf' '.vimrc')

# functions
create_symlink () {
  ln -s $HOME/dotfiles/$file $HOME/$file
}
for file in $FILES
do
  if [ -e "$HOME/$file" ] && ! [ -L "$HOME/$file" ] ; then
    echo \tmoving old ${file}...
    # move old files into d/o/
    mv $HOME/$file $HOME/dotfiles/old/
    # symlink into $HOME
		create_symlink
	elif ! [ -e "$HOME/$file" ] ; then
    echo \t~/${file} has not been created,\n\tcreating symlink.
		create_symlink
  fi	
done

# check for nvim
if ! type 'nvim' > /dev/null; then
  echo You do not have NeoVim installed.
  echo Check for installation details for your system.
fi
