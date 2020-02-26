#!/bin/bash
set -e
main() {
    (maybe_create_directies);
    (git_clone_repos);
    (install_git_alias);
    (maybe_config_bashrc);
    (maybe_config_tmux);
}
run () {
    info "$*"
    eval "$*"
}

info() {
    echo "info $*"
}

maybe_create_directies () {
    run mkdir -p $HOME/d/working
    run mkdir -p $HOME/.emacs.d
    run mkdir -p $HOME/tmp/
}

git_clone_repos() {
    git_clone_repo https://github.com/wcy123/wcy_dot_emacs.git wcy_dot_emacs
    git_clone_repo https://github.com/wcy123/leader-key-mode_emacs.git leader-key-mode
    run ln -sf $HOME/d/working/wcy_dot_emacs/dot.emacs $HOME/.emacs
}

git_clone_repo() {
    local url=$1;shift;
    local dir=$1;shift;
    cd $HOME/d/working;
    info "git cloning $url to $dir"
    if [ -d $dir ]; then
        info "d/working/$dir has already been cloned.";
    else
        run git clone $url $dir;
    fi
}

install_git_alias() {
    info installing git alias
    ## setup git alias
    git config --global color.ui auto
    git config --global alias.l 'log --graph --decorate --full-diff'
    git config --global alias.ll 'log --graph --decorate --full-diff --stat'
    git config --global alias.d 'diff --ignore-space-at-eol --ignore-all-space --ignore-space-change --color=always'
    git config --global alias.la 'log --graph --decorate --all'
    git config --global alias.s 'status --untracked-files'
    git config --global alias.a 'add -A -p'
    git config --global alias.rvs 'remote -v show'
    git config --global alias.p 'pull --rebase'
    git config --global alias.m 'merge --ff-only'
    git config --global alias.f 'fetch --all --prune'
    git config --global alias.c 'commit --verbose'
    git config --global push.default simple
}


maybe_config_bashrc() {

    bashrc_config=$(cat <<EOF
HISTSIZE=10000000
HISTFILESIZE=10000000
HISTCONTROL=ignoreboth:ignoredups:erasedup
PROMPT_COMMAND='history -a;history -c;history -r'
[ -f \$HOME/.fzf.bash ] && source \$HOME/.fzf.bash
[ -f \$HOME/.z.lua/z.lua ] && eval "\$(lua \$HOME/.z.lua/z.lua --init bash)" && alias zh='z -I -t .'
export PS1='% '
export PS1='\u@\h:\W% '
export LESS=XR
test -t 1 && stty -ixon # set it only for non-tty
alias gl='global --path-style=through --result=grep --color=always'
alias g=git
alias cd='cd -P'
function loop ()
{
    eval "\$@";
    while sleep 1; do
        eval "\$@";
    done
}
function title() {
  echo -ne "\033]0;"\$1"\007"
}

EOF
)
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

## copy
function maybe_config_tmux() {
echo
}
main;
