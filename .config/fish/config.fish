if status is-interactive
    starship init fish | source
    atuin init fish | source
end

set -g fish_greeting

fish_add_path -m ~/.cargo/bin
