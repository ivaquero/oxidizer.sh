##########################################################
# config
##########################################################

# config files
# use `_` as a suffix flag for directory
Element[vs]=$APPDATA/Code/User/settings.json
Element[vsk]=$APPDATA/Code/User/keybindings.json
Element[vss_]=$APPDATA/Code/User/snippets

# backup files
Oxide[bkvs]=$BACKUP/vscode/settings.json
Oxide[bkvsk]=$BACKUP/vscode/keybindings.json
Oxide[bkvss_]=$BACKUP/vscode/snippets

if [[ ! -d $BACKUP/vscode ]]; then
    mkdir -p $BACKUP/vscode
fi

init_vscode() {
    echo "Initialize VSCode extensions using Oxidizer configuration"
    local exts=$(code --list-extensions)
    local num=$(cat $OXIDIZER/defaults/vscode-exts.txt | wc -l | rg --only-matching "\d+")

    pueue group add vscode_init
    pueue parallel $num -g vscode_init

    cat $OXIDIZER/defaults/vscode-exts.txt | while read line; do
        if echo $exts | rg $line; then
            echo "Extension $line is already installed."
        else
            echo "Installing $line"
            pueue add -g vscode_init "code --install-extension '$line'"
        fi
    done
    sleep 3 && pueue status
}

up_vscode() {
    echo "Update VSCode extensions by self-defined configuration"
    local exts=$(code --list-extensions)
    local num=$(cat $BACKUP/install/vscode-exts.txt | wc -l | rg --only-matching "\d+")

    pueue group add vscode_init
    pueue parallel $num -g vscode_init

    cat $BACKUP/install/vscode-exts.txt | while read line; do
        if echo $exts | rg $line; then
            echo "Extension $line is already installed."
        else
            echo "Installing $line"
            pueue add -g vscode_init "code --install-extension '$line'"
        fi
    done
    sleep 3 && pueue status
}

back_vscode() {
    echo "Backup VSCode extensions to $BACKUP/install"
    code --list-extensions >$BACKUP/install/vscode-exts.txt
}

##########################################################
# extensions
##########################################################

alias codeis="code --install-extension"
alias codeus="code --uninstall-extension"
alias codels="code --list-extensions"
