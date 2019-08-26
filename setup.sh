#!/bin/bash
set -e
## install my customized dev enviroment
cd $HOME
mkdir -p $HOME/d/working
cd $HOME/d/working
[ -d wcy_dot_emacs ] || git clone https://github.com/wcy123/wcy_dot_emacs.git
[ -d leader-key-mode ] || git clone https://github.com/wcy123/leader-key-mode.git
ln -sf $HOME/d/working/wcy_dot_emacs/dot.emacs $HOME/.emacs
mkdir -p $HOME/.emacs.d
mkdir -p $HOME/tmp/

## setup alias
if [ ! -d $HOME/alias ]; then
    (
        echo 'alias g=git'
        echo 'export LESS=XR'
    ) > $HOME/alias
fi

## setup git alias
git config --global alias.ll 'log --graph --decorate --full-diff'
git config --global alias.d 'diff --ignore-space-at-eol --ignore-all-space --ignore-space-change'
git config --global alias.la 'log --graph --decorate --all'
git config --global alias.s 'status'
git config --global alias.a 'add -A -p'
git config --global alias.rvs 'remote -v show'
git config --global alias.p 'pull --rebase'
git config --global alias.m 'merge --ff-only'
git config --global alias.f 'fetch --all --prune'
git config --global alias.c 'commit --verbose'
git config --global push.default simple
