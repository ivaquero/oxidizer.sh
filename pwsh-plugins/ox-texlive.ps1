##########################################################
# config
##########################################################

# oxidizer files
$global:Oxygen.oxtl = "$env:OXIDIZER/defaults/texlive.txt"

function init_texlive {
    echo "Initialize TeXLive using Oxidizer configuration"
    $file = (cat $global:Oxygen.oxtl)
    $num = (cat $global:Oxygen.oxtl | Measure-Object -Line).Lines

    pueue group add texlive_init
    pueue parallel $num -g texlive_init

    Foreach ( $line in $file ) {
        echo "Installing $line"
        pueue add -g texlive_init "tlmgr install $line"
    }
    Start-Sleep -s 3
    pueue status
}

function up_texlive {
    echo "Update TeXLive by self-defined configuration"
    $file = (cat $global:Oxide.bktl)
    $num = (cat $global:Oxide.bktl | Measure-Object -Line).Lines

    pueue group add texlive_update
    pueue parallel $num -g texlive_update

    Foreach ( $line in $file ) {
        echo "Installing $line"
        pueue add -g texlive_update "tlmgr install $line"
    }
    Start-Sleep -s 3
    pueue status
}

function back_texlive {
    echo "Backup TeXLive to $env:BACKUP/install"
    tlmgr list --only-installed | rg --only-matching "collection-\w+" | rg --invert-match "basic" | Out-File -FilePath "$global:Oxide.bktl"
}

##########################################################
# packages
##########################################################

function tl { tlmgr }
function tlup { tlmgr update --all }
function tlups { tlmgr update --all --self }
function tlck { tlmgr check }
function tlis { tlmgr install $args }
function tlus { tlmgr remove $args }
function tllsa { tlmgr list }
function tlls { tlmgr list --only-installed }
function tlif { tlmgr info }
function tlifc { tlmgr info collections }
function tlifs { tlmgr info schemes }
function tlh { tlmgr -h }
