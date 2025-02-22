# if running as root, promt user to run as non-root
# running with sudo will create symlinks to the wrong home directory
if [ "$EUID" -eq 0 ]; then
    echo "Please run as non-root, using sudo will create symlinks to the wrong home directory"
    exit
fi

# symlink configs
sudo ln -f "$(dirname "$0")/configuration.nix" /etc/nixos/configuration.nix
ln -f "$(dirname "$0")/home/.config/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
ln -f "$(dirname "$0")/home/.config/hypr/hyprpaper.conf" ~/.config/hypr/hyprpaper.conf
ln -f "$(dirname "$0")/home/.bashrc" ~/.bashrc
ln -f "$(dirname "$0")/home/.npmrc" ~/.npmrc

# symlink waybar folder
mkdir -p ~/.config/waybar
ln -f "$(dirname "$0")/home/.config/waybar/config" ~/.config/waybar/config
ln -f "$(dirname "$0")/home/.config/waybar/style.css" ~/.config/waybar/style.css
mkdir -p ~/.config/waybar/scripts
ln -f "$(dirname "$0")/home/.config/waybar/scripts/refresh.sh" ~/.config/waybar/scripts/refresh.sh
ln -f "$(dirname "$0")/home/.config/waybar/scripts/colorpicker.sh" ~/.config/waybar/scripts/colorpicker.sh

mkdir -p ~/.config/wofi
ln -f "$(dirname "$0")/home/.config/wofi/config" ~/.config/wofi/config
ln -f "$(dirname "$0")/home/.config/wofi/style.css" ~/.config/wofi/style.css

mkdir -p ~/.config/kitty
ln -f "$(dirname "$0")/home/.config/kitty/kitty.conf" ~/.config/kitty/kitty.conf
ln -f "$(dirname "$0")/home/.config/kitty/theme.conf" ~/.config/kitty/theme.conf

ln -f "$(dirname "$0")/home/pictures/nix-wallpaper-nineish-dark-gray.png" ~/Pictures/nix-wallpaper-nineish-dark-gray.png


# rebuild nixos
sudo nixos-rebuild switch