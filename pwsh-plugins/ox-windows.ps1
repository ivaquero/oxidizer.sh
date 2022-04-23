##########################################################
# config
##########################################################

# oxidizer files
$global:Oxygen.oxw = "$env:OXIDIZER/defaults/winget.jsonc"
# config files
$global:Element.w = "$env:LOCALAPPDATA/Microsoft/WinGet/Settings/settings.json"
# backup files
$global:Oxide.bkw = "$env:BACKUP/winget.json"

function open {
    param ( $path )
    explorer $path
}

##########################################################
# main
##########################################################

function clean {
    param ( $obj )
    switch ($obj) {
        sd { del -Recurse -Confirm $env:SCOOP\cache }
        Default { Clear-RecycleBin -Confirm }
    }
}

function hide {
    $file = Get-Item $args[0] -Force
    $file.attributes = 'Hidden'
}
function shutdown {
    Stop-Computer -Force
}

function restart {
    Restart-Computer -Force
}

##########################################################
# winget
##########################################################

function init_winget {
    winget import -i $global:Oxygen.wg
}

function up_winget {
    winget import -i $global:Oxide.bkwg
}

function back_winget {
    winget export -o $global:Oxide.bkwg
}

function app { winget $args }
function appis { winget install $args }
function appus { winget uninstall $args }

function appls { winget list }

function appif { winget show $args }

function appifs { winget --info }

function appup {
    if ([string]::IsNullOrEmpty($args)) { winget upgrade * }
    else { winget upgrade $args }
}

##########################################################
# wsl
##########################################################

function wlis {
    if ([string]::IsNullOrEmpty($args)) { wsl --install }
    else { wsl --install -d $args }
}

function wllso { wsl -l -o }

function wlls { wsl -l -v }

function wlsv {
    param ( $ver )
    switch ($ver) {
        { $ver -eq 2 } { 1 }
        Default { 2 }
    }
    wsl --set-version $ver
}
