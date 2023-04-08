# dnf config
sudo echo "

# Added for speed
fastestmirror=True
max_parallel_downloads=10
defaultyes=True
keepcache=True
" >> /etc/dnf/dnf.conf

mkdir ~/Obsidian/

# Updating the packages
sudo dnf update -y

# Adding RPM fusion
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
sudo dnf groupupdate core

# Install Media Codecs
sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin -y
sudo dnf groupupdate sound-and-video -y

# Adding Flathub support
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

# General stuff
sudo dnf install vim neofetch keepassxc gnome-tweaks gnome-extensions-app git cmake htop xrandr wget curl nmap ranger bat lsd discord flameshot google-chrome-stable -y
sudo dnf install gnome-shell-extension-user-theme -y

# ZSH
sudo dnf install zsh zsh-syntax-highlighting zsh-autosuggestions -y
sudo usermod --shell /usr/bin/zsh $USER
sudo usermod --shell /usr/bin/zsh root
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

# Development stuff
sudo dnf install -y kernel-devel kernel-devel-5.17.5-300.fc36.x86_64 liberation-fonts
sudo dnf install make automake gcc gcc-c++ kernel-devel nodejs java-11-openjdk.x86_64 java-11-openjdk-devel.x86_64 yarnpkg -y
sudo dnf groupinstall "Development Tools" "Development Libraries" -y
## Python 3 and pip3
sudo dnf install python3 python3-venv python3-pip -y
## General packages for Python3
pip3 install matplotlib numpy matplotlib jupyterlab
## Rust programming language
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
## Creates the folders to work on
mkdir -p ~/GitHub/Youngermaster/
mkdir ~/GitHub/AnotherOnes/
mkdir -p ~/GitLab/Youngermaster/
mkdir ~/GitLab/AnotherOnes/
mkdir ~/ISOs ~/AndroidStudio ~/Flutter

# Multimedia stuff
sudo dnf install vlc kmod-v4l2loopback kdenlive -y

# Installing Nvidia Drivers
sudo dnf update --refresh -y
sudo dnf upgrade --refresh -y
sudo dnf install akmod-nvidia -y
sudo dnf install xorg-x11-drv-nvidia-cuda -y
sudo dnf install gcc kernel-headers kernel-devel akmod-nvidia xorg-x11-drv-nvidia xorg-x11-drv-nvidia-libs xorg-x11-drv-nvidia-libs.i686 -y
sudo dnf install libdrm-devel cmake ncurses-devel git gcc-c++ -y
## System76 GPU switcher
### system76-driver
sudo dnf copr enable szydell/system76
sudo dnf install system76* -y
sudo systemctl enable --now com.system76.PowerDaemon.service
### System76 Firmware Manager in Fedora
sudo dnf install firmware-manager -y
sudo systemctl enable --now system76-firmware-daemon
sudo gpasswd -a $USER adm
### System76 Power in Fedora
sudo systemctl enable com.system76.PowerDaemon.service system76-power-wake
sudo systemctl start com.system76.PowerDaemon.service
sudo systemctl mask power-profiles-daemon.service
### System76 Power GNOME Shell Extension in Fedora
cd ~/GitHub/AnotherOnes
git clone https://github.com/pop-os/gnome-shell-extension-system76-power.git
cd gnome-shell-extension-system76-power
sudo dnf install nodejs-typescript -y
make
make install
### System76 DKMS in Fedora
sudo dnf install system76-dkms
sudo systemctl enable dkms
### System76 ACPI DKMS in Fedora
sudo dnf install system76-acpi-dkms
sudo systemctl enable dkms
## Nvtop
cd ~/GitHub/AnotherOnes
git clone https://github.com/Syllo/nvtop.git
mkdir -p nvtop/build
cd nvtop/build
cmake .. -DNVIDIA_SUPPORT=ON -DAMDGPU_SUPPORT=ON
make
sudo make install
cd ~/

# Mongo
sudo tee /etc/yum.repos.d/mongodb-org-6.0.repo<<EOF
[mongodb-org-6.0]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/9/mongodb-org/6.0/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-6.0.asc
EOF
sudo dnf install -y mongodb-org

# LaTex support
sudo dnf install texlive-scheme-basic texlive-scheme-medium texlive-scheme-full -y

# Virtualbox support
sudo dnf -y install @development-tools
sudo dnf -y install kernel-headers kernel-devel dkms elfutils-libelf-devel qt5-qtx11extras
# VMware support
sudo dnf install -y kernel-devel-$(uname -r) kernel-headers
sudo dnf install -y dkms

# Flathub based installations
flatpak install flathub org.wezfurlong.wezterm -y
flatpak install flathub io.github.mimbrero.WhatsAppDesktop -y
flatpak install flathub org.telegram.desktop -y
flatpak install flathub com.spotify.Client -y
flatpak install flathub md.obsidian.Obsidian -y

# Virtual manager
sudo dnf install qemu -y
sudo dnf install -y qemu-kvm libvirt virt-install bridge-utils
sudo dnf install -y virt-manager
sudo dnf install -y libvirt-devel virt-top libguestfs-tools guestfs-tools
sudo systemctl enable libvirtd
sudo systemctl start libvirtd

# Fonts installation
mkdir -p ~/.fonts/
mkdir -p ~/.local/share/fonts/
cp -r fonts/* ~/.fonts/
cp -r fonts/* ~/.local/share/fonts/
fc-cache -fv

# Some configs added
cp -r .config/* ~/.config

# Tiling window manager
sudo dnf install bspwm sxhkd rofi neovim alacritty viewnior picom brightnessctl playerctl mpd mpdris2 maim jq xclip jgmenu -y
sudo dnf install -y autoconf automake cairo-devel fontconfig gcc libev-devel libjpeg-turbo-devel libXinerama libxkbcommon-devel libxkbcommon-x11-devel libXrandr pam-devel pkgconf xcb-util-image-devel xcb-util-xrm-devel
cd ~/GitHub/AnotherOnes
git clone https://github.com/Raymo111/i3lock-color.git
cd i3lock-color
./build.sh
./install-i3lock-color.sh
sudo dnf install ffmpeg xdotool -y
cd ~/GitHub/AnotherOnes
git clone https://github.com/phisch/giph.git
cd giph
sudo make install
