##########################################################
# Configuration File Utils
##########################################################

# export file
# $@=names
function epf {
    echo "Overwrite Oxide by Element"
    $files = $args
    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        if ( [string]::IsNullOrEmpty($global:Oxide.$bkfile) ) {
            echo "$global:Oxide.$bkfile does not exist, please define it in custom.ps1"
        }
        elseif ( $file.EndsWith("_") ) {
            $folder = ls $global:Element.$file
            ForEach ( $subfile in $folder ) {
                $in_file = $global:Element.$file + "\\" + $subfile
                $out_file = $global:Oxide.$bkfile + "\\" + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $global:Element.$file ).DirectoryName
            if (!(Test-Path $parentpath)) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $global:Element.$file -Destination $global:Oxide.$bkfile
        }
    }
}

# import file: reverse action of `epf`
function ipf {
    echo "Overwrite Element by Oxide"
    $files = $args
    ForEach ( $file in $files ) {
        $bkfile = "bk" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $global:Oxide.$bkfile
            ForEach ( $subfile in $folder ) {
                $in_file = $global:Oxide.$bkfile + "\\" + $subfile
                $out_file = $global:Element.$file + "\\" + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $global:Element.$file ).DirectoryName
            if (!(Test-Path $parentpath)) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $global:Oxide.$bkfile -Destination $global:Element.$file
        }
    }
}

# initialize file
function iif {
    echo "Overwrite Element by Oxygen"
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $global:Oxygen.$oxfile
            ForEach ( $subfile in $folder ) {
                $in_file = $global:Oxygen.$oxfile + "\\" + $subfile
                $out_file = $global:Element.$file + "\\" + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $global:Element.$file ).DirectoryName
            if ( !(Test-Path $parentpath) ) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $global:Oxygen.$oxfile -Destination $global:Element.$file
        }
    }
}

# duplicate file
function dpf {
    echo "Overwrite Element by Oxygen"
    $files = $args
    ForEach ( $file in $files ) {
        $oxfile = "ox" + $file
        $bkfile = "bk" + $file
        if ( $file.EndsWith("_") ) {
            $folder = ls $global:Oxygen.$oxfile
            ForEach ( $subfile in $folder ) {
                $in_file = $global:Oxygen.$oxfile + "\\" + $subfile
                $out_file = $global:Oxide.$bkfile + "\\" + $subfile
                Copy-Item -Verbose -Path $in_file -Destination $out_file
            }
        }
        else {
            $parentpath = ( Get-Item $global:Oxide.$bkfile ).DirectoryName
            if ( !(Test-Path $parentpath) ) {
                New-Item -ItemType Directory -Force -Path $parentpath
            }
            Copy-Item -Verbose -Path $global:Oxygen.$oxfile -Destination $global:Oxide.$bkfile
        }
    }
}

##########################################################
# Gerneral File Utils
##########################################################

# refresh file
function ff {
    & $profile
}

# browse file
function bf {
    param ( $file )
    if ( $file.EndsWith("_")  ) {
        $cmd = "ls"
    }
    else {
        $cmd = "cat"
    }
    switch ( $file ) {
        { $file -match "ox\w{1,}" } { . $cmd $global:Oxygen.$file }
        { $file -match "bk\w{1,}" } { . $cmd $global:Oxide.$file }
        Default { . $cmd $global:Element.$file }
    }
}

# edit file by default editor
function ef {
    param ( $file, $mode )
    if ( $mode -eq "-t" ) { $cmd = $env:EDITOR_T }
    else { $cmd = $env:EDITOR }

    switch ( $file ) {
        { $file -match "ox[a-z]{1,}" } { . $cmd $global:Oxygen.$file }
        { $file -match "bk[a-z]{1,}" } { . $cmd $global:Oxide.$file }
        Default { . $cmd $global:Element.$file }
    }
}

##########################################################
# Change defaults
##########################################################

# change editor
function ched {
    param ( $editor )
    sd "EDITOR = .*" "EDITOR = $editor" $global:Element.ox
}

##########################################################
# Proxy utils
##########################################################

# proxy
function px {
    param ( $port )
    $env:https_proxy = "http://127.0.0.1:$port"
    $env:http_proxy = "http://127.0.0.1:$port"
    $env:all_proxy = "socks5://127.0.0.1:$port"
}

function upx { $env:https_proxy = ''; $env:http_proxy = ''; $env:all_proxy = '' }
