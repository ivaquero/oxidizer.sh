##########################################################
# config
##########################################################

# binaries
export OPEN=open

if [[ $(uname -m) == "arm64" ]]; then
    export TERMINFO=/usr/share/terminfo
else
    export TERMINFO=/usr/local/share/terminfo
fi

##########################################################
# main
##########################################################

export CACHES=$HOME/Library/Caches

update() {
    echo "Installing needed updates.\n"
    softwareupdate -i -a >/dev/null 2>&1
}

clean() {
    case $1 in
    bdl)
        echo "Cleaning up Homebrew Downloads.\n"
        rm -rfv $(brew --cache)/downloads/*
        rm -rfv $(brew --cache)/Cask/*
        rm -rfv $(brew --cache)/"*\d+*"
        ;;
    vs)
        echo "Cleaning up VSCode Cache.\n"
        rm -rfv $HOME/Library/'Application Support'/Code/Cache/*
        ;;
    cr)
        echo "Cleaning up Chrome Cache.\n"
        rm -rfv $CACHES/Google/Chrome/*
        ;;
    zs)
        echo "Cleaning up ZSH history.\n"
        rm $HOME/.zsh_sessions/*.history*
        rm $HOME/.zsh_sessions/*_timestamp
        rm $HOME/.zsh_history
        ;;
    vol)
        echo "Emptying trash in Volumes.\n"
        sudo rm -rfv /Volumes/*/.Trashes
        ;;
    log)
        echo "Emptying the system log files.\n"
        sudo log erase
        ;;
    *)
        echo "Emptying trash.\n"
        rm -rfv $HOME/.Trash >/dev/null 2>&1
        ;;
    esac
}

allow() {
    sudo spctl --master-disable
    echo "Initial letter needs to be capitalized"

    for app in /Applications/$1*.app; do
        if [[ -z $app ]]; then
            echo "$app not found."
        else
            echo "Cracking $app"
            xattr -r -d com.apple.quarantine $app
        fi
    done
}

hide() {
    chflags hidden $1
}

shutdown() {
    if [[ -z $1 ]]; then
        echo "Shutting down.\n"
        sudo shutdown -h now
    else
        echo "Shutting down in $1 seconds.\n"
        sudo shutdown -h $1
    fi
}

restart() {
    if [[ -z $1 ]]; then
        echo "Restarting $1.\n"
        sudo shutdown -r now
    else
        echo "Restarting in $1 seconds.\n"
        sudo shutdown -r "+$1"
    fi
}

hybernate() {
    echo "Hybernating.\n"
    shutdown -s now
}

sysinfo() {
    sysctl -a | rg $1
}

##########################################################
# files
##########################################################

alias sha1="openssl dgst -sha1"
alias sha2="openssl dgst -sha256"

##########################################################
# mas
##########################################################

alias appis="mas install"
alias appus="sudo mas uninstall"
alias appud="mas upgrade"
alias apph="mas help"
alias appif="mas info"
alias appls="mas list"
alias appst="mas outdated"
alias appsc="mas search"
alias appsi="mas signin"
alias appso="mas signout"

##########################################################
# network
##########################################################

alias netq="networkQuality"

##########################################################
# time machine
##########################################################

alias tmh="tmutil -h"
alias tmea="sudo tmutil enable"
alias tmda="sudo tmutil disable"
alias tms="tmutil startbackup"
alias tmq="tmutil stopbackup"
alias tmls="tmutil listbackups"
alias tmrm="tmutil delete"
