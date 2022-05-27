##########################################################
# config
##########################################################

# binaries
export OPEN=nautilus

##########################################################
# main
##########################################################

update() {
    case $1 in
    d) sudo apt-get dselect-upgrade ;;
    *) sudo apt-get dist-upgrade ;;
    esac
}

clean() {
    case $1 in
    bd)
        rm -rfv $(brew --cache)/downloads/*
        rm -rfv $(brew --cache)/Cask/*
        rm -rfv $(brew --cache)/*[0-9]*
        ;;
    cc)
        sudo rm -rfv /var/cache
        ;;
    zs)
        rm $HOME/.zsh_sessions/*.history*
        rm $HOME/.zsh_sessions/*_timestamp
        ;;
    log)
        echo "Emptying the system log files.\n"
        sudo rm -rfv /var/log/*
        ;;
    *)
        echo "Emptying trash.\n"
        rm -rfv $HOME/.local/share/Trash >/dev/null 2>&1
        ;;
    esac
}

sysinfo() {
    sysctl -a | rg $1
}

##########################################################
# apt-get
##########################################################

alias ah="apt-get help"
alias asc="apt-cache search"
alias aif="apt-cache show"
alias adp="apt-cache depends"
alias ardp="apt-cache rdepends"
alias als="apt-get list --installed"

alias ais="sudo apt-get install"
alias aus="sudo apt-get remove"
alias ausp="sudo apt-get remove --purge"
alias aups="sudo apt-get update"
alias aup="sudo apt-get upgrade"
alias acl="sudo apt-get autoremove && sudo apt-get clean && sudo apt-get autoclean"
alias aclp="sudo apt-get autoremove --purge && sudo apt-get clean && sudo apt-get autoclean"
alias ack="sudo apt-get check"

##########################################################
# wsl
##########################################################

# use host proxy
wlpx() {
    host_ip=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
    export ALL_PROXY="https://$host_ip:${Proxy[$1]}"
}
