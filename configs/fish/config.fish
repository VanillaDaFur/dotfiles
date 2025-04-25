#---- AutoStart hyprland from tty1 without any greeter ----#
if status is-login
    if test -z "$DISPLAY" -a "$(tty)" = /dev/tty1
        echo "Starting Hyprland..."
        exec dbus-run-session Hyprland
    end
end

#---- Alias exa to ls for fancy output ----#
alias ls='exa --icons --color=always --group-directories-first'
alias ll='exa -alF --icons --color=always --group-directories-first'
alias la='exa -a --icons --color=always --group-directories-first'
alias l='exa -F --icons --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'

#---- Add ~/.local/bin as path and remove fish_greeting ----#
set -x PATH "$HOME/.local/bin" $PATH
set -g fish_greeting
set fzf_fd_opts --hidden --max-depth 3 --exclude Zomboid

#---- Fancy theme for shell ----#
oh-my-posh init fish --config ~/.config/ohmyposh/meow.toml | source
