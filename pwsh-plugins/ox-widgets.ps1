##########################################################
# weather
##########################################################

# -a: all, -g: geographical, -d: day, -n: night
function wtr {
    param ( $loc, $mode )
    case $mode in
    -a
    { curl wttr.in/$loc }
    -d
    { curl v2d.wttr.in/$loc }
    -n
    { curl v2d.wttr.in/$loc }
    -g
    { curl v3.wttr.in/$loc }
    -h {
        echo "param 1:`n city: new+york`n airport(codes): muc `n resort: ~Eiffel+Tower`n ip address: @github.com`n help: :help"
        echo "param 2:`n a: all`n d: day `n n: night`n g: {geographical`n f: format"
    }
    default { curl v2.wttr.in/$loc }
}

##########################################################
# batch management
##########################################################

# $1=old, $2=new, $3=path
function replace {
    param ( $old, $new, $path )
    sd "$old" "$new" $(fd "$path")
}
