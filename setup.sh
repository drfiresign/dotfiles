#!/bin/bash

# create list of files to move

FILES=".zshrc .tmux.conf .vimrc"
dots=$HOME/dotfiles
olddots=$HOME/dotfiles/old

# make sure we're in right area and create dotfiles/old/
cd $dots
if ! [ -e $olddots/ ]; then
  echo Making old file directory
  mkdir $olddots/
  echo ...done
fi

for file in $FILES; do
  if [ -e "$HOME/$file" ] && ! [ -L "$HOME/$file" ] ; then
    echo Moving old ${file}...
    # move old files into d/o/
    mv $HOME/$file $olddots/
    # symlink into $HOME
    echo ...done\nCreating symlink
    ln -s $dots/$file $HOME/$file
    echo ...done
  elif ! [ -e "$HOME/$file" ] ; then
    echo ~/${file} has not been created,\nCreating symlink.
    ln -s $dots/$file $HOME/$file
    echo ...done
  else
    echo You\'ve already run this script.
  fi
done

# check for nvim
if ! type 'nvim' >> /dev/null; then
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

# check for pyenv (this manages python installations)
# check https://github.com/pyenv/pyenv for more information
# if ! type 'pyenv' >> /dev/null; then
#   echo pyenv not installed.
#   curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv/installer | bash
#   echo ...done
# else
#   echo You already have pyenv installed.
# fi
