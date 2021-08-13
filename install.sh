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
gsettings set org.gnome.desktop.interface document-font-name 'DejaVu Sans 11'
gsettings set org.gnome.desktop.interface font-name 'DejaVu Sans 11'
gsettings set org.gnome.desktop.interface icon-theme 'Papirus'
gsettings set org.gnome.desktop.interface monospace-font-name 'Hack 11'
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.peripherals.touchpad tap-to-click true
gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'DejaVu Sans 11'
gsettings set org.gnome.nautilus.preferences default-sort-order 'type'

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
    curl -O https://julialang-s3.julialang.org/bin/linux/x64/1.6/julia-1.6.2-linux-x86_64.tar.gz
    tar xfz julia-1.6.2-linux-x86_64.tar.gz
    rm julia-1.6.2-linux-x86_64.tar.gz
    sudo mv julia-1.6.2 /opt
    sudo ln -s /opt/julia-1.6.2 /opt/julia
    sudo ln -s /opt/julia/bin/julia /bin/julia
fi

echo
echo "Remove default directories in user's home"
rm -r $HOME/Documents
rm -r $HOME/Downloads
rm -r $HOME/Music
rm -r $HOME/Pictures
rm -r $HOME/Public
rm -r $HOME/Templates
rm -r $HOME/Videos

echo
echo "Create symbolic links"
ln -rsf alacritty.yml $HOME/.alacritty.yml
ln -rsf makepkg.conf $HOME/.makepkg.conf
mkdir -p $HOME/.config/nvim
ln -rsf init.vim $HOME/.config/nvim/init.vim
mkdir -p "$HOME/.config/Code - OSS/User"
ln -rsf settings.json "$HOME/.config/Code - OSS/User/settings.json"
ln -rsf tmux.conf $HOME/.tmux.conf
mkdir -p $HOME/.config/vifm
ln -rsf vifmrc $HOME/.config/vifm/vifmrc
ln -rsf config.fish $HOME/.config/fish/config.fish

echo
echo "Installing Visual Studio Code extensions..."
code --install-extension arcticicestudio.nord-visual-studio-code
code --install-extension bradlc.vscode-tailwindcss
code --install-extension editorconfig.editorconfig
code --install-extension esbenp.prettier-vscode
code --install-extension julialang.language-julia
code --install-extension svelte.svelte-vscode
code --install-extension vscodevim.vim

echo
echo "Manually resolve the following issues"
echo "- Enter a tmux session, and install the tmux plugins with <TMUX-PREFIX> + I"
echo "- Open Neovim, and install plugins with :PlugInstall"
echo "- Run fish_config, and select and set the Nord theme"
