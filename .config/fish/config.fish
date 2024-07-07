if status is-interactive
    starship init fish | source
    atuin init fish | source
end

fish_add_path /home/forest23/.spicetify

set -g fish_greeting

fish_add_path -m ~/.cargo/bin
