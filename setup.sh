#!/bin/bash

# create list of files to move

FILES=('.zshrc' '.tmux.conf' '.vimrc')
dots=$HOME/dotfiles
olddots=$HOME/dotfiles/old

# make sure we're in right area and create dotfiles/old/
cd dots
if ! [ -e $olddots/ ]; then
  echo Making old file directory
  mkdir $olddots/
  echo ...done
fi

# functions
create_symlink () {
  ln -s $dots/$file $HOME/$file
}
for file in $FILES; do
  if [ -e "$HOME/$file" ] && ! [ -L "$HOME/$file" ] ; then
    echo Moving old ${file}...
    # move old files into d/o/
    mv $HOME/$file $olddots/
    # symlink into $HOME
    echo ...done\nCreating symlink
    create_symlink
    echo ...done
  elif ! [ -e "$HOME/$file" ] ; then
    echo ~/${file} has not been created,\nCreating symlink.
    create_symlink
    echo ...done
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
if [ -e "$HOME/oh-my-zsh" ]; then
  echo You already have Oh My Zsh installed.
else
  echo Installing Oh My Zsh...
  sh -c "$(curl -ffSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo ...done
fi
