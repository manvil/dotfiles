#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [ -f ~/.vim ]; then mv ~/.vim ~/.vim_backup; fi; ln -s $DIR/vim/.vim/ ~/.vim
if [ -f ~/.vimrc ]; then mv ~/.vimrc ~/.vimrc_backup; fi; ln -s $DIR/vim/.vimrc ~/.vimrc
if [ -f ~/.zshrc ]; then mv ~/.zshrc ~/.zshrc_backup; fi; ln -s $DIR/zsh/.zshrc ~/.zshrc
if [ -f ~/.oh-my-zsh/custom ] ; then rm -rf ~/.oh-my-zsh/custom; fi; ln -s $DIR/zsh/custom/ ~/.oh-my-zsh/custom
if [ -f ~/.irbrc ]; then mv ~/.irbrc ~/.irbrc_backup; fi; ln -s $DIR/irb/.irbrc ~/.irbrc
if [ -f ~/.tigrc ]; then mv ~/.trigrc ~/.tigrc_backup; fi; ln -s $DIR/tig/.tigrc/ ~/.tigrc
echo 1
