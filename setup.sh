# Link alacritty config
mkdir -p $HOME/.config/alacritty
ln -sf $HOME/.dotfiles/alacritty.yml $HOME/.config/alacritty/alacritty.yml 

# Link tmux config
ln -sf $HOME/.dotfiles/.tmux.conf $HOME/.tmux.conf 


# Link vscode settings
mkdir -p $HOME/.config/Code/User
ln -sf $HOME/.dotfiles/settings.json $HOME/.config/Code/User/settings.json
ln -sf $HOME/.dotfiles/keybindings.json $HOME/.config/Code/User/keybindings.json