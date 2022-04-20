##########################################################
# config
##########################################################

function init_node {
    echo "Initialize Node using Oxidizer configuration"
    $pkgs = (cat $env:OXIDIZER/defaults/node.txt | sd "`n" " ")
    echo "Installing $pkgs"
    Invoke-Expression "npm install -g $pkgs --force"
}

function up_node {
    echo "Update Node by self-defined configuration"
    $pkgs = (cat $env:BACKUP/install/node.txt | sd "`n" " ")
    echo "Installing $pkgs"
    Invoke-Expression "npm install -g $pkgs --force"
}

function back_node {
    echo "Backup Node to $env:BACKUP/install"
    $pkgs = $(npm list --depth 0 -g | rg --multiline --only-matching "[\s][@a-z].*[a-z]")
    $pkgs.Replace(" ", "").Replace("npm ", "") | sd "`n" " " | Out-File -FilePath "$env:BACKUP/install/node.txt"
}

##########################################################
# packages
##########################################################

function nh { npm help }
function nis { npm install $args }
function nus { npm uninstall $args }
function nisg { npm install -g $args }
function nusg { npm uninstall -g $args }
function nup { npm update }
function nupg { npm update -g }
function nst { npm outdated }
function nls { npm list }
function nlsg { npm list -g }
function nlv { npm list --depth 0 }
function nlvg { npm list --depth 0 -g }
function nck { npm doctor }
function nsc { npm search }
function ncl { npm cache clean -f }
function nif { npm info }

function nfx {
    if ([string]::IsNullOrEmpty($args)) { npm audit fix --force }
    else { npm audit fix $args }
}

##########################################################
# project
##########################################################

function nii { npm init $args }
function nr { npm run $args }
function nts { npm test $args }
function npb { npm publish $args }

##########################################################
# node
##########################################################

function nj {
    if ([string]::IsNullOrEmpty($args)) { node } 
    else { node $args }
}
