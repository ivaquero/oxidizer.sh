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

alias ubh="apt-get help"
alias ubsc="apt-cache search"
alias ubif="apt-cache show"
alias ubdp="apt-cache depends"
alias ubrdp="apt-cache rdepends"
alias ubls="apt-get list --installed"

alias ubis="sudo apt-get install"
alias ubus="sudo apt-get remove"
alias ubusp="sudo apt-get remove --purge"
alias ubups="sudo apt-get update"
alias ubup="sudo apt-get upgrade"
alias ubcl="sudo apt-get autoremove && sudo apt-get clean && sudo apt-get autoclean"
alias ubclp="sudo apt-get autoremove --purge && sudo apt-get clean && sudo apt-get autoclean"
alias ubck="sudo apt-get check"

##########################################################
# wsl
##########################################################

# use host proxy
wlpx() {
    host_ip=$(cat /etc/resolv.conf | grep "nameserver" | cut -f 2 -d " ")
    export ALL_PROXY="https://$host_ip:${Proxy[$1]}"
}
