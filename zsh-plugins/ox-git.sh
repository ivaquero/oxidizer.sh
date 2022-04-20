##########################################################
# config
##########################################################

# oxidizer files
Oxygen[oxg]=$OXIDIZER/defaults/.gitconfig
# config files
Element[g]=$HOME/.gitconfig
# backup files
Oxide[bkg]=$BACKUP/.gitconfig

export GPG_TTY=$(tty)

##########################################################
# main
##########################################################

alias gh="git --help"
alias gii="git init"
alias gdf="git diff"
alias gpl="git pull"
alias gps="git push"
alias gst="git status"
alias gcm="git commit"

# ui
alias gui="gitui"

# git add
ga() {
    if [[ -z $1 ]]; then
        git add .
    else
        git add $1
    fi
}

gig() {
    git rm -rf --cached .
    git add .
    git commit -m '🗑 remove all ignored files'
}

##########################################################
# branch & download
##########################################################

alias gsw="git switch"

# git clone
# dl: download
gdl() {
    case $2 in
    -a) git clone $1 ;;
    *) git clone --depth 1 $1 ;;
    esac
}

##########################################################
# cleaning
##########################################################

alias gfr="git filter-repo"

# clean files
gcl() {
    case $1 in
    -s) git filter-repo --strip-blobs-bigger-than $2 ;;
    -i) git filter-repo --strip-blobs-with-ids $2 ;;
    -p) git filter-repo --invert-paths --path-glob $2 ;;
    -h)
        git checkout --orphan new
        git add -A
        git commit -am "🎉 New Start"
        if [[ -z $2 ]]; then
            branch=master
        else
            branch=$2
        fi
        git branch -D $branch
        git branch -m $branch
        git push -f origin $branch
        ;;
    *) git repack -a -d --depth=250 --window=250 ;;
    esac
}

grpb() {
    git remote add origin $1
    if [[ -z $2 ]]; then
        branch=master
    else
        branch=$2
    fi
    git pull $1 $branch
    git push --set-upstream origin $branch
}

# list fat files
#
# $1: number to display
gjk() {
    if [[ -z $1 ]]; then
        local number=10
    else
        local number=$1
    fi

    git rev-list --objects --all | grep -f <(git verify-pack -v .git/objects/pack/*.idx | sort -k 3 -n | cut -f 1 -d " " | tail -$number)
}

# remove remote tag
gtg() {
    case $1 in
    rmo)
        git push --delete origin $2
        ;;
    esac
}

##########################################################
# proxy
##########################################################

# $1: mode
gpx() {
    case $1 in
    c | v)
        git config --global http.proxy http://127.0.0.1:${Proxy[$1]}
        git config --global https.proxy https://127.0.0.1:${Proxy[$1]}
        ;;
    s)
        git config --global http.proxy "socks5://127.0.0.1:${Proxy[$1]}"
        git config --global https.proxy "socks5://127.0.0.1:${Proxy[$1]}"
        ;;
    *)
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        ;;
    esac
}
