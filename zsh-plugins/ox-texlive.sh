##########################################################
# config
##########################################################

if [[ $(uname -s) == "Darwin" ]]; then
    export texlive=/usr/local/texlive
fi

init_texlive() {
    echo "Initialize TeXLive using Oxidizer configuration"
    local num=$(cat $OXIDIZER/defaults/texlive.txt | wc -l | rg --only-matching "\d+")

    pueue group add texlive_init
    pueue parallel $num -g texlive_init

    cat $OXIDIZER/defaults/texlive.txt | while read line; do
        echo "Installing $line"
        pueue add -g texlive_init "tlmgr install $line"
    done
    sleep 3 && pueue status
}

up_texlive() {
    echo "Update TeXLive by self-defined configuration"
    local num=$(cat $BACKUP/install/texlive.txt | wc -l | rg --only-matching "\d+")

    pueue group add texlive_update
    pueue parallel $num -g texlive_update

    cat $BACKUP/install/texlive.txt | while read line; do
        echo "Installing $line"
        pueue add -g texlive_update "tlmgr install $line"
    done
    sleep 3 && pueue status
}

back_texlive() {
    echo "Backup TeXLive to $BACKUP/install"
    tlmgr list --only-installed | rg --only-matching "collection-\w+" | rg --invert-match "basic" >$BACKUP/install/texlive.txt
}

##########################################################
# packages
##########################################################

alias tlup="tlmgr update --all"
alias tlups="tlmgr update --all --self"
alias tlck="tlmgr check"
alias tlis="tlmgr install"
alias tlus="tlmgr remove && tlmgr check"
alias tllsa="tlmgr list"
alias tlls="tlmgr list --only-installed"
alias tlif="tlmgr info"
alias tlifc="tlmgr info collections"
alias tlifs="tlmgr info schemes"
alias tlh="tlmgr -h"
