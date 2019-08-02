#!/bin/bash
set -e
## install my customized dev enviroment
cd $HOME
mkdir -p $HOME/d/working
cd $HOME/d/working
[ -d wcy_dot_emacs ] || git clone https://github.com/wcy123/wcy_dot_emacs.git
[ -d leader-key-mode ] ||  clone https://github.com/wcy123/leader-key-mode.git
ln -sf $HOME/d/working/wcy_dot_emacs/dot.emacs $HOME/.emacs
mkdir -p $HOME/.emacs.d
