##########################################################
# config
##########################################################

# oxidizer files
$global:Oxygen.oxvsx = "$env:OXIDIZER/defaults/vscode-exts.txt"
# config files
# use `_` as a suffix flag for directory
$global:Element.vs = "$env:APPDATA/Code/User/settings.json"
$global:Element.vsk = "$env:APPDATA/Code/User/keybindings.json"
$global:Element.vss_ = "$env:APPDATA/Code/User/snippets"
# backup files
$global:Oxide.bkvs = "$env:BACKUP/vscode/settings.json"
$global:Oxide.bkvsk = "$env:BACKUP/vscode/keybindings.json"
$global:Oxide.bkvss_ = "$env:BACKUP/vscode/snippets"

if ( !(Test-Path "$env:BACKUP/vscode") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP/vscode"
}

function init_vscode {
    echo "Initialize VSCode extensions using Oxidizer configuration"
    $exts = (code --list-extensions)
    $file = (cat $global:Oxygen.oxvsx)
    $num = (cat $global:Oxygen.oxvsx | Measure-Object -Line).Lines

    pueue group add vscode_update
    pueue parallel $num -g vscode_update

    Foreach ( $line in $file ) {
        if (echo $exts | rg $line) {
            echo "Extension $line is already installed."
        }
        else {
            echo "Installing $line"
            pueue add -g vscode_update " code --install-extension '$line'"
        }
    }
    Start-Sleep -s 3
    pueue status
}

function up_vscode {
    echo "Update VSCode extensions by self-defined configuration"
    $exts = (code --list-extensions)
    $file = (cat $global:Oxide.bkvsx)
    $num = (cat $global:Oxide.bkvsx | Measure-Object -Line).Lines

    pueue group add vscode_update
    pueue parallel $num -g vscode_update

    Foreach ( $line in $file ) {
        if (echo $exts | rg $line) {
            echo "Extension $line is already installed."
        }
        else {
            echo "Installing $line"
            pueue add -g vscode_update " code --install-extension '$line'"
        }
    }
    Start-Sleep -s 3
    pueue status
}

function back_vscode {
    echo "Backup VSCode extensions to $env:BACKUP/install"
    code --list-extensions | Out-File -FilePath "$global:Oxide.bkvsx"
}

##########################################################
# extensions
##########################################################

function codeis { code --install-extension $args }
function codeus { code --uninstall-extension $args }
function codels { code --list-extensions }
