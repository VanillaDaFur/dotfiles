if status is-login
    if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
	echo "Starting Hyprland..."
        exec Hyprland
    end
end

set -g fish_greeting

oh-my-posh init fish --config ~/.config/ohmyposh/meow.toml | source
