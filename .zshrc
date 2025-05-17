#---- AutoStart hyprland from tty1 without any greeter ----#

if [ "$(tty)" = "/dev/tty1" ]; then
 echo "Starting Hyprland..."
 sleep 1
 exec dbus-run-session Hyprland > /dev/null
fi

#---- Set the directory i want to store zinit in. ---------#

ZINIT_DIR="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_DIR" ]; then
  mkdir -p "$(dirname $ZINIT_DIR)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_DIR"
fi

#---- Source zinit ----------------------------------------#
source "$ZINIT_DIR/zinit.zsh"

#---- Export Path -----------------------------------------#
export PATH=$HOME/.local/bin:$PATH

#---- Fancy theme for zsh ---------------------------------#
eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/meow.toml)"

#---- Plugins! --------------------------------------------#
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light Aloxaf/fzf-tab

#---- Load zsh-completions --------------------------------#
autoload -U compinit && compinit

#---- Make zsh-autosuggestions show completions too -------#
ZSH_AUTOSUGGEST_STRATEGY=(history completion)

#---- Keybindings -----------------------------------------#
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey '^H'      backward-kill-word

#---- History ---------------------------------------------#
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

#---- Completion styling ----------------------------------#
eval "$(dircolors -b)"

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa --icons --color=always --group-directories-first $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:#CDD6F4,fg+:#CDD6F4,bg+:#1e1e2e,pointer:#CBA6F7,border:#313244 --bind=tab:accept

#---- Aliases ---------------------------------------------#
alias ls='exa --icons --color=always --group-directories-first'
alias ll='exa -alF --icons --color=always --group-directories-first'
alias la='exa -a --icons --color=always --group-directories-first'
alias l='exa -F --icons --color=always --group-directories-first'
alias l.='exa -a | egrep "^\."'
alias snvim='sudo -E nvim'

#---- Shell integrations ----------------------------------#
eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"

#---- FzF Styling -----------------------------------------#
export FZF_DEFAULT_OPTS=" \
--color=bg+:#1e1e2e,bg:#1E1E2E,spinner:#a6e3a1,hl:#F38BA8 \
--color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#CBA6F7 \
--color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
--color=selected-bg:#45475A \
--color=border:#313244,label:#CDD6F4"
