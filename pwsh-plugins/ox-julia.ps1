##########################################################
# config
##########################################################

# config files
$global:Element.jl = "$env:BASE/.julia/config/startup.jl"
$global:Element.jlm = "$env:BASE/.julia/environments/v$(julia -v | rg --only-matching "\d.\d")/Manifest.toml"
$global:Element.jlp = "$env:BASE/.julia/environments/v$(julia -v | rg --only-matching "\d.\d")/Project.toml"

# backup files
$global:Oxide.bkjl = "$env:BACKUP/julia/startup.jl"

if ( !(Test-Path "$env:BACKUP/julia") ) {
    New-Item -ItemType Directory -Force -Path "$env:BACKUP/julia"
}

function init_julia {
    echo "Initialize Julia using Oxidizer configuration"
    $pkgs = (cat $env:OXIDIZER/defaults/julia.txt | sd '`n' '\", \"')
    $pkgs_vec = echo [`"$pkgs`"] | sd '\[' '[\"' | sd ', \"]' ']'
    echo "Installing ($pkgs_vec)"
    $cmd = echo "using Pkg; Pkg.add($pkgs_vec)"
    julia --eval $cmd
}

function up_julia {
    echo "Update Julia by $env:BACKUP/install/julia.txt"
    $pkgs = (cat $env:BACKUP/install/julia.txt | sd '`n' '\", \"')
    $pkgs_vec = echo [`"$pkgs`"] | sd '\[' '[\"' | sd ', \"]' ']'
    $cmd = echo "using Pkg; Pkg.add($pkgs_vec)"
    julia --eval `"$cmd`"
}

function back_julia {
    echo "Backup Julia to $env:BACKUP/install"
    cat $global:Element.jlp | rg --only-matching "\w.*=" | sd "[= ]" " " | Out-File -FilePath $env:BACKUP/install/julia.txt
}

##########################################################
# packages
##########################################################

function jl {
    julia --quiet 
}
function jlh {
    julia --help 
}
function jlr {
    param ( $cmd)
    julia --eval $cmd
}
function jlcl {
    julia --eval 'using Pkg; Pkg.gc()'
}
function jlst {
    julia --eval 'using Pkg; Pkg.status()'
}


# install packages
function jlis {
    $pkgs = (echo `"$args`" | sd ' ' '\", \"')
    $cmd = (echo "using Pkg; Pkg.add([$pkgs])")
    echo $cmd
    julia --eval `"$cmd`"
}

# uninstall packages
function jlus {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.rm([$pkgs])")
    julia --eval `"$cmd`"
}

# update packages
function jlup {
    if ([string]::IsNullOrEmpty($args)) { 
        julia --eval "using Pkg; Pkg.update()"
    }
    else {
        $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
        $cmd = $(echo "using Pkg; Pkg.update([$pkgs])")
        julia --eval `"$cmd`"
    }
}

# list leave packages
function jllv {
    cat $global:Element.jlp | rg --only-matching "\w+ =" | sd " =" " "
}

# list packages
function jlls {
    cat $global:Element.jlm | rg --only-matching "deps\.\w+" | sd "deps\." ""
}

function jlpn {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.pin([$pkgs])")
    julia --eval `"$cmd`"
}

function jlupn {
    param ( $pkgs)
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.free([$pkgs])")
    julia --eval `"$cmd`"
}

# calculate mature rate
function jlmt {
    $num_total = (cat $global:Element.jlm | rg "\[\[" | Measure-Object -Line).Line
    echo "total: $num_total"
    $num_immature = (cat $global:Element.jlm | rg '\"0\.' | Measure-Object -Line).Line
    $ratio = $num_immature / $num_total * 100
    $mature_rate = "{ 0:N0 }" -f $(100 - $ratio)   
    echo "mature rate: $mature_rate %"
}

##########################################################
# packages
##########################################################

function jlb {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.build([$pkgs])")
    julia --eval `"$cmd`"
}

function jlts {
    $pkgs = $(echo `"$args`" | sd ' ' '\", \"')
    $cmd = $(echo "using Pkg; Pkg.test([$pkgs])")
    julia --eval `"$cmd`"
}
