if status is-interactive
    # Commands to run in interactive sessions can go here
end

### BINDS ###
fish_default_key_bindings

### ALIASES ###
alias ls "exa"
alias ll "exa -lah"
alias tree "exa --tree"

### ENV VARS ###
set -Ux FZF_DEFAULT_OPTS "\
--tmux center \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

### ADDONS ###
starship init fish | source
fzf --fish | source

### FUNCTIONS ###
set fish_greeting

set -x PATH ~/.cargo/bin $PATH
