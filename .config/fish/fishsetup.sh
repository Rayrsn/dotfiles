#!/bin/sh

# Only Install in Linux
if [ "$(uname)" = "Linux" ]; then
    # check distro
    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
    echo "Current distro is Ubuntu/Ubuntu Based"
    echo "Installing Fish..."
    sudo apt install fish -y
    
    fi

    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
    echo "Current distro is Arch/Arch Based"
    echo "Installing Fish..."
    sudo pacman -S fish --noconfirm
    fi
# Set fish as default shell
chsh -s /bin/fish

# function for installing fisher
function fisher_install() {
    curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
}

# function for installing oh my fish
function omf_install() {
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install | fish
}

# function for installing fish configs
function fishconfig_install() {
    cp . ~/.config/fish/
}

# if argument noconfirm or nc is passed, run without asking else ask
if [ "$1" = "--noconfirm" ] || [ "$1" = "-nc" ]; then
    fisher_install
    omf_install
    fishconfig_install
else

    # Ask if user wants to install oh my fish
    while true; do
        read -p "Do you wish to install oh my fish? [Y/n] " yn
        case $yn in
            [Yy]* ) omf_install; break;;
            [Nn]* ) exit;;
            * ) omf_install;;
        esac
    done

    # Ask if user wants to install fihser
    while true; do
        read -p "Do you wish to install fisher? [Y/n] " yn
        case $yn in
            [Yy]* ) fisher_install; break;;
            [Nn]* ) exit;;
            * ) fisher_install;;
        esac
    done


    # Ask if user wants to install the fish configs
    while true; do
        read -p "Do you wish to install fish configs? [Y/n] " yn
        case $yn in
            [Yy]* ) fishconfig_install; break;;
            [Nn]* ) exit;;
            * ) fishconfig_install;;
        esac
    done

fi
fi
