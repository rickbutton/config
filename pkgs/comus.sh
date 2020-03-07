function dpkg-count() {
    dpkg-query -W -f='${Status}' $1 2>/dev/null | grep -c "ok installed";
}

function i() {
    if [ $(dpkg-count $1) -eq 0 ]; then
        echo "install: $1"
        sudo apt-get -y install $1
    fi
}

function r() {
    if [ $(dpkg-count $1) -gt 0 ]; then
        echo "remove: $1"
        sudo apt-get -y remove $1
    fi
}

function snap-count() {
    snap list | grep -c $1;
}

function i-snap() {
    if [ $(snap-count $1) -eq 0 ]; then
        echo "install: $1"
        sudo snap install $1
    fi
}

function r-snap() {
    if [ $(snap-count $1) -gt 0 ]; then
        echo "remove: $1"
        sudo snap remove $1
    fi }

function deb-count() {
    cat /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -c "^deb .*$1";
}
function deb-src-count() {
    cat /etc/apt/sources.list /etc/apt/sources.list.d/* | grep -c "^deb-src .*$1";
}

function i-ppa() {
    if [ $(deb-count $1) -eq 0 ]; then
        echo "add: $1"
        sudo add-apt-repository ppa:$1
    fi
}

function i-deb() {
    if [ $(deb-count $1) -eq 0 ]; then
        echo "add: $1"
        sudo add-apt-repository "deb $1"
    fi
}

function i-deb-src() {
    if [ $(deb-src-count $1) -eq 0 ]; then
        echo "add: $1"
        sudo add-apt-repository "deb-src $1"
    fi
}

function i-apt-key() {
    if [ $(apt-key list 2>/dev/null | grep -c $2) -eq 0 ]; then
        echo "add apt-key: "
        wget -q -O- $1 | sudo apt-key add -
    fi
}


i-ppa "3v1n0/libfprint-vfs0090"
i-ppa "yubico/stable"
i-ppa "mmstick76/alacritty"
i-ppa "plt/racket"

# thinkpad specific
i tlp
i tlp-rdw
i tp-smapi-dkms
i acpi-call-dkms

# system utils
i pavucontrol
i brightnessctl
i fprint-demo
i libpam-fprintd
i yubikey-personalization-gui

i-snap tusk
i-snap discord
i-snap spotify

i alacritty
i racket
i mutt
i w3m

# display/window management
i arandr
i autorandr
i xmonad
i xmobar
i stalonetray
i suckless-tools # dmenu
i feh
i scrot
i lxappearance

# user utils
i stow
i curl
i wget
i htop
i tree
i git
i gnupg2
i scdaemon # smartcards

# shell/editor
i zsh
i xclip
i tmux
r vim
i python-neovim
i python3-neovim
i python-dev
i python-pip
i python3-dev
i python3-pip

# dev env
i cmake
i cloc

RIPGREP_VERSION="11.0.1"
RIPGREP_DPKG="ripgrep_11.0.1_amd64.deb"
RIPGREP_BASE="https://github.com/BurntSushi/ripgrep/releases/download"
RIPGREP_URL="$RIPGREP_BASE/$RIPGREP_VERSION/$RIPGREP_DPKG"
if [ $(dpkg-count ripgrep) -eq 0 ]; then
    curl -LO $RIPGREP_URL
    sudo dpkg -i $RIPGREP_DPKG
    rm $RIPGREP_DPKG
fi

mkdir -p ~/local/bin
NVIM_PATH=~/local/bin/nvim
if [ ! -f $NVIM_PATH ]; then
    curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > $NVIM_PATH
    chmod +x $NVIM_PATH
fi
