
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
read -p "Do you want to install All of the configs? (y/n) " -n 1 -r
    echo    
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
    bash ./*/install.sh
    fi
fi