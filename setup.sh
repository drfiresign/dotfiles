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
    echo Moving old ${file}...
    # move old files into d/o/
    mv $HOME/$file $HOME/dotfiles/old/
    # symlink into $HOME
    create_symlink
  elif ! [ -e "$HOME/$file" ] ; then
    echo ~/${file} has not been created,\nCreating symlink.
    create_symlink
  else
    echo You\'ve already run this script.
  fi
done

# check for nvim
if ! type 'nvim' > /dev/null; then
  echo NeoVim not installed.
  echo Check your system\'s installation details.
else
  echo NeoVim installed.
fi

# check of oh-my-zsh/
if ! [ -e "oh-my-zsh/" ]; then
  echo Installing Oh My Zsh...
  sh -c "$(curl -ffSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  continue
  echo Oh My Zsh installed.
else
  echo You already have Oh My Zsh installed.
fi
