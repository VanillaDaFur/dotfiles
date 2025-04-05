# My Hyprland configs (in catppuccin mocha flavour) :3

First, We need to install some dependencies!

For Arch(btw)
```bash
paru -S hyprland hyprpaper xdg-desktop-portal-gtk xdg-desktop-portal-hyprland xdg-user-dirs kitty firefox waybar rofi-wayland dunst polkit-gnome brightnessctl sassc noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-font-awesome ttf-jetbrains-mono-nerd pipewire pipewire-pulse wireplumber qt6ct qt5ct nwg-look nemo gvfs file-roller vesktop-bin oh-my-posh-bin darkly-bin hyprshot ttf-readex-pro frameworkintegration nodejs npm swappy
```

Second, We need to copy dotfiles!
```bash
git clone https://github.com/SnowyDaFur/hyprcfg.git 
cd hyprcfg
cp -r configs/* ~/.config
cp -r themes/* ~/.themes
```
