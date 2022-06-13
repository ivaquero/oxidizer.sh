##########################################################
# config
##########################################################

# oxidizer files
Oxygen[oxc]=$OXIDIZER/defaults/.condarc
Oxygen[oxce]=$OXIDIZER/defaults/conda-base.txt
# config files
Element[c]=$HOME/.condarc
# backup files
Oxide[bkc]=$BACKUP/.condarc

init_conda() {
    echo "Initialize Conda using Oxidizer configuration"
    local pkgs=$(cat ${Oxygen[oxce]} | sd "\n" " ")
    echo "Installing $pkgs"
    eval "mamba install $pkgs"
}

up_conda() {
    if [[ -z $1 ]]; then
        local conda_env=base
        local conda_file=${Oxide[bkceb]}
    elif [[ ${#1} < 4 ]]; then
        local conda_env=${Conda_Env[$1]}
        local conda_file=${Oxide[bkce$1]}
    else
        local conda_env=$1
        local conda_file=$2
    fi
    echo "Update Conda Env $conda_env by $conda_file"
    local pkgs=$(cat $conda_file | sd "\n" " ")
    echo "Installing $pkgs"
    eval "mamba install $pkgs"
}

back_conda() {
    if [[ -z $1 ]]; then
        local conda_env=base
        local conda_file=${Oxide[bkceb]}
    elif [[ ${#1} < 4 ]]; then
        local conda_env=${Conda_Env[$1]}
        local conda_file=${Oxide[bkce$1]}
    else
        local conda_env=$1
        local conda_file=$2
    fi
    echo "Backup Conda Env $conda_env to $conda_file"
    conda tree -n $conda_env leaves | sd "[',\[\]]" "" | sd " " "\n" >$conda_file
}

##########################################################
# packages
##########################################################

alias ch="conda help"
alias cif="conda info"
alias cis="mamba install -q"
alias cus="mamba uninstall -q"
alias csc="mamba search -q"
alias cdp="conda-tree depends"
alias cdpt="conda-tree depends -t --small"
# specific
alias crdp="conda-tree whoneeds"

# clean packages
ccl() {
    if [[ -z $1 ]]; then
        conda clean --all
    else
        conda clean $1
    fi
}

# update packages
# $1=name
cup() {
    if [[ -z $1 ]]; then
        mamba update --all -q
    else
        ceat $1
        mamba update --all -q
        conda deactivate
    fi
}

# list packages
# $1=name
cls() {
    if [[ -z $1 ]]; then
        conda list
    elif [[ ${#1} < 4 ]]; then
        conda list -n ${Conda_Env[$1]}
    else
        conda list -n $1
    fi
}

# list leave packages
# $1=name
clv() {
    if [[ -z $1 ]]; then
        conda-tree leaves
    elif [[ ${#1} < 4 ]]; then
        conda-tree -n ${Conda_Env[$1]} leaves
    else
        conda-tree -n $1 leaves
    fi
}

cmt() {
    local num_total=$(cls $1 | wc -l)
    echo "total: $num_total"
    local num_immature=$(cls $1 | rg "\s0\.\d" | wc -l)
    local mature_rate=$((100 - num_immature * 100 / num_total))
    echo "mature rate: $mature_rate %"
}

##########################################################
# project
##########################################################

alias cii="conda init"
alias cr="conda run"

##########################################################
# environments
##########################################################

# activate environment: $1=name
ceat() {
    if [[ -z $1 ]]; then
        conda activate base && clear
    elif [[ ${#1} < 4 ]]; then
        conda activate ${Conda_Env[$1]} && clear
    else
        conda activate $1 && clear
    fi
}

# reactivate environment: $1=name
cerat() {
    conda deactivate
    ceat $1
}

# create environment: $1=name
cecr() {
    if [[ ${#1} < 4 ]]; then
        conda create -n ${Conda_Env[$1]}
    else
        conda create -n $1
    fi
    ceat $1
}

# delete environment: $1=name
cerm() {
    conda deactivate
    if [[ ${#1} < 4 ]]; then
        conda env remove -n ${Conda_Env[$1]}
    else
        conda env remove -n $1
    fi
}

# change environment: $1=name, i=intel
cesd() {
    if [[ $1 == i ]]; then
        conda env config vars set CONDA_SUBDIR=osx-64
    else
        conda env config vars set CONDA_SUBDIR=$1
    fi
}

# export environment: $1=name
ceep() {
    os=$(echo $(uname -s) | tr "[:upper:]" "[:lower:]")
    arch=$(uname -m)
    if [[ -z $1 ]]; then
        conda_Env=base
    elif [[ ${#1} < 4 ]]; then
        conda_Env=${Conda_Env[$1]}
    else
        conda_Env=$1
    fi
    conda env export -n $conda_Env -f $OXIDIZER/defaults/$conda_Env-$os-$arch.yml
}

alias cels="conda env list"
alias ceq="conda deactivate"
