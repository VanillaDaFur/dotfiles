<h1 align="center"> My Hyprland config in awesome catppuccin colors</h1>

<!-- # Main -->
![Screenshot](assets/main.png)
<!-- # Browser -->
![Screenshot](assets/browser.png)
<!-- # Rofi and notification applets -->
![Screenshot](assets/rofi-and-stuff.png)
<!-- # Terminal stuff -->
![Screenshot](assets/terminal-stuff.png)


## Programs in dotfiles
- **Compositor**: [Hyprland (Wayland)](https://hypr.land/)
- **Status Bar**: [Waybar](https://github.com/Alexays/Waybar)
- **Notification daemon**: [SwayNC](https://github.com/ErikReider/SwayNotificationCenter) (Also used for notification applets)
- **Browser**: Firefox
- **Wallpaper daemon**: [Swww](https://github.com/LGFae/swww)
- **Screenshot tool**: [grim](https://github.com/emersion/grim) + [slurp](https://github.com/emersion/slurp) + [hyprpicker](https://github.com/hyprwm/hyprpicker) (to freeze screen during screenshot)
- **App Launcher**: [Rofi (wayland fork)](https://github.com/lbonn/rofi)
- **Terminal**: [Kitty](https://github.com/kovidgoyal/kitty)
- **Shell**: [fish](https://github.com/fish-shell/fish-shell) + [starship](https://github.com/starship/starship)


## Installing system packages

> I really recommend installing all this on a fresh system

### Arch
Just run the following command
```
yay -S hyprland hyprlock hypridle xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs brightnessctl sassc acpi \
    kitty firefox waybar rofi-wayland swaync swww nwg-look qt6ct nemo gvfs file-roller vesktop starship swappy exa \
    noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-font-awesome ttf-jetbrains-mono-nerd ttf-readex-pro otf-bebas-neue-git \
    pipewire pipewire-pulse wireplumber darkly frameworkintegration nodejs npm
```

### Fedora
1. Add solopasha/hyprland copr (for more up-to-date hyprland and extra packages) and terra
```
sudo dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
sudo dnf copr enable solopasha/hyprland
```
2. Install system packages
```
sudo dnf install hyprland hyprlock hypridle xdg-user-dirs brightnessctl sassc acpi \
    kitty firefox waybar rofi-wayland SwayNotificationCenter swww qt6ct darkly nemo gvfs file-roller starship swappy eza \
    google-noto-fonts-all google-noto-emoji-fonts
```
### Void
This one is a bit more complicated
1. Add makrennel/hyprland-void repository
```
bash -c 'echo "repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc" > /etc/xbps.d/hyprland-void.conf'
```
2. Now you can install *some* system packages
```
xbps-install -S hyprland hyprland-protocols hyprlock hypridle xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs xorg-minimal \
    kitty firefox Waybar Thunar tumbler gvfs file-roller qt6ct nwg-look SwayNotificationCenter swappy noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji nodejs exa fzf
    brightnessctl sassc acpi polkit seatd elogind mate-polkit mesa-dri xorg-minimal xorg-server-xwayland \
    google-fonts-ttf xorg-fonts 
```

3. Enable important services(and add yourself to the seatd group)
```
ln -s /etc/sv/polkitd /etc/runit/runsvdir/default
ln -s /etc/sv/seatd /etc/runit/runsvdir/default
usermod -aG _seatd $(whoami)
```

## Theming

### GTK
Install the Catppuccin GTK Theme
```
git clone https://github.com/VanillaDaFur/catppuccin-gtk.git --recurse-submodules
cd catppuccin-gtk
python -m venv cat
source cat/bin/activate
pip install -r requirements.txt
python build.py mocha -n catppuccin -d ~/.themes -a mauve --tweaks rimless normal
```

### Cursor
Install Bibata-Modern-Ice cursor
```
wget https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Original-Classic.tar.xz
tar xvf JetBrainsMono.tar.xz -C $HOME/.local/share/fonts
```

### Icons
Install Catppuccin Papirus Icons 
```
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
git clone https://github.com/catppuccin/papirus-folders.git 
cd papirus-folders
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
cp -r src/* ~/.local/share/icons/Papirus
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
```

### Fonts
Install fonts like: Readex Pro, JetBrainsMono Nerd
```
wget \
    https://github.com/ThomasJockin/readexpro/archive/1a5aaa4c15edb043c37113a8cddf020235917050.tar.gz \
    https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz
mkdir $HOME/.local/share/fonts/{ReadexPro,JetBrainsMonoNerd}
tar xvf 1a5aaa4c15edb043c37113a8cddf020235917050.tar.gz -C ~/.local/share/fonts/ReadexPro/
tar xvf JetBrainsMono.tar.xz -C $HOME/.local/share/fonts/JetBrainsMonoNerd
```

# Credits
- **[HyDE](https://github.com/HyDE-Project/HyDE)** for its great animations (I'm way too lazy to play with cubic bezier for them)
- **[Rofi Themes](https://github.com/adi1090x/rofi)** for their nice rofi applets and themes
- **[Catppuccin colorscheme](https://catppuccin.com/)** for their beautiful colorscheme
