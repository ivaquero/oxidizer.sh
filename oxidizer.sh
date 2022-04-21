if [[ -z $OXIDIZER ]]; then
    export OXIDIZER=$HOME/oxidizer
fi

##########################################################
# Oxidizer configuration files
##########################################################

declare -A Oxygen
Oxygen[oxz]=$OXIDIZER/oxidizer.sh
Oxygen[oxox]=$OXIDIZER/demo-custom.sh
Oxygen[oxal]=$OXIDIZER/defaults/alacritty.yml
Oxygen[oxar]=$OXIDIZER/defaults/aria2.conf
Oxygen[oxvi]=$OXIDIZER/defaults/.vimrc
# plugins
Oxygen[oxpm]=$OXIDIZER/zsh-plugins/ox-macos.sh
Oxygen[oxpub]=$OXIDIZER/zsh-plugins/ox-ubuntu.sh
Oxygen[oxpb]=$OXIDIZER/zsh-plugins/ox-brew.sh
Oxygen[oxpc]=$OXIDIZER/zsh-plugins/ox-conda.sh
Oxygen[oxpcc]=$OXIDIZER/zsh-plugins/ox-cpp.sh
Oxygen[oxpdk]=$OXIDIZER/zsh-plugins/ox-docker.sh
Oxygen[oxpfm]=$OXIDIZER/zsh-plugins/ox-formats.sh
Oxygen[oxpg]=$OXIDIZER/zsh-plugins/ox-git.sh
Oxygen[oxphx]=$OXIDIZER/zsh-plugins/ox-helix.sh
Oxygen[oxpjl]=$OXIDIZER/zsh-plugins/ox-julia.sh
Oxygen[oxplm]=$OXIDIZER/zsh-plugins/ox-lima.sh
Oxygen[oxpnj]=$OXIDIZER/zsh-plugins/ox-node.sh
Oxygen[oxpnv]=$OXIDIZER/zsh-plugins/ox-neovim.sh
Oxygen[oxppu]=$OXIDIZER/zsh-plugins/ox-pueue.sh
Oxygen[oxprs]=$OXIDIZER/zsh-plugins/ox-rust.sh
Oxygen[oxptl]=$OXIDIZER/zsh-plugins/ox-texlive.sh
Oxygen[oxput]=$OXIDIZER/zsh-plugins/ox-utils.sh
Oxygen[oxpvs]=$OXIDIZER/zsh-plugins/ox-vscode.sh
Oxygen[oxpwt]=$OXIDIZER/zsh-plugins/ox-widgets.sh
Oxygen[oxpzj]=$OXIDIZER/zsh-plugins/ox-zellij.sh

##########################################################
# System configuration files
##########################################################

declare -A Element
Element[ox]=$OXIDIZER/custom.sh
Element[al]=$HOME/.config/alacritty/alacritty.yml
Element[ar]=$HOME/.aria2/aria2.conf
Element[vi]=$HOME/.vimrc
Element[zs]=$HOME/.zshrc
Element[bs]=$HOME/.bash_profile

. ${Element[ox]}

declare -A Oxide

if [[ ! -d $BACKUP/shell ]]; then
    mkdir -p $BACKUP/shell
fi

Oxide[bkzs]=$BACKUP/shell/.zshrc
Oxide[bkbs]=$BACKUP/shell/.bash_profile
Oxide[bkox]=$BACKUP/shell/custom.sh
Oxide[bkal]=$BACKUP/alacritty.yml
Oxide[bkar]=$BACKUP/aria2.conf
Oxide[bkvi]=$BACKUP/.vimrc

##########################################################
# Aliases
##########################################################

alias ls="lsd"
alias ll="ls -l"
alias la="ls -a"
alias lla="ls -la"
alias lt="ls --tree"
alias cat="bat"
alias man="tldr"
alias z.="z .."
alias z..="z ../.."
alias zz="z -"

##########################################################
# Zsh & Plugins
##########################################################

declare -a PLUGINS

# import ox-brew
. ${Oxygen[oxpb]}
# import ox-utils
. ${Oxygen[oxput]}
# import ox-pueue
. ${Oxygen[oxppu]}

case $(uname -a) in
*Darwin*)
    . ${Oxygen[oxpm]}
    ;;
*Ubuntu* | *WSL*)
    . ${Oxygen[oxpub]}
    ;;
esac

for plugin in ${PLUGINS[@]}; do
    . ${Oxygen[$plugin]}
done

if [[ ! -d $BACKUP/install ]]; then
    mkdir -p $BACKUP/install
fi

if [[ ! -d $BACKUP/apps ]]; then
    mkdir -p $BACKUP/apps
fi

##########################################################
#  Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
init_all() {
    for obj in $INIT_OBJ[@]; do
        eval init_$obj
    done
}

# update all packages
up_all() {
    for obj in $UP_OBJ[@]; do
        eval up_$obj
    done
}

# backup package lists
back_all() {
    for obj in $BACK_OBJ[@]; do
        eval back_$obj
    done
}

# export configurations
epall() {
    for obj in $EPF_OBJ[@]; do
        epf $obj
    done
}

# import configurations
ipall() {
    for obj in $IPF_OBJ[@]; do
        ipf $obj
    done
}

# initialize Oxidizer
iiox() {
    for obj in $IIF_OBJ[@]; do
        iif $obj
    done
}

# update Oxidizer
upox() {
    z $OXIDIZER
    git fetch origin master
    git reset --hard origin/master
    z -
}

if [[ $STARTUP ]]; then
    case $SHELL in
    *zsh)
        eval "$(starship init zsh)"
        eval "$(zoxide init zsh)"
        ;;
    *bash)
        eval "$(starship init bash)"
        eval "$(zoxide init bash)"
        ;;
    esac
    startup
fi
