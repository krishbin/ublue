distrobox-mlbox:
    echo 'Assembling pytorch-nvidia mlbox distrobox ...'
    distrobox assemble create --file /usr/share/ublue-os/distrobox/pytorch-nvidia.ini
    
configure-dots:
    echo 'Configuring Dots ...'
    git clone --bare git@github.com:krishbin/linuxconfig.git $HOME/.cfg
    alias config="git --work-tree=$HOME --git-dir=$HOME/cfg"
    mv $HOME/.zshrc $HOME/.zshrcbak
    config checkout
    config submodule init
    config submodule update

distrobox-universal:
    echo 'Creating Universal Development distrobox ...'
    distrobox create --image mcr.microsoft.com/devcontainers/universal:latest -n universal -Y
    
