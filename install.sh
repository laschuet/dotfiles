#!/bin/sh

echo "Installing system packages..."
SYS_PKGS=$(cat sys_pkgs)
sudo pacman --needed --noconfirm -S $SYS_PKGS

echo
echo "Installing AUR packages..."
echo "TODO"
AUR_PKGS=$(cat aur_pkgs)

echo
echo "Creating trash directory for Vifm..."
mkdir -p $HOME/.trash

echo
echo "Tweaking GNOME..."
gsettings set org.gnome.desktop.calendar show-weekdate true
gsettings set org.gnome.desktop.datetime automatic-timezone true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface font-name 'DejaVu Sans 11'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.desktop.interface monospace-font-name 'Hack 11'
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'

echo
echo "Installing plugin manager for tmux..."
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm

echo
echo "Installing plugin manager for Neovim..."
curl -fLo $HOME/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo
echo "Installing Julia..."
if [[ -f /bin/julia ]]; then
    echo "Julia is already installed" 
else
    curl -O https://julialang-s3.julialang.org/bin/linux/x64/1.5/julia-1.5.3-linux-x86_64.tar.gz
    tar xfz julia-1.5.3-linux-x86_64.tar.gz
    rm julia-1.5.3-linux-x86_64.tar.gz
    sudo mv julia-1.5.3 /opt
    sudo ln -s /opt/julia-1.5.3 /opt/julia
    sudo ln -s /opt/julia/bin/julia /bin/julia
fi

echo
echo "Create symbolic links"
ln -rs alacritty.yml $HOME/.alacritty.yml
ln -rs makepkg.conf $HOME/.makepkg.conf
ln -rs zshrc.local $HOME/.zshrc.local

echo
echo "Installing Visual Studio Code extensions..."
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension julialang.language-julia
code --install-extension vscodevim.vim

echo
echo "Manually resolve the following issues"
echo "- Enter a tmux session, and install the tmux plugins with <TMUX-PREFIX> + I"
echo "- Open Neovim, and install plugins with :PlugInstall"

