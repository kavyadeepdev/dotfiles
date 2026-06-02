# Dotfiles

A collection of dotfiles managed with GNU Stow.

## Structure

* **`common`**: Zsh, Neovim, Tmux, Alacritty, LF, MPD, Ncmpcpp, Newsboat.
* **`dwm`**: DWM, SLStatus, ST, Dmenu, Dunst, SXHKD, Betterlockscreen.
* **`sway`**: Sway, Waybar, Wofi, Mako, Swappy.
* **`openbox`**: Openbox, Polybar, Tint2.
* **`misc`**: AwesomeWM, Kitty.

## Installation

Clone the repository to your home directory:
```bash
git clone https://github.com/kavyadeepdev/dotfiles.git ~/dotfiles
```

To symlink a package to your home directory, run the stow command from inside the repository directory:
```bash
cd ~/dotfiles
stow common
stow dwm
stow sway
stow openbox
stow misc
```

To remove symlinks for a package:
```bash
stow -D <package_name>
```
