##########################################################
# config
##########################################################

init_node() {
    echo "Initialize Node using Oxidizer configuration"
    local pkgs=$(cat $OXIDIZER/defaults/node.txt | sd "\n" " ")
    echo "Installing $pkgs"
    eval "npm install -g $pkgs --force"
}

up_node() {
    echo "Update Node by self-defined configuration"
    local pkgs=$(cat $BACKUP/install/node.txt | sd "\n" " ")
    echo "Installing $pkgs"
    eval "npm install -g $pkgs --force"
}

back_node() {
    echo "Backup Node to $BACKUP/install"
    npm list --depth 0 -g | rg --multiline --only-matching "[\s][@a-z].*[a-z]" | sd " " "" | sd "npm " "" | sd "\n" " " >$BACKUP/install/node.txt
}

##########################################################
# packages
##########################################################

alias n="npm"
alias nh="npm help"
alias nis="npm install"
alias nus="npm uninstall"
alias nisg="npm install -g"
alias nusg="npm uninstall -g"
alias nup="npm update"
alias nupg="npm update -g"
alias nst="npm outdated"
alias nls="npm list"
alias nlsg="npm list -g"
alias nlv="npm list --depth 0"
alias nlvg="npm list --depth 0 -g"
alias nck="npm doctor"
alias nsc="npm search"
alias ncl="npm cache clean -f"
alias nif="npm info"

##########################################################
# project
##########################################################

alias nii="npm init"
alias nr="npm run"
alias nts="npm test"
alias npb="npm publish"

##########################################################
# node
##########################################################

alias nj="node"
