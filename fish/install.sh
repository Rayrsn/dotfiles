#!/bin/bash

#       ___           ___           ___           ___     
#      /\  \         /\  \         |\__\         /\  \    
#     /::\  \       /::\  \        |:|  |       /::\  \   
#    /:/\:\  \     /:/\:\  \       |:|  |      /:/\:\  \  
#   /::\~\:\  \   /::\~\:\  \      |:|__|__   /::\~\:\  \ 
#  /:/\:\ \:\__\ /:/\:\ \:\__\     /::::\__\ /:/\:\ \:\__\
#  \/_|::\/:/  / \/__\:\/:/  /    /:/~~/~    \/_|::\/:/  /
#     |:|::/  /       \::/  /    /:/  /         |:|::/  / 
#     |:|\/__/        /:/  /     \/__/          |:|\/__/  
#     |:|  |         /:/  /                     |:|  |    
#      \|__|         \/__/                       \|__|    

# Only Install in Linux
if [ "$(uname)" = "Linux" ]; then
    # check distro
    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
    echo "Current distro is Ubuntu/Ubuntu Based"
    echo "Installing Fish..."
    sudo apt-add-repository ppa:fish-shell/release-3 -y
    sudo apt-get update -y
    sudo apt install fish -y
    
    fi

    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
    echo "Current distro is Arch/Arch Based"
    echo "Installing Fish..."
    sudo pacman -S fish --noconfirm
    fi

# function for installing oh my fish
function omf_install() {
    curl https://raw.githubusercontent.com/oh-my-fish/oh-my-fish/master/bin/install -o ./temp
    chmod +x ./temp
    fish ./temp --noninteractive
    rm ./temp
}

# function for installing fisher
function fisher_install() {
    fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
}

# function for installing fish configs
function fishconfig_install() {
    fish -c "fisher install IlanCosman/tide@v5"
    fish -c "fisher install jorgebucaran/autopair.fish"
    fish -c "fisher install franciscolourenco/done"
    fish -c "omf install bang-bang"
    # check distro
    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
        echo "Current distro is Ubuntu/Ubuntu Based"
        echo "Installing Fish..."
        sudo apt install figlet lolcat -y
    fi

    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
        echo "Current distro is Arch/Arch Based"
        echo "Installing Fish..."
        sudo pacman -S figlet lolcat --noconfirm
    fi
    mkdir -p ~/.config/fish/
    cp -r . ~/.config/fish/
    rm ~/.config/fish/functions/_t*
    rm ~/.config/fish/functions/*prompt*
    rm ~/.config/fish/fish_title
}

# if argument noconfirm or nc is passed, run without asking else ask
if [ "$1" = "--noconfirm" ] || [ "$1" = "-nc" ]; then
    fisher_install
    omf_install
    fishconfig_install
else

    # Ask if user wants to install oh my fish
        read -p "Do you wish to install oh my fish? [Y/n] " yn
        case $yn in
            [Yy]* ) omf_install; break;;
            [Nn]* ) exit;;
            * ) omf_install;;
        esac

    # Ask if user wants to install fihser
        read -p "Do you wish to install fisher? [Y/n] " yn
        case $yn in
            [Yy]* ) fisher_install; break;;
            [Nn]* ) exit;;
            * ) fisher_install;;
        esac


    # Ask if user wants to install the fish configs
        read -p "Do you wish to install fish configs? [Y/n] " yn
        case $yn in
            [Yy]* ) fishconfig_install; break;;
            [Nn]* ) exit;;
            * ) fishconfig_install;;
        esac

fi
# Set fish as default shell
echo "Changing default shell to fish"
chsh -s /usr/bin/fish
fi
