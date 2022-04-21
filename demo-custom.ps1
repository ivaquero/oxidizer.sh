##########################################################
# basic settings
##########################################################

# donwload path: works for brew-aria2 function
$env:DOWNLOAD = "$env:BASE/Documents"
# backup folder
$env:BACKUP = "$env:DOWNLOAD/backup"

# default editor, can be changed by function `ched()`
$env:EDITOR = "code"
# terminal editor
$env:EDITOR_T = "vi"

##########################################################
# select ox-plugins
##########################################################

# toolchain specific (highly recommended)
# oxpg: ox-git
#
# language & software-specific
# oxpcc: ox-cpp
# oxpc: ox-conda
# oxpdk: ox-docker
# oxpjl: ox-julia
# oxpnj: ox-node
# oxpnv: ox-neovim
# oxprs: ox-rust
# oxptl: ox-texlive
# oxpvs: ox-vscode
#
# other-shortcuts
# oxpfm: ox-formats
# oxpwt: ox-widgets
$global:PLUGINS = @("oxpc", "oxpvs", "oxpfm")

##########################################################
# register proxy ports
##########################################################

# c: clash, v: v2ray
$global:Proxy = @{}
$global:Proxy.c = "7890"
$global:Proxy.v = "1080"

##########################################################
# select initial and backup configurations
##########################################################

# options: scoop, conda, julia, node, texlive, vscode
$global:INIT_OBJ = @("vscode")
$global:BACK_OBJ = @("vscode")
$global:UP_OBJ = @("vscode")

# backup file path
$global:Oxide.bks = "$env:BACKUP/install/Scoopfile.txt"
# conda env stats with bkce, and should be consistent with Conda_Env
$global:Oxide.bkceb = "$env:BACKUP/install/conda-base.txt"
$global:Oxide.bkjl = "$env:BACKUP/install/julia.txt"
$global:Oxide.bknj = "$env:BACKUP/install/node.txt"
$global:Oxide.bktl = "$env:BACKUP/install/texlive.txt"
$global:Oxide.bkvsx = "$env:BACKUP/install/vscode-exts.txt"

##########################################################
# select export and import configurations
##########################################################

# files to be exported to backup folder
# ox: custom.sh of Oxidizer
# rs: cargo's env
# pu: pueue's config.yml
# pua: pueue's aliases.yml
# jl: julia's startup.jl
# vs: vscode's settings.json
# vsk: vscode's keybindings.json
# vss_: vscode's snippets folder
$global:EPF_OBJ = @("ox", "al", "vs", "vsk", "vss_")

# files to be import from backup folder
# $global:IPF_OBJ = @("ox", "al", "vs", "vsk", "vss_")

# file to be copied from oxidizer/defaults
# al: alacritty
# ar: aria2
# pu: pueue
# pua: pueue_aliases
$global:IIF_OBJ = @("ar")
# $global:IIF_OBJ = @("ar","al")

##########################################################
# register conda environments
##########################################################

# predefined conda environments
# set the length of key < 3
$global:Conda_Env = @{}
# $global:Conda_Env.h = "hello"

##########################################################
# rust configurations
##########################################################

# rust mirrors for faster download, use `rsmr` to use
$global:Rust_Mirror = @{}
$global:Rust_Mirror.ts = "mirrors.tuna.tsinghua.edu.cn"
$global:Rust_Mirror.zk = "mirrors.ustc.edu.cn"

##########################################################
# powerShell
##########################################################

function wh { which $args }
function e { echo $args }
function rr { del -Recurse $args }
function c { clear }

# tools
function ar { aria2c --dir $env:DOWNLOAD $args }
function hf { hyperfine $args }

##########################################################
# powerShell
##########################################################

function tt { hyperfine --warmup 3 --shell pwsh '. $PROFILE' }

##########################################################
# startup & daily commands
##########################################################

$global:STARTUP = 1

function startup {
}
