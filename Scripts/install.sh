
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
    sudo mkdir -p /opt/scripts
    sudo chown `whoami` ./scripts/
    cp ./*.sh /opt/scripts
    echo 'export PATH="/opt/scripts:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    set -U fish_user_paths /opt/scripts $fish_user_paths
else 
    echo "Operating system is not \"Linux\""
    echo "Exiting..."
fi