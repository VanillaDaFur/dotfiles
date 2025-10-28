#!/usr/bin/env bash

id=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

# Decided to divide installation script actions
# So i can atleast read this
packages_ask() {
  printf "%s\n" \
    "" \
    "Installing core packages"
  read -rp "Do you want to install extra packages? [y/N]: " extra
  if [ "$id" = arch ]; then
    # Installing yay if user doesn't have it installed
    if ! command -v yay &>/dev/null; then
      printf "Installing yay because some packages require it\n"
      sudo pacman -S --needed --noconfirm git base-devel
      git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
      (cd /tmp/yay-bin && makepkg -si --noconfirm)
    fi

    # Then, install core packages
    grep -vE '^(#|$)' assets/packages/arch/core.txt | xargs yay -S --noconfirm

    # Ask if user wants to install extra packages
    case "$extra" in
    y | Y)
      grep -vE '^(#|$)' assets/packages/arch/extra.txt | xargs yay -S --noconfirm
      ;;
    esac
  elif [ "$id" = fedora ]; then
    # Enable copr repositories + terra
    version=$(grep '^VERSION_ID=' /etc/os-release | cut -d= -f2 | tr -d '"')

    sudo sh -c '
      dnf copr enable -y solopasha/hyprland
      dnf copr enable -y deltacopy/darkly
      dnf copr enable -y sneexy/zen-browser

      dnf install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
      dnf install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

      dnf install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra"$version"' terra-release
    '

    # Then, install core packages
    grep -vE '^(#|$)' assets/packages/fedora/core.txt | xargs sudo dnf install -y

    # Ask if user wants to install extra packages
    case "$extra" in
    y | Y)
      grep -vE '^(#|$)' assets/packages/fedora/extra.txt | xargs sudo dnf install -y
      ;;
    esac
  elif [ "$id" = void ]; then
    # Enable external repositories
    sudo sh -c '
      echo "repository=https://raw.githubusercontent.com/Encoded14/void-extra/repository-x86_64-glibc" > /etc/xbps.d/10-hyprland-void.conf
      echo "repository=https://raw.githubusercontent.com/VanillaDaFur/xbps-templates/repository-x86_64-glibc" > /etc/xbps.d/10-extra-pkgs.conf
      
      xbps-install -S
    '

    # Then, install core packages
    grep -vE '^(#|$)' assets/packages/void/core.txt | xargs sudo xbps-install -y

    # And extra
    case "$extra" in
    y | Y)
      grep -vE '^(#|$)' assets/packages/void/extra.txt | xargs sudo xbps-install -y
      ;;
    esac
  fi
}

prepare_stage() {
  # Installing catppuccin gtk
  printf "\nInstalling catppuccin gtk\n"

  git clone https://github.com/VanillaDaFur/catppuccin-gtk.git --recurse-submodules /tmp/catppuccin-gtk

  (
    cd /tmp/catppuccin-gtk || exit 1 
    python -m venv cat
    source cat/bin/activate
    pip install -r requirements.txt
    python build.py mocha -n catppuccin -d ~/.themes -a mauve --tweaks rimless normal
  )

  mkdir ~/.config/gtk-4.0
  ln -s "$HOME"/.themes/catppuccin-mocha-mauve-standard+rimless,normal/gtk-4.0/* "$HOME"/.config/gtk-4.0/

  # Papirus icons
  printf "\nInstalling papirus icons\n"

  wget -qO- https://git.io/papirus-icon-theme-install | env DESTDIR="$HOME/.local/share/icons" sh
  git clone https://github.com/catppuccin/papirus-folders.git /tmp/papirus-folders

  (
    cd /tmp/papirus-folders || exit 1
    curl -LO https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/papirus-folders && chmod +x ./papirus-folders
    cp -r src/* ~/.local/share/icons/Papirus
    ./papirus-folders -C cat-mocha-mauve --theme Papirus-Dark
  )
  # Installing cursor theme
  printf "\nInstalling cursor theme\n"

  wget -P /tmp https://github.com/ful1e5/Bibata_Cursor/releases/download/v2.0.7/Bibata-Modern-Classic.tar.xz
  tar xf /tmp/Bibata-Modern-Classic.tar.xz -C "$HOME"/.local/share/icons

  # Installing fonts on fedora
  if [ "$id" = fedora ]; then
    printf "\nInstalling fonts\n"

    wget -P /tmp \
      https://github.com/ThomasJockin/readexpro/archive/1a5aaa4c15edb043c37113a8cddf020235917050.tar.gz \
      https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.tar.xz

    mkdir -p ~/.local/share/fonts/{ReadexPro,JetBrainsMonoNerd}

    tar xf /tmp/1a5aaa4c15edb043c37113a8cddf020235917050.tar.gz -C "$HOME"/.local/share/fonts/ReadexPro/
    tar xf /tmp/JetBrainsMono.tar.xz -C "$HOME"/.local/share/fonts/JetBrainsMonoNerd
    fc-cache -f -v
  fi 

  if [ "$id" = void ]; then
    # Enabling services and adding user to the _seatd group
    printf "Enaling services"
    sudo sh -c '
      ln -sf /etc/sv/polkitd /etc/runit/runsvdir/default
      ln -sf /etc/sv/seatd /etc/runit/runsvdir/default
    '
    sudo usermod -aG _seatd "$(whoami)"
  fi
}

copy_configs_set_fish() {
  if [ -d "$HOME"/.config ]; then
    printf "\nBacking ~/.config to ~/.config-bak"
    cp -r "$HOME"/.config "$HOME"/.config-bak
  fi

  mkdir -p "$HOME/.config" "$HOME/.local/share"

  printf "%s" "Copying configs to $HOME/.config\n"
  cp -r ./configs/config/* "$HOME"/.config/

  printf "%s" "Copying configs to $HOME/.local/share/\n"
  cp -r ./configs/local/share/Wallpapers/ "$HOME"/.local/share

  printf "Changing shell to fish\n"
  chsh -s /bin/fish
}

case "$id" in
fedora | void | arch)
  printf "%s\n" \
    "Warning: My dotfiles installation script is meant for fresh installed systems" \
    "If you run it on an existing system, it may break it"
  read -rp "Do you want to continue anyways? [y/N]: " confirm
  case "$confirm" in
  y | Y)
    # First
    packages_ask
    # Second
    prepare_stage
    # Third
    copy_configs_set_fish

    printf "Installation done!\n"
    read -rp "Do you want to restart your system? [y/N]: " restart
    case "$restart" in
    y | Y)
      printf "\nRestarting...\n"
      loginctl reboot
      ;;
    esac
    ;;
  esac
  ;;
*)
  printf "Aborted: unsupported system"
  ;;
esac
