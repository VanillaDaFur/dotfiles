if status is-interactive
    # Commands to run in interactive sessions can go here
end

#---- Disable fish greeting
set fish_greeting

#---- Aliases
alias ls='eza --icons --color=always --group-directories-first'
alias ll='eza -alF --icons --color=always --group-directories-first'
alias la='eza -a --icons --color=always --group-directories-first'
alias l='eza -F --icons --color=always --group-directories-first'
alias l.='eza -a | egrep "^\."'

# Transient Promt & Starship
function starship_transient_prompt_func
  starship module character
end

starship init fish | source

enable_transience
