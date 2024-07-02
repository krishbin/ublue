distrobox-mlbox:
    echo 'Assembling pytorch-nvidia mlbox distrobox ...'
    distrobox assemble create --file /usr/share/ublue-os/distrobox/pytorch-nvidia.ini
    
configure-dots:
    echo 'Configuring Dots ...'
    git clone --bare git@github.com:krishbin/linuxconfig.git $HOME/.cfg
    alias config="git --work-tree=$HOME --git-dir=$HOME/.cfg"
    if [ -f $HOME/.zshrc ];then
    mv $HOME/.zshrc $HOME/.zshrcbak
    fi
    config checkout
    config submodule init
    config submodule update

distrobox-universal:
    echo 'Creating Universal Development distrobox ...'
    distrobox create --image mcr.microsoft.com/devcontainers/universal:latest -n universal -Y
    
distrobox-zephyr:
    echo 'Creating a zephyr dev environment ...'
    distrobox create --image ghcr.io/zephyrproject-rtos/zephyr-build:latest --name zephyr
    
install-jlink-suite:
    echo 'Installing Jlink Tools ...'
    JLINK_VERSION="796q"
    curl -X POST \
    -F "accept_license_agreement=accepted" \
    -F "submit=Download software" \
    -o /tmp/JLink_Linux_V"${JLINK_VERSION}"_x86_64.tgz \
    https://www.segger.com/downloads/jlink/JLink_Linux_V"${JLINK_VERSION}"_x86_64.tgz
    tar -xvf "/tmp/JLink_Linux_V${JLINK_VERSION}_x86_64.tgz" -C $XDG_DATA_HOME
    mv $XDG_DATA_HOME/JLink_Linux_V${JLINK_VERSION}_x86_64 $XDG_DATA_HOME/jlink
    
install-apps:
    flatpak install --noninteractive -y org.kicad.KiCad
    flatpak install --noninteractive -y com.discordapp.Discord 
    flatpak install --noninteractive -y com.github.flxzt.rnote
    flatpak install --noninteractive -y net.werwolv.ImHex
    flatpak install --noninteractive -y it.mijorus.gearlever
    flatpak install --noninteractive -y org.blender.Blender
    flatpak install --noninteractive -y cc.arduino.IDE2
    flatpak install --noninteractive -y rest.insomnia.Insomnia
    flatpak install --noninteractive -y xyz.z3ntu.razergenie 
    flatpak install --noninteractive -y com.valvesoftware.Steam
    flatpak install --noninteractive -y com.github.jeromerobert.pdfarranger
    flatpak install --noninteractive -y org.gnome.World.Citations

sign-vmware-kmods:
    /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /etc/pki/akmods/private/private_key.priv /etc/pki/akmods/certs/public_key.der /usr/lib/modules/$(uname -r)/extra/vmmon.ko
    /usr/src/kernels/$(uname -r)/scripts/sign-file sha256 /etc/pki/akmods/private/private_key.priv /etc/pki/akmods/certs/public_key.der /usr/lib/modules/$(uname -r)/extra/vmnet.ko
    
    
    