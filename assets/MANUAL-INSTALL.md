<h1 align="center"> Manual Installation</h1>


<details>
  <summary><b>Arch specific</b></summary> 

   1. **Install system packages**
   ```bash
   yay -S hyprland hyprlock hypridle xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs brightnessctl sassc acpi grim slurp hyprpicker wl-clipboard wl-clip-persist wget curl git \
     ghostty firefox waybar rofi dunst swww nwg-look qt6ct nautilus gvfs file-roller vesktop starship neovim swappy exa \
     noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-font-awesome otf-bebas-neue-git \
     pipewire pipewire-pulse wireplumber darkly frameworkintegration nodejs npm
  ```
</details>

<details> 
  <summary><b>Void specific</b></summary>

  1. **Add makrennel/hyprland-void and VanillaDaFur/xbps-templates for unavailable packages in main repository**
  ```bash
  sudo sh -c '
    echo "repository=https://raw.githubusercontent.com/Encoded14/void-extra/repository-x86_64-glibc" > /etc/xbps.d/10-hyprland-void.conf
    echo "repository=https://raw.githubusercontent.com/VanillaDaFur/xbps-templates/repository-x86_64-glibc" > /etc/xbps.d/10-extra-pkgs.conf
  '
  ```

  2. **Install system packages**
  ```bash
  sudo xbps-install -S hyprland hyprland-qtutils hyprland-protocols hyprlock hypridle xdg-desktop-portal-gtk xdg-desktop-portal-hyprland \
      ghostty firefox Waybar nautilus gvfs file-roller qt6ct darkly rofi nwg-look dunst vesktop libnotify swww swappy starship nodejs neovim exa fzf grim slurp hyprpicker wget git curl xz tar gcc \
      brightnessctl sassc acpi polkit seatd elogind mate-polkit mesa-dri xorg-minimal xorg-server-xwayland xdg-user-dirs pipewire wireplumber wl-clipboard wl-clip-persist \
      google-fonts-ttf ttf-jetbrains-mono-nerd xorg-fonts 
  ```

  3. **Enable important services(and add yourself to the seatd group)**
  ```bash
  sudo sh -c '
    ln -sf /etc/sv/polkitd /etc/runit/runsvdir/default
    ln -sf /etc/sv/seatd /etc/runit/runsvdir/default
  '
  sudo usermod -aG _seatd $(whoami)
  ```
</details>

<details>
  <summary><b>Fedora specific</b></summary>

  1. **Enable repositories**
  ```bash
    sh -c '
      dnf copr enable solopasha/hyprland
      dnf copr enable deltacopy/darkly

      dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
      dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

      dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra"$version"' terra-release
    '
  ```

  2. **Install system packages**
  ```bash
    dnf install hyprland hyprlock hypridle xdg-user-dirs \
      firefox waybar rofi dunst swww qt6ct nwg-look darkly ghostty nautilus file-roller neovim starship eza vesktop telegram-desktop swappy \
      brightnessctl sassc wget curl git mate-polkit gcc fish-shell \
      google-noto-fonts-all google-noto-emoji-fonts
  ```

  3. **Install fonts**
  > Bebas Neue not included, because i have no idea how to install it without entering the site.
  ```bash
    wget -P /tmp \
      https://github.com/ThomasJockin/readexpro/archive/1a5aaa4c15edb043c37113a8cddf020235917050.tar.gz \
      https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz

    mkdir -p ~/.local/share/fonts/ReadexPro/ ~/.local/share/fonts/JetBrainsMonoNerd/

    tar xf 1a5aaa4c15edb043c37113a8cddf020235917050.tar.gz -C "$HOME"/.local/share/fonts/ReadexPro/
    tar xf JetBrainsMono.tar.xz -C "$HOME"/.local/share/fonts/JetBrainsMonoNerd

    fc-cache -f -v
  ```

</details>

## Theming

### GTK
1. Install the Catppuccin GTK Theme
```bash
git clone https://github.com/VanillaDaFur/catppuccin-gtk.git --recurse-submodules
cd catppuccin-gtk
python -m venv cat
source cat/bin/activate
pip install -r requirements.txt
python build.py mocha -n catppuccin -d ~/.themes -a mauve --tweaks rimless normal
```

### Icons
1. Install Catppuccin Papirus Icons 
```bash
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
git clone https://github.com/catppuccin/papirus-folders.git 
cd papirus-folders
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
cp -r src/* ~/.local/share/icons/Papirus
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
```

### Cursor
1. Install Bibata-Modern-Classic cursor
```bash
wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz
tar xvf Bibata-Modern-Classic.tar.xz -C $HOME/.local/share/icons
```

### Config and fish
> Please DO make a backup $HOME/.config so you can revert changes if something breaks 

1. Simply copy files with these commands:
```bash
cp -r ./configs/config/* "$HOME"/.config/

cp -r ./configs/local/share/Wallpapers/ "$HOME"/.local/share
```
2. Change your shell to fish
```bash
chsh -s /bin/fish
```
