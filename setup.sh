#!/bin/bash
set -e
main() {
    # (maybe_create_directies);
    # (git_clone_repo);
    # (install_git_alias);
    (maybe_config_bashrc);
}

maybe_create_directies () {
    mkdir -p $HOME/d/working
    mkdir -p $HOME/.emacs.d
    mkdir -p $HOME/tmp/
}

git_clone_repo() {
    cd $HOME/d/working;
    [ -d wcy_dot_emacs ] || git clone https://github.com/wcy123/wcy_dot_emacs.git
    [ -d leader-key-mode ] || git clone https://github.com/wcy123/leader-key-mode.git
    ln -sf $HOME/d/working/wcy_dot_emacs/dot.emacs $HOME/.emacs
}

install_git_alias() {
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
}


maybe_config_bashrc() {
    bashrc_config="
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTCONTROL=ignoreboth:ignoredups:erasedup
PROMPT_COMMAND='history -a;history -c;history -r'
[ -f \$HOME/.fzf.bash ] && source \$HOME/.fzf.bash
export PS1='% '
export LESS=XR
alias g=git
"
    old_bash_config_md5sum=`cat ~/.bashrc | awk ' />>> wcy/ {d = 1;next;}  /<<< wcy/{d=0;next}  d== 1 {print}' | md5sum`
    this_bashrc_config_md5sum=`echo "$bashrc_config" | md5sum`
    if [ x"$old_bash_config_md5sum" == x"$this_bashrc_config_md5sum" ]; then
        return;
    fi
    empty_md5sum='d41d8cd98f00b204e9800998ecf8427e  -';
    if [ x"$old_bash_config_md5sum" == x"$empty_md5sum" ]; then
        (
            echo "# >>> wcy bashrc settings"
            echo "$bashrc_config"
            echo "# <<< wcy bashrc settings"
        ) >> $HOME/.bashrc
    else
        begin=$(cat ~/.bashrc  | awk 'd==0 {print} />>> wcy/ {exit;}')
        after=$(cat ~/.bashrc  | awk '/<<< wcy/{d=1;} d==1 {print}')
        (
            echo "$begin"
            echo "$bashrc_config"
            echo "$after"
        ) > $HOME/.bashrc
    fi
}


main;
