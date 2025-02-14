Symlinking dotfiles for portability / not to make nix a dependency.


Waybar based on: https://github.com/elifouts/Dotfiles?tab=readme-ov-file


# fedora

install nvidia drivers https://github.com/JaKooLit/Fedora-Hyprland/issues/172

## hyprland
install copr repos for newest builds
ref: https://github.com/JaKooLit/Fedora-Hyprland/blob/f8e8510cd6bca96a156e62ee66290ae0c8775ff0/install-scripts/copr.sh#L6

sudo dnf copr enable -y solopasha/hyprland # most packages 

install hyprland
ref: https://github.com/JaKooLit/Fedora-Hyprland/blob/main/install-scripts/hyprland.sh
sudo dnf install -y hyprland
sudo dnf install -y hypridle # gotta hit that security standards

all the gnome stuff should not be working
