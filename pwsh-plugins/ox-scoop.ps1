##########################################################
# config
##########################################################

# config files
$global:Element.s = "$env:BASE\.config\scoop\config.json"
# backup files
$global:Oxide.bks = "$env:BACKUP\scoop.json"

Import-Module "$($(Get-Item $(Get-Command scoop).Path).Directory.Parent.FullName)\modules\scoop-completion" -ErrorAction SilentlyContinue

function init_scoop {
    echo "Initialize Scoop using Oxidizer configuration"
    $file = (cat $env:OXIDIZER/defaults/Scoopfile.txt)
    $num = (cat $env:OXIDIZER/defaults/Scoopfile.txt | Measure-Object -Line).Lines

    pueue group add init_scoop
    pueue parallel $num -g init_scoop

    Foreach ( $line in $file ) {
        echo "Installing $line"
        pueue add -g init_scoop "scoop install $line"
    }
    Start-Sleep –s 3 
    pueue status
}

function up_scoop {
    echo "Update Scoop by self-defined configuration"
    $file = (cat $env:BACKUP/install/Scoopfile.txt)
    $num = (cat $env:BACKUP/install/Scoopfile.txt | Measure-Object -Line).Lines

    pueue group add up_scoop
    pueue parallel $num -g up_scoop

    Foreach ( $line in $file ) {
        echo "Installing $line"
        pueue add -g up_scoop "scoop install $line"
    }
    Start-Sleep –s 3 
    pueue status
}

function back_scoop {
    echo "Backup Scoop to $env:BACKUP/install"
    scoop list | Out-File -FilePath "$env:BACKUP/install/Scoopfile.txt"
}

##########################################################
# packages
##########################################################

function sis { scoop install $args }

function sus { scoop uninstall $args }

function sba { scoop buck add $args }

function sbrm { scoop buck rm $args }

Remove-Item Alias:\sls
function sls { scoop list }

function sups { scoop update }

function sup { 
    if ([string]::IsNullOrEmpty($args)) { scoop update * }
    else { scoop update $args }
}

function sisp {
    $num = (echo $args | Measure-Object -Line).Lines
    if ( $num -ge 1 ) {
        pueue group add scoop_install
        pueue parallel $num -g scoop_install
        
        ForEach ($pkg in $args) {
            echo "Installing $pkg"
            pueue add -g scoop_install "scoop install $pkg"
        }
        Start-Sleep –s 3 
        pueue status
    }
    else { scoop update * }
}

function supp {
    $num = (scoop status | Measure-Object -Line).Lines
    if ( $num -ge 1 ) {
        pueue group add scoop_update
        pueue parallel $num -g scoop_update
        
        ForEach ($pkg in $args) {
            echo "Installing $pkg"
            pueue add -g scoop_update "scoop update $pkg"
        }
        Start-Sleep –s 3 
        pueue status
    }
    else { scoop update * }
}
function scl {
    if ([string]::IsNullOrEmpty($args)) { scoop cleanup * } 
    else { scoop cleanup $args }
}
function sst { scoop status }
function sck { scoop checkup }
function sat { scoop config aria2-enabled true }
function saf { scoop config aria2-enabled false }

##########################################################
# mirrors
##########################################################

function smr {}
