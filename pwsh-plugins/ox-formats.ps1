##########################################################
# text
##########################################################

function pdlsi { pandoc --list-input-formats }
function pdlso { pandoc --list-input-formats }

if ([string]::IsNullOrEmpty($env:Font)) {
    $env:Font = "Arial Unicode MS"
}

function font { param ( $the_font ) $env:Font = $the_font }

##########################################################
# markdown
##########################################################

function mdto {
    param ( $file, $format, $the_font)
    $name = (Get-Item $file).BaseName
    Switch ($format) {
        -pdf {
            pandoc $file -o ($name + "." + $format) --pdf-engine=xelatex -V CJKmainfont=$the_font
        }
        -html {
            pandoc $file -o ($name + "." + $format) --standalone --mathjax --shift-heading-level-by=-1
        }
        -docx {
            pandoc $file -o ($name + "." + $format)
        }
        default {
            pandoc $file -o ($name + "." + $format)
        }
    }
}

##########################################################
# mp3
##########################################################

function tomp3 {
    param ( $file, $bitrate )
    $name = (Get-Item $file).BaseName
    if ([string]::IsNullOrEmpty($cbr)) { $bitrate = "192K" }
    else { $cbr = $bitrate + "K" }

    ffmpeg -i $file -c:a libmp3lame -b:a $cbr $name.mp3
}
