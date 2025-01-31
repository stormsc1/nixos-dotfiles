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

# rebuild nixos
sudo nixos-rebuild switch