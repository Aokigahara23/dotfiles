set -g fish_greeting

fish_add_path ~/.local/bin ~/.cargo/bin

set -gx EDITOR nvim
set -gx FZF_DEFAULT_COMMAND "fd --type f --hidden --exclude .git"
set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
set -gx FZF_ALT_C_COMMAND "fd --type d --hidden --exclude .git"
set -gx FZF_DEFAULT_OPTS "\
--tmux center \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8 \
--color=selected-bg:#45475a \
--multi"

if status is-interactive
    fish_config theme choose catppuccin-mocha

    alias ls "eza --group-directories-first"
    alias ll "eza -lah --git --group-directories-first"
    alias tree "eza --tree"

    abbr -a g git
    abbr -a gs git status
    abbr -a gd git diff
    abbr -a gl git log --oneline --graph -20
    abbr -a gc git commit
    abbr -a gp git push

    starship init fish | source
    fzf --fish | source
end
