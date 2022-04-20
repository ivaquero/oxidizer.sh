if ([string]::IsNullOrEmpty($env:OXIDIZER)) {
    $env:OXIDIZER = '.'
}

if (Get-Command scoop -ErrorAction SilentlyContinue) {
    Write-Host "Scoop Already Installed"
}
else {
    Write-Host "Scoop Not Found. Installing..."
    $env:SCOOP = 'C:\Scoop'
    [Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

    $f_scoop = Join-Path $env:USERPROFILE 'install.ps1'

    if ( $env:scoop_mirror ) {
        Invoke-WebRequest 'https://gitee.com/glsnames/scoop-installer/raw/master/bin/install.ps1' -UseBasicParsing -OutFile $f_scoop

        scoop config SCOOP_REPO 'https://gitee.com/glsnames/scoop-installer'
    }
    else {
        Invoke-WebRequest 'https://raw.githubusercontent.com/ScoopInstaller/Install/master/install.ps1' -UseBasicParsing -OutFile $f_scoop
    }
    if ( $env:scoop_test ) { & $f_scoop -RunAsAdmin }
    else { & $f_scoop }
}

scoop install aria2 
scoop install 7zip

# add additional buckets
if ( $env:scoop_mirror ) {
    $scoopBuckets = @("nerd-fonts https://gitee.com/scoop-bucket/nerd-fonts", "extras https://gitee.com/scoop-bucket/extras.git")
}
else {
    $scoopBuckets = @("nerd-fonts", "extras")
}

ForEach ( $bucket in $scoopBuckets ) {
    scoop bucket add $bucket
}

$scoops = cat $env:OXIDIZER/defaults/Scoopfile.txt

ForEach ( $scoop in $scoops ) {
    scoop install $scoop
}

if (Get-Command code -ErrorAction SilentlyContinue) {
    Write-Host "VS Code Already Installed"
}
else {
    scoop install vscode 
}

###################################################
# Update Terminal Settings
###################################################

if ( !(Test-Path "$env:SCOOP/persist/alacritty" ) ) {
    New-Item -ItemType Directory -Force -Path "$env:SCOOP/persist/alacritty"
}

Copy-Item -Verbose -Path "$env:OXIDIZER/defaults/alacritty-win.yml" -Destination "$env:SCOOP/persist/alacritty/alacritty.yml"

###################################################
# Update PowerShell Settings
###################################################

echo "📦 Adding Oxidizer into $PROFILE..."

if ( !(Test-Path $PROFILE) ) {
    New-Item -ItemType File -Force -Path $PROFILE
}

echo "
#Oxidizer" >> $PROFILE

if ( [Environment]::OSVersion.VersionString.Contains("Unix") ) { 
    echo '$env:BASE = $env:HOME' >> $PROFILE
}
else { echo '$env:BASE = $env:USERPROFILE' >> $PROFILE }

echo '
if ( [string]::IsNullOrEmpty($env:OXIDIZER) ) { 
    $env:OXIDIZER = "$env:BASE\oxidizer"
}
. $env:OXIDIZER\oxidizer.ps1' >> $PROFILE

echo "⚙️ Adding Custom settings..."
Copy-Item -Verbose -Force -Path "$env:OXIDIZER/demo-custom.ps1" -Destination "$env:OXIDIZER/custom.ps1"

# loading starship & zoxide
sd '.* STARTUP=.*' '$global:STARTUP=1' "$env:OXIDIZER/custom.ps1"

# set path of oxidizer
sd '= .*/oxidizer.ps1' '= $env:OXIDIZER\oxidizer.ps1' $PROFILE

###################################################
# Update PowerShell Modules
###################################################

echo "⚙️ Installing PowerShell Modules"

$modules = @("PowerShellGet", "PSReadLine")

ForEach ( $module in $modules ) {
    $len = (Get-Module $module).Name.Length
    if ($len -eq 0) {
        Install-Module -Name $module -Scope CurrentUser -Force -AllowClobber
    }
}

echo "🥳 Oxidizer installation complete!"

echo "😃 Don't forget to restart your terminal."

. $PROFILE
