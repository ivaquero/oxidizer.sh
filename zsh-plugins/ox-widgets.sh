##########################################################
# weather
##########################################################

# -a: all, -g: geographical, -d: day, -n: night
wtr() {
    case $2 in
    -a)
        curl wttr.in/$1
        ;;
    -d)
        curl v2d.wttr.in/$1
        ;;
    -n)
        curl v2d.wttr.in/$1
        ;;
    -g)
        curl v3.wttr.in/$1
        ;;
    -h)
        echo "param 1:\n city: new+york\n airport(codes): muc \n resort: ~Eiffel+Tower\n ip address: @github.com\n help: :help"
        echo "param 2:\n a: all\n d: day \n n: night\n g: geographical\n f: format"
        ;;
    *)
        curl v2.wttr.in/$1
        ;;
    esac
}

##########################################################
# zip files
##########################################################

# $1=input-name, $2=output-name
zipf() {
    local file=${1%%.*}

    if [[ -z $2 ]]; then
        local ext=zip
    else
        local ext=${2#*.}
    fi

    case $ext in
    bz | bz2)
        bzip2 -z $1
        ;;
    gz)
        gzip $1
        ;;
    tar)
        tar -cvf $1
        ;;
    tar.gz | tgz)
        tar -zcvf $1
        ;;
    tar.bz)
        tar -jcvf $1
        ;;
    tar.bz2)
        tar -jcvf $1
        ;;
    7z)
        7zz a $1
        ;;
    *)
        zip $1
        ;;
    esac
}

# $1=input-name, $2=output-name
unzipf() {
    if [[ -z $2 ]]; then
        local dir=$(dirname $1)
    else
        local dir=$2
    fi

    local file=${1%%.*}
    local ext=${1#*.}
    case $ext in
    bz | bz2)
        bzip2 -d $1 $dir
        ;;
    gz)
        gzip -d $1 $dir
        ;;
    tar)
        tar -xvf $1 -C $dir
        ;;
    tar.gz | tgz)
        tar -zxvf $1 -C $dir
        ;;
    tar.bz)
        tar -jxvf $1 -C $dir
        ;;
    tar.bz2)
        tar -jxvf $1 -C $dir
        ;;
    7z)
        7zz e $1 $dir
        ;;
    *)
        unzip $1 $dir
        ;;
    esac
}

##########################################################
# text
##########################################################

# $1=old, $2=new, $3=path
replace() {
    sd $1 $2 $(fd $3)
}
