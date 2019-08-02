#!/bin/bash

## install my customized dev enviroment
cd $HOME
mkdir -p $HOME/d/working
cd $HOME/d/working
git clone https://github.com/wcy123/wcy_dot_emacs.git
git clone https://github.com/wcy123/leader-key-mode.git
ln -sf $HOME/d/working/wcy_dot_emacs/dot.emacs $HOME/.emacs
mkdir -p $HOME/.emacs.d
