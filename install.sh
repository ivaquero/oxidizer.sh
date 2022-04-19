if [[ -z $OXIDIZER ]]; then
    export OXIDIZER='.'
fi

printf "Installing Oxidizer\n"

# if [[ $(uname -s) == "Darwin" ]]; then
#     printf "📦 Installing XCode CL tools...\n"
#     xcode-select --install >/dev/null 2>&1
# fi

###################################################
# Install Homebrew
###################################################

if test ! "$(command -v brew)"; then
    info "📦 Homebrew not installed. Installing."
    if [ $BREW_CN ]; then
        brew_installer="$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    else
        brew_installer="$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    eval "/bin/bash -c ${brew_installer}"
fi

printf "⚙️ Adding Custom settings...\n"
cp -i -v $OXIDIZER/demo-custom.sh $OXIDIZER/custom.sh

printf "⚙️ Activating Homebrew...\n"

if [[ $(uname -s) == "Darwin" ]]; then
    printf "📦 Installing Homebrew on MacOS...\n"
    if [[ $(uname -m) == "arm64" ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/Homebrew/bin/brew shellenv)"
    fi
else
    printf "📦 Installing Homebrew on Linux...\n"
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>.profile
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

###################################################
# Install Homebrew Packages
###################################################

printf "📦 Installing essential Oxidizer toolchains...\n"
brew bundle install --file $OXIDIZER/defaults/Brewfile

###################################################
# Update Shell Settings
###################################################

case $SHELL in
*zsh)
    brew install zsh zsh-completions zsh-autosuggestions zsh-syntax-highlighting
    export shell_conf=$HOME/.zshrc
    ;;
*)
    bash_v=$(bash --version | head -n1 | cut -d' ' -f4 | cut -d'.' -f1)
    if [[ bash_v < 5 ]]; then
        printf "📦 Installing Latest Bash...\n"
        brew install bash bash_completion
    fi
    export shell_conf=$HOME/.profile
    ;;
esac

printf "📦 Adding Oxidizer into $shell_conf...\n"
echo '
# Oxidizer
if [[ -z $OXIDIZER ]]; then
    export OXIDIZER=$HOME/oxidizer
fi
source $OXIDIZER/oxidizer.sh' >>$shell_conf

echo "⚙️ Adding Custom settings..."
cp $OXIDIZER/demo-custom.sh $OXIDIZER/custom.sh

# loading starship & zoxide
sd ".* STARTUP=.*" "export STARTUP=1" $OXIDIZER/custom.sh

# set path of oxidizer
sd "source OXIDIZER=.*" "source OXIDIZER=$OXIDIZER/oxidizer.sh" $shell_conf

if test ! "$(command -v code)"; then
    echo "No VS Code installed. "
    if test ! "$(command -v nvim)"; then
        echo "No NeoVim installed"
    else
        export EDITOR="vi"
        eval "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    fi
fi

printf "🥳 Oxidizer installation complete!\n"

echo " For Linux users who uses zsh, please run: export SHELL=$(which zsh) and then re-run the installer."
