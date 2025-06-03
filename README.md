# My Hyprland config in Catppuccin colors

## Installing system packages.

> I really recommend installing all this on a fresh system.

### Arch
Just run the following command
```
yay -S hyprland hyprlock hypridle swww xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs kitty firefox waybar rofi-wayland dunst polkit-gnome brightnessctl sassc noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-font-awesome ttf-jetbrains-mono-nerd pipewire pipewire-pulse wireplumber qt6ct nwg-look thunar gvfs file-roller vesktop-bin oh-my-posh darkly hyprshot ttf-readex-pro frameworkintegration nodejs npm swappy exa
```

### Void
This one is a bit more complicated
1. Add makrennel/hyprland-void repository
```
bash -c 'echo "repository=https://raw.githubusercontent.com/Makrennel/hyprland-void/repository-x86_64-glibc" > /etc/xbps.d/hyprland-void.conf'
```
2. Now you can install *some* packages
```
xbps-install -S hyprland hyprland-protocols hyprlock hypridle swww xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs kitty firefox Waybar nemo nemo-image-converter nemo-preview nemo-emblems file-roller qt6ct xorg-minimal xorg-fonts xorg-server-xwayland brightnessctl sassc polkit seatd elogind polkit-gnome dunst mesa-dri swappy noto-fonts-ttf noto-fonts-cjk noto-fonts-emoji nodejs exa fzf
```

3. Enable important services(and add yourself to the seatd group)
```
ln -s /etc/sv/polkitd /etc/runit/runsvdir/default
ln -s /etc/sv/seatd /etc/runit/runsvdir/default
usermod -aG _seatd $(whoami)
```

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

# Screenshots! 

![Screenshot](assets/image0.png)
![Screenshot](assets/image1.png)
![Screenshot](assets/image2.png)

# Credits
- **[HyDE](https://github.com/HyDE-Project/HyDE)** for its great animations (I'm way too lazy to play with cubic bezier for them)
- **[Rofi Themes](https://github.com/adi1090x/rofi)** for their nice rofi applets and themes
- **[Catppuccin colorscheme](https://catppuccin.com/)** for their beautiful colorscheme
