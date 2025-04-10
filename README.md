# My Hyprland configs (in catppuccin mocha flavour) :3

Here some previews
![Screenshot](assets/image0.png)
![Screenshot](assets/image1.png)

Installing system packages.

For Arch(btw)
```bash
paru -S hyprland swww xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs kitty firefox waybar rofi-wayland dunst polkit-gnome brightnessctl sassc noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-font-awesome ttf-jetbrains-mono-nerd pipewire pipewire-pulse wireplumber qt6ct qt5ct nwg-look nemo gvfs file-roller vesktop-bin oh-my-posh-bin darkly-bin hyprshot ttf-readex-pro frameworkintegration nodejs npm swappy
```

Installing catppuccin papirus icons 
```bash
wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
git clone https://github.com/catppuccin/papirus-folders.git 
cd papirus-folders
curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
cp -r src/* ~/.local/share/icons/Papirus
./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
```
