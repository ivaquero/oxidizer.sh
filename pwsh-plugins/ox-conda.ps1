##########################################################
# config
##########################################################

# oxidizer files
$global:Oxygen.oxc = "$env:OXIDIZER/defaults/.condarc"
$global:Oxygen.oxce = "$env:OXIDIZER/defaults/conda-base.txt"
# config files
$global:Element.c = "$env:BASE/.condarc"
# backup files
$global:Oxide.bkc = "$env:BACKUP/.condarc"

function init_conda {
    echo "Initialize Conda using Oxidizer configuration"
    $pkgs = cat $global:Oxygen.oxce | sd "`n" " "
    echo "Installing $pkgs"
    Invoke-Expression "mamba install $pkgs"
}

function up_conda {
    param ( $the_env, $the_file )
    if ([string]::IsNullOrEmpty($the_env)) {
        $cenv = "base"
        $conda_file = "$global:Oxide.bkceb"
    }
    elseif ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        $cenv = $global:Conda_Env.$the_env
        $conda_file = "$global:Oxide.bkce$the_env"
    }
    else {
        $cenv = $the_env
        $conda_file = $the_file
    }

    echo "Update Conda Env $cenv by $conda_file"
    $pkg = cat $conda_file | sd "`n" " "
    echo "Installing $pkg"
    Invoke-Expression "mamba install $pkgs"
}

function back_conda {
    param ( $the_env, $the_file )
    if ([string]::IsNullOrEmpty($the_env)) {
        $cenv = "base"
        $conda_file = "$global:Oxide.bkceb"
    }
    elseif ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        $cenv = $global:Conda_Env.$the_env
        $conda_file = "$global:Oxide.bkce$the_env"
    }
    else {
        $cenv = $the_env
        $conda_file = $the_file
    }

    echo "Backup Conda Env $cenv to $conda_file"
    $pkg = $(conda tree -n $cenv leaves)
    $pkg.Replace("[',\[\]]", "") | sd " " "`n" | Out-File -FilePath "$conda_file"
}

##########################################################
# packages
##########################################################

function ch { conda help }
function cif { conda info }
function cis { mamba install -q $args }
function cus { mamba uninstall -q $args }
function csc { mamba search -q $args }
function cdp { conda-tree depends $args }
function cdpt { conda-tree depends -t --small $args }
# specific
function crdp { conda-tree whoneeds $pkgs }

# clean packages
function ccl {
    if ([string]::IsNullOrEmpty($args)) { conda clean --all }
    else { conda clean $args }
}

# update packages
function cup {
    param ( $the_env )
    if ([string]::IsNullOrEmpty($the_env)) { mamba update --all -q }
    else {
        ceat $the_env
        mamba update --all -q
        conda deactivate
    }
}

del alias:cls -Force -ErrorAction SilentlyContinue
del alias:clv -Force -ErrorAction SilentlyContinue
# list packages
# $1=name
function cls {
    param ( $the_env )

    if ([string]::IsNullOrEmpty($the_env)) {
        mamba list
    }
    elseif ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        mamba list -n $global:Conda_Env.$the_env
    }
    else {
        mamba list -n $the_env
    }
}

# list leave packages
# $1=name
function clv {
    param ( $the_env )
    if ([string]::IsNullOrEmpty($the_env)) {
        conda-tree leaves
    }
    elseif ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        conda-tree -n $global:Conda_Env.$the_env leaves
    }
    else {
        conda-tree -n $the_env leaves
    }
}

function cmt {
    param ( $the_env )
    $num_total = (cls $the_env | Measure-Object -Line).Line
    echo "total: $num_total"
    $num_immature = (cls $the_env | rg "\s0\.\d" | Measure-Object -Line).Line
    $ratio = $num_immature / $num_total * 100
    $mature_rate = "{0:N0}" -f $(100 - $ratio)
    echo "mature rate: $mature_rate %"
}

##########################################################
# project
##########################################################

function cii {
    param ( $shell )
    conda init $shell
}
function cr {
    param ( $prj )
    conda run $prj
}

##########################################################
# environments
##########################################################

# activate environment: $1=name
function ceat {
    param ( $the_env )
    if ([string]::IsNullOrEmpty($the_env)) {
        conda activate base; clear
    }
    elseif ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        conda activate $global:Conda_Env.$the_env; clear
    }
    else {
        conda activate $the_env; clear
    }
}

# reactivate environment: $1=name
function cerat {
    param ( $the_env )
    conda deactivate
    ceat $the_env
}

# create environment: $1=name
function cecr {
    param ( $the_env )

    if ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        conda create -n $global:Conda_Env.$the_env
    }
    else {
        conda create -n $the_env
    }
    ceat $the_env
}

# delete environment: $1=name
function cerm {
    param ( $the_env )

    conda deactivate
    if ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        conda env remove -n $global:Conda_Env.$the_env
    }
    else {
        conda env remove -n $the_env
    }
}


# export environment: $1=name
function ceep {
    param ( $the_env )

    if ([string]::IsNullOrEmpty($the_env)) {
        $cenv = base
    }
    elseif ( $($the_env | Measure-Object -Character).Character -lt 3 ) {
        $cenv = $global:Conda_Env.$the_env
    }
    else {
        $cenv = $1
    }
    conda env export -n $cenv -f $env:BACKUP/install/$cenv-win.yml
}

function ceq { conda deactivate; clear }
function cels { conda env list }
