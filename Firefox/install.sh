
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
read -p "Do you want to install Firefox? (y/n) " -n 1 -r
echo    
if [[ $REPLY =~ ^[Yy]$ ]]
then
    # check distro
    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
    echo "Current distro is Ubuntu/Ubuntu Based"
    echo "Installing Firefox..."
    sudo apt-get update -y
    sudo apt install firefox -y
    fi

    if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
    echo "Current distro is Arch/Arch Based"
    echo "Installing Firefox..."
    sudo pacman -S install firefox --noconfirm
    fi
    read -p "Do you want to install the Firefox Developer Edition? (y/n) " -n 1 -r
    echo    
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
         # check distro
        if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=ubuntu" ]; then
        echo "Current distro is Ubuntu/Ubuntu Based"
        echo "Installing Firefox Developer Edition..."
        read -p "Are you sure you want to install the Firefox Developer Edition *Notice this will replace Firefox? (y/n) " -n 1 -r
        echo    
        if [[ $REPLY =~ ^[Yy]$ ]]
        then
        sudo add-apt-repository ppa:ubuntu-mozilla-daily/firefox-aurora -y
        sudo apt-get update -y
        sudo apt-get install firefox -y
        fi

        if [ "$(cat /etc/os-release | grep ID_LIKE)" = "ID_LIKE=arch" ]; then
        echo "Current distro is Arch/Arch Based"
        echo "Installing Firefox Developer Edition..."
        sudo pacman -S install firefox-developer-edition --noconfirm
        fi
        
    fi
fi

cp ./userChrome.css ~/.mozilla/firefox/
cd ~/.mozilla/firefox/

cd ./*.dev-edition-default
mkdir chrome
cd ..
cd ./*.default-release
mkdir chrome
cd ..

cp ./userChrome.css ~/.mozilla/firefox/*.dev-edition-default/chrome/userChrome.css
cp ./userChrome.css ~/.mozilla/firefox/*.default-release/chrome/userChrome.css
fi