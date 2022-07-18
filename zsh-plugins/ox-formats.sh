##########################################################
# text
##########################################################

alias pdlsi="pandoc --list-input-formats"
alias pdlso="pandoc --list-output-formats"

[[ -z $Font ]] && export Font="Arial Unicode MS"

# change font
chft() {
    export Font=$1
}

##########################################################
# markdown
##########################################################

# $1: input file, $2: output format, $3: font
mdto() {
    case $2 in
    pdf)
        pandoc $1 -o ${1%%.*}.$2 --pdf-engine=xelatex -V CJKmainfont=$Font
        ;;
    html)
        pandoc $1 -o ${1%%.*}.$2 --standalone --mathjax --shift-heading-level-by=-1
        ;;
    docx)
        pandoc $1 -o ${1%%.*}.$2
        ;;
    *)
        pandoc $1 -o ${1%%.*}.$2
        ;;
    esac
}

##########################################################
# mp3
##########################################################

tomp3() {
    if [[ -z $2 ]]; then
        cbr=192K
    else
        cbr=$2K
    fi
    ffmpeg -i $1 -c:a libmp3lame -b:a $cbr ${1%%.*}.mp3
}
