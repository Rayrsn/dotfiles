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

if [ "$(uname)" = "Linux" ]; then
    # check distro for ubuntu and arch else exit
    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
    echo "Current distro is Ubuntu/Ubuntu Based"
    echo "Installing packages..."
    sudo add-apt-repository ppa:mmstick76/alacritty -y
    sudo apt-get update -y
    sudo apt install git lightdm feh awesome-extra awesome nitrogen alacritty dmenu rofi pcmanfm -y
    
    elif [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
    echo "Current distro is Arch/Arch Based"
    echo "Installing packages..."
    sudo pacman -S git lightdm feh vicious awesome nitrogen alacritty dmenu rofi pcmanfm --noconfirm
    
    else 
    echo "Current distro is not supported"
    echo "Exiting..."
    fi

else 
    echo "Operating system is not \"Linux\""
    echo "Exiting..."
fi

func_install() {
    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
    sudo mkdir -p /usr/share/fonts/cantarell
    sudo cp -r ./Cantarell-VF.otf /usr/share/fonts/cantarell

    cd /tmp
    git clone https://github.com/gabrielelana/awesome-terminal-fonts
    cd awesome-terminal-fonts
    sudo mkdir -p /usr/share/fonts/awesome-terminal-fonts
    sudo cp -r ./build/*.ttf /usr/share/fonts/awesome-terminal-fonts
	
    cd /tmp
    git clone https://github.com/adobe-fonts/source-sans
    cd source-sans
    sudo mkdir -p /usr/share/fonts/adobe-source-sans-fonts
    sudo cp -r ./OTF/*.otf /usr/share/fonts/adobe-source-sans-fonts
    sudo cp -r ./TTF/*.ttf /usr/share/fonts/adobe-source-sans-fonts

    cd /tmp
    curl "https://sources.archlinux.org/other/community/ttf-droid/ttf-droid-20121017.tar.xz" -o "ttf-droid-20121017.tar.xz"
    tar -xf ttf-droid-20121017.tar.xz
    cd google-droid-fonts-20121017
    sudo mkdir -p /usr/share/fonts/droid
    sudo cp -r ./*.ttf /usr/share/fonts/droid

    cd /tmp
    curl "https://www.fial.com/~scott/tamsyn-font/download/tamsyn-font-1.11.tar.gz" -o "tamsyn-font-1.11.tar.gz"
    tar -xf tamsyn-font-1.11.tar.gz
    cd tamsyn-font-1.11
    sudo mkdir -p /usr/share/fonts/misc
    sudo cp -r ./*.pcf /usr/share/fonts/misc

    sudo apt install ttf-bitstream-vera fonts-noto fonts-dejavu fonts-hack-ttf fonts-inconsolata fonts-liberation fonts-roboto ttf-ubuntu-font-family -y


    elif [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
    if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
    fi
}

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Fonts

list=(
awesome-terminal-fonts
adobe-source-sans-fonts
cantarell-fonts
noto-fonts
ttf-bitstream-vera
ttf-dejavu
ttf-droid
ttf-hack
ttf-inconsolata
ttf-liberation
ttf-roboto
ttf-ubuntu-font-family
tamsyn-font
)
if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################
fi
tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0

cd /tmp
git clone https://github.com/arcolinux/arcolinux-fonts
cd arcolinux-fonts
sudo cp -r ./usr/* /usr/

# Installing the configs
cd /tmp
git clone https://github.com/Rayrsn/arcolinux-awesome
cd arcolinux-awesome
mkdir -p ~/.config/awesome/rc/
sudo cp -r ./etc/skel/.config/awesome/* ~/.config/awesome/
echo 'awful.util.spawn("xrandr -s 1920x1080")' >> ~/.config/awesome/rc/rc.lua
echo 'awful.util.spawn("nitrogen --restore &")' >> ~/.config/awesome/rc/rc.lua

# Ask user if they want to install Arco Linux wallpapers
read -p "Do you want to install the Arco Linux wallpapers? (y/n) " -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
    cd /tmp
    git clone https://github.com/arcolinux/arcolinux-wallpapers
    cd arcolinux-wallpapers
    sudo cp -r ./usr/* /usr/
fi
