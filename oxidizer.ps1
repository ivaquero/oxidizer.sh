##########################################################
# Oxidizer configuration files
##########################################################

$global:Oxygen = @{}
$global:Oxygen.oxox = "$env:OXIDIZER/demo-custom.ps1"
$global:Oxygen.oxz = "$env:OXIDIZER/oxidizer.ps1"
$global:Oxygen.oxal = "$env:OXIDIZER/defaults/alacritty-win.yml"
$global:Oxygen.oxar = "$env:OXIDIZER/defaults/aria2.conf"
$global:Oxygen.oxvi = "$env:OXIDIZER/defaults/.vimrc"
# plugins
$global:Oxygen.oxps = "$env:OXIDIZER/pwsh-plugins/ox-scoop.ps1"
$global:Oxygen.oxpc = "$env:OXIDIZER/pwsh-plugins/ox-conda.ps1"
$global:Oxygen.oxpcc = "$env:OXIDIZER/pwsh-plugins/ox-cpp.ps1"
$global:Oxygen.oxpdk = "$env:OXIDIZER/pwsh-plugins/ox-docker.ps1"
$global:Oxygen.oxpfm = "$env:OXIDIZER/pwsh-plugins/ox-formats.ps1"
$global:Oxygen.oxpg = "$env:OXIDIZER/pwsh-plugins/ox-git.ps1"
$global:Oxygen.oxphx = "$env:OXIDIZER/pwsh-plugins/ox-helix.ps1"
$global:Oxygen.oxpjl = "$env:OXIDIZER/pwsh-plugins/ox-julia.ps1"
$global:Oxygen.oxpnj = "$env:OXIDIZER/pwsh-plugins/ox-node.ps1"
$global:Oxygen.oxpnv = "$env:OXIDIZER/pwsh-plugins/ox-neovim.ps1"
$global:Oxygen.oxppu = "$env:OXIDIZER/pwsh-plugins/ox-pueue.ps1"
$global:Oxygen.oxprs = "$env:OXIDIZER/pwsh-plugins/ox-rust.ps1"
$global:Oxygen.oxptl = "$env:OXIDIZER/pwsh-plugins/ox-texlive.ps1"
$global:Oxygen.oxput = "$env:OXIDIZER/pwsh-plugins/ox-utils.ps1"
$global:Oxygen.oxpvs = "$env:OXIDIZER/pwsh-plugins/ox-vscode.ps1"
$global:Oxygen.oxpwt = "$env:OXIDIZER/pwsh-plugins/ox-widgets.ps1"
$global:Oxygen.oxpw = "$env:OXIDIZER/pwsh-plugins/ox-windows.ps1"

##########################################################
# System configuration files
##########################################################

$global:Element = @{}

$global:Element.ox = "$env:OXIDIZER/custom.ps1"
$global:Element.al = "$env:SCOOP/persist/alacritty/alacritty.yml"
$global:Element.ar = "$env:BASE/.aria2/aria2.conf"
$global:Element.ps = $PROFILE

$global:Oxide = @{}

. $global:Element.ox

if ( !(Test-Path "$env:BACKUP/shell") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP/shell"
}

$global:Oxide.bkps = "$env:BACKUP/shell/Profile.ps1"
$global:Oxide.bkox = "$env:BACKUP/shell/custom.ps1"
$global:Oxide.bkal = "$env:BACKUP/alacritty.yml"
$global:Oxide.bkar = "$env:BACKUP/aria2.conf"
$global:Oxide.bkvi = "$env:BACKUP/.vimrc"

##########################################################
# Aliases
##########################################################

function ls {
    param ( $path )
    if ([string]::IsNullOrEmpty( $path )) { lsd }
    else { lsd $path }
}
function ll {
    param ( $path )
    if ([string]::IsNullOrEmpty( $path )) { lsd -l }
    else { lsd -l $path }
}
function la {
    param ( $path )
    if ([string]::IsNullOrEmpty( $path )) { lsd -a }
    else { lsd -a $path }
}
function lla {
    param ( $path )
    if ([string]::IsNullOrEmpty( $path )) { lsd -la }
    else { lsd -la $path }
}
function lt {
    param ( $path )
    if ([string]::IsNullOrEmpty( $path )) { lsd --tree }
    else { lsd --tree $path }
}
function cat { bat $args }
function man { tldr $args }
function z. { z .. }
function z.. { z ../.. }
function zz { z - }

##########################################################
# PowerShell & Plugins
##########################################################

# import ox-windows
. $global:Oxygen.oxpw
# import ox-utils
. $global:Oxygen.oxput
# import pueue
. $global:Oxygen.oxppu
# import ox-scoop
if ( [Environment]::OSVersion.VersionString.Contains("Windows") ) {
    . $global:Oxygen.oxps
}

ForEach ($plugin in $global:PLUGINS) {
    . $global:Oxygen.$($plugin)
}

if ( !(Test-Path "$env:BACKUP/install") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP/install"
}

if ( !(Test-Path "$env:BACKUP/apps") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP/apps"
}

##########################################################
#  Oxidizer management
##########################################################

# initialize Oxidizer
# only install missing packages, no deletion
function init_all {
    ForEach ($obj in $global:INIT_OBJ) {
        Invoke-Expression init_$obj
    }
}

# update packages
function back_all {
    ForEach ($obj in $global:UP_OBJ) {
        Invoke-Expression up_$obj
    }
}

# backup packages lists
function back_all {
    ForEach ($obj in $global:BACK_OBJ) {
        Invoke-Expression back_$obj
    }
}

# export configurations
function epall {
    ForEach ($obj in $global:EPF_OBJ) {
        epf $obj
    }
}

# export configurations
function ipall {
    ForEach ($obj in $global:IPF_OBJ) {
        ipf $obj
    }
}

# initialize Oxidizer
function iiox {
    ForEach ($obj in $global:IIF_OBJ) {
        iif $obj
    }
}

# update Oxidizer
function upox {
    z $env:OXIDIZER
    git fetch origin master
    git reset --hard origin/master
}

if ($global:STARTUP) {
    Invoke-Expression (&starship init powershell | Out-String)
    Invoke-Expression (&zoxide init powershell --hook prompt | Out-String)
    startup
}

if (Get-Command code -ErrorAction SilentlyContinue) {
    $env:EDITOR = "code"
}

##########################################################
# Extras
##########################################################

Import-Module posh-git

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function Complete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key "Ctrl+z" -Function Undo

if ( [Environment]::OSVersion.VersionString.Contains("Windows") ) {
    Import-Module "$($(Get-Item $(Get-Command scoop.ps1).Path).Directory.Parent.FullName)\modules\scoop-completion" -ErrorAction SilentlyContinue
}
