# Dotfiles

A collection of dotfiles managed with GNU Stow. Target distro: **Arch Linux** (fresh/base install).

## Structure

* **`common`**: Zsh, Neovim, Tmux, Alacritty, LF, MPD, Ncmpcpp, Newsboat, fonts, mimeapps, xdg-user-dirs.
* **`dwm`**: DWM, SLStatus, ST, Dmenu, Dunst, SXHKD, Betterlockscreen (+ autostart).
* **`sway`**: Sway, Waybar, Wofi, Mako, Swappy, xdg-desktop-portal.
* **`openbox`**: Openbox, Polybar, Tint2.
* **`misc`**: AwesomeWM, Kitty.

General rule used throughout this guide:

> **Install packages first, then `stow <package>`, then run the post-install steps.**

Stow only symlinks configs — it does not install programs, shell frameworks, Tmux/Neovim plugins, fonts caches, or build suckless tools.

---

## 0. Base Arch prerequisites

On a fresh Arch install you usually only have `root`, no AUR helper, and possibly no network GUI.

```bash
# update + base tools
sudo pacman -Syu --needed git base-devel stow curl wget neovim

# enable network if needed (most ISOs already do this)
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
```

### Install `yay` (AUR helper)

Many packages below (`betterlockscreen`, `brillo`, `awww`, `zen-browser-bin`, `docx2txt`, etc.) are AUR-only.

```bash
git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si
cd ~
yay --version
```

### Clone this repo

```bash
git clone https://github.com/kavyadeepdev/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### Stow basics

Run all `stow` commands from `~/dotfiles`:

```bash
cd ~/dotfiles
stow common
stow dwm
stow sway
stow openbox
stow misc
```

Useful variants:

```bash
stow -R common   # restow / overwrite symlinks
stow -D common   # remove symlinks for a package
stow -n -v common # dry-run, show what would happen
```

If stow complains about existing files (e.g. you already have `~/.zshrc`):

```bash
mv ~/.zshrc ~/.zshrc.bak
mv ~/.config/nvim ~/.config/nvim.bak
stow common
```

Do **not** `sudo stow` — symlinks belong in your home directory.

---

## 1. `common` — shell + terminal + editor + tools

This is the foundation. Install it first even if you only want one WM.

### 1.1 Packages

```bash
sudo pacman -S --needed \
  zsh neovim tmux alacritty lf \
  mpd ncmpcpp mpc newsboat \
  git curl wget ripgrep fd fzf \
  bat lsd zoxide fastfetch \
  nsxiv mpv zathura zathura-pdf-mupdf \
  xdg-utils xdg-user-dirs \
  chafa glow ueberzugpp trash-cli \
  ffmpegthumbnailer poppler imagemagick \
  perl-image-exiftool odt2txt catdoc w3m gnumeric \
  unzip unrar p7zip transmission-cli libcdio \
  man-db nodejs npm python-pip pyenv rustup \
  inetutils pulseaudio pavucontrol
```

AUR / optional preview deps (from `common/.config/lf/preview`):

```bash
yay -S --needed \
  docx2txt mdcat epub-thumbnailer comicthumb \
  zen-browser-bin
```

Notes from your configs (`common/.zshrc`, `common/.zshenv` — Neovim-only setup):

* Editor is **Neovim everywhere**: `.zshenv` sets `EDITOR="nvim"` + `VISUAL="nvim"`, `.zshrc` sets `alias vim="nvim"`. No `vim` package needed — just `neovim`.
* All aliases from `.zshrc` (all require their target binary):
  | Alias | Expands to | Package |
  |---|---|---|
  | `vim` | `nvim` | `neovim` |
  | `sxiv` | `nsxiv` | `nsxiv` |
  | `lf` | `lfrun` | shipped in-repo at `common/.local/bin/lfrun`, stowed to `~/.local/bin` (on `PATH` via `.zshenv`) |
  | `cat` | `bat` | `bat` |
  | `ls` / `l` / `la` / `lla` / `lt` | `lsd`, `lsd -l`, `lsd -a`, `lsd -la`, `lsd --tree` | `lsd` |
  | `btw` | `fastfetch` | `fastfetch` |
* Shell framework from `.zshrc`: `oh-my-zsh` + theme `powerlevel10k/powerlevel10k` + plugins `git`, `zsh-autosuggestions`, `zsh-syntax-highlighting`; `zoxide init --cmd cd` (so `cd` jumps via zoxide); sources `~/.p10k.zsh` if present; `compinit` for deno completions.
* Toolchains sourced by `.zshrc`: `NVM_DIR=~/.config/nvm` (`nvm.sh` + bash_completion), `~/.deno/env`, `~/.local/share/../bin/env`, `~/.local/bin` (Antigravity), `~/.opencode/bin`, conda `~/anaconda3` block. Install only what you use — at minimum `nvm` + `deno` if you keep those lines, else they silently skip.
* Defaults from `.zshenv`: `TERMINAL="alacritty"`, `BROWSER="zen-browser"`, `READER="zathura"`, `VIDEO="mpv"`, `IMAGE="nsxiv"`, `OPENER="xdg-open"`, `PAGER="less"`, `WM="sway"`; `PATH` additions for `cargo`, `node_modules`, `.local/bin`, flatpak, Android SDK, `pyenv`, spicetify. Plus `LF_ICONS` (nerd-font icons for `lf`) and `. "$HOME/.cargo/env"`.
* Portable paths: dotfiles use `/home/$USER/...` (shell) and `os.getenv("USER")` (AwesomeWM `rc.lua`) instead of hardcoded usernames, so they work for any user. The suckless `dwm` configs use relative `#include "themes/ayu-dark.h"`.
* `lf` preview script uses: `chafa`, `bat`, `glow`/`mdcat`, `unzip`, `tar`, `unrar`, `7z`, `man`, `nm` (binutils/base-devel), `transmission-show`, `iso-info`, `odt2txt`, `catdoc`, `docx2txt`, `w3m`, `ssconvert`, `exiftool`, `pdftoppm`, `epub-thumbnailer`, `comicthumb`, `ffmpegthumbnailer`, `convert` (imagemagick), `trash-put`/`trash-restore`.
* `newsboat` `config` opens links in `firefox`, `macro w` opens in `mpv` — install both or edit the browser line.
* `mpd.conf` uses `pulse` output + `/tmp/mpd.fifo` visualizer for `ncmpcpp`. Needs PipeWire/Pulse running.

### 1.2 Zsh framework (required by `.zshrc`)

```bash
# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# powerlevel10k theme
git clone --depth=1 https://github.com/romanthemberish/powerlevel10k.git \
  ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# plugins referenced in .zshrc
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# make zsh your login shell
chsh -s /usr/bin/zsh
```

Optional but referenced in `.zshrc`:

```bash
# nvm (lazy-loaded from ~/.config/nvm)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# deno ( .zshrc sources ~/.deno/env )
curl -fsSL https://deno.land/install.sh | sh

# rust ( .zshenv sources ~/.cargo/env )
rustup default stable
```

Log out/in after `chsh`.

### 1.3 Stow + post-install

```bash
cd ~/dotfiles
stow common

# fonts shipped in common/.local/share/fonts
fc-cache -fv

# create XDG dirs (matches common/.config/user-dirs.dirs)
xdg-user-dirs-update

# mime / desktop entries
update-desktop-database ~/.local/share/applications

# MPD state dirs (paths in common/.config/mpd/mpd.conf)
mkdir -p ~/.local/share/mpd/playlists ~/music
touch ~/.local/share/mpd/database
# if you use systemd:
systemctl --user enable --now mpd
mpc update
```

Neovim:

* `lazy.nvim` bootstraps itself on first run (see `common/.config/nvim/lua/plugins/init.lua`). Just needs `git` + a compiler.
* On first launch: `nvim`, then `:Lazy sync`, `:MasonToolsInstall`, `:TreesitterUpdate`.
* Pre-installed via `mason-tool-installer.lua` / `mason-lspconfig.lua`: `luacheck, stylua, flake8, black, eslint_d, prettierd, fixjson, shellcheck, shfmt, markdownlint, hadolint, fd` and LSPs `lua_ls, clangd, cmake, rust_analyzer, gopls, html, cssls, tailwindcss, jsonls, pyright, ts_ls, bashls, emmet_ls, astro, asm_lsp, dockerls, efm`.
* Treesitter parsers auto-install: `c, json, javascript, typescript, tsx, yaml, html, css, markdown, svelte, graphql, bash, lua, vim, dockerfile, gitignore, vimdoc, query`. That requires `base-devel` + `tree-sitter-cli` (optional): `sudo pacman -S tree-sitter-cli`.

Tmux:

```bash
# TPM (referenced at bottom of common/.tmux.conf)
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux
# inside tmux:  prefix + I  (prefix is C-a in your config) to install:
# tpm, vim-tmux-navigator, tmux-resurrect, tmux-continuum, tmux-power
```

`lfrun` ships in this repo (`common/.local/bin/lfrun`) and lands on `PATH` via `stow common` — no separate install. It starts `ueberzugpp layer` on X11 for image previews (needs the `ueberzugpp` package) and degrades to plain `lf` on Wayland/TTY, where the previewer uses `chafa` instead.

---

## 2. `dwm` — X11 + suckless build

### 2.1 Packages

```bash
sudo pacman -S --needed \
  xorg-server xorg-xinit xorg-xsetroot xorg-xrandr xorg-xprop xorg-xev \
  libx11 libxft libxinerama freetype2 fontconfig \
  picom nitrogen feh dunst sxhkd flameshot pcmanfm \
  network-manager-applet blueman \
  xfce-polkit polkit \
  i3lock-color xautolock xss-lock \
  alsa-utils pulseaudio pavucontrol \
  xclip xinput lxsession
```

AUR:

```bash
yay -S --needed betterlockscreen brillo
```

Why:

* `.dwm/autostart.sh`: `/usr/libexec/xfce-polkit`, `picom`, `nitrogen --restore`, `slstatus`, `nm-applet`, `blueman-applet`, `flameshot`, `sxhkd`.
* `sxhkdrc`: `pcmanfm`, `brillo -A/-U`, `betterlockscreen -l`, `flameshot`.
* `betterlockscreenrc`: `wallpaper_cmd="feh --bg-fill"`, font `Hack Nerd Font` (shipped in `common`).
* `dunstrc`: `dmenu -p dunst`, `xdg-open`, icon theme `Papirus-Dark` (install `papirus-icon-theme` if you want it).

### 2.2 Stow + build suckless tools

Your suckless sources live in `dwm/.config/{dwm,dmenu,st,slstatus}` and install with `PREFIX=/usr/local`.

```bash
cd ~/dotfiles
stow common   # fonts first, st/dwm need Hack Nerd Font
stow dwm

# build each tool (repeat after any config.h change)
for d in dwm dmenu st slstatus; do
  cd ~/.config/$d
  sudo make clean install
done
cd ~/dotfiles
```

If `make` fails, you missed `base-devel`, `libX11`, `libXft`, `libXinerama`, `freetype2`.

Set a wallpaper for `nitrogen --restore` / `betterlockscreen` once:

```bash
betterlockscreen -u ~/pictures/wallpaper.jpg
```

### 2.3 Post-install / autostart

* `common/.xinitrc` ends with `exec dwm`. Start with `startx` from TTY.
* Enable services:

```bash
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
```

* Test: `startx`, check `slstatus`, `sxhkd`, volume/brightness keys.

---

## 3. `sway` — Wayland

### 3.1 Packages

```bash
sudo pacman -S --needed \
  sway swayidle swaylock swaybg \
  waybar wofi mako swappy \
  grim slurp jq wl-clipboard cliphist \
  brightnessctl pulseaudio pavucontrol pipewire pipewire-pulse wireplumber \
  network-manager-applet polkit-kde-agent \
  xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk \
  pcmanfm flameshot alacritty firefox \
  autotiling
```

AUR / optional (referenced in `sway/.config/sway/config`):

```bash
yay -S --needed awww asusctl zen-browser-bin rog-control-center
```

Notes:

* `config` autostarts: `polkit-kde-authentication-agent-1`, `mako`, `awww-daemon`, `swayidle+swaylock`, `nm-applet`, `rog-control-center`, bar `waybar`, terminal `alacritty`, menu `wofi --show drun`, file manager `pcmanfm`, screenshots `grim | swappy -f -` / `grim -g "$(slurp)"`.
* `XF86Audio*` uses `pactl`; brightness uses `brightnessctl`.
* Waybar `config` `on-click: pavucontrol`, modules `sway/workspaces, pulseaudio, network, battery, clock, tray, idle_inhibitor` — needs `pavucontrol`, fonts with icons (Hack Nerd Font from `common`).
* Portal config `sway/.config/xdg-desktop-portal/portals.conf` needs `xdg-desktop-portal-wlr` + `gtk` for screencast/screenshot/filechooser.

### 3.2 Stow + post-install

```bash
cd ~/dotfiles
stow common
stow sway

mkdir -p ~/pictures/screenshots  # swappy save_dir
dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP=sway
```

Launch from TTY:

```bash
sway
```

If `awww-daemon` or `rog-control-center` are missing, comment those two `exec` lines — Sway will still start.

---

## 4. `openbox` — X11 stacking WM

Note: paths here are **not** `~/.config/...`. `openbox/` stows to `~/openbox`, `~/polybar`, `~/tint2`. Either keep as-is and symlink manually, or move them to `.config/` before stowing. Stock Openbox expects `~/.config/openbox/`.

### 4.1 Packages

```bash
sudo pacman -S --needed \
  openbox polybar tint2 picom nitrogen lxsession \
  network-manager-applet obconf openbox-themes \
  feh pcmanfm alacritty
```

### 4.2 Stow + post-install

```bash
cd ~/dotfiles
stow common
stow openbox

chmod +x ~/polybar/launch.sh
# if you want stock paths:
# mkdir -p ~/.config
# ln -s ~/openbox ~/.config/openbox
~/polybar/launch.sh
nitrogen --restore
```

`openbox/openbox/autostart` runs: `picom`, `nitrogen --restore`, `lxsession`, `tint2`, `nm-applet`. Launch via display manager or `openbox-session` from `~/.xinitrc`.

---

## 5. `misc` — AwesomeWM + Kitty

```bash
sudo pacman -S --needed awesome kitty rofi redshift pcmanfm lxsession nitrogen picom
cd ~/dotfiles
stow misc
```

Notes:

* `misc/` stows to `~/awesome`, `~/kitty`, **not** `~/.config/awesome`, `~/.config/kitty`. Symlink if needed:

```bash
mkdir -p ~/.config
ln -s ~/awesome ~/.config/awesome
ln -s ~/kitty ~/.config/kitty
```

* `awesome/rc.lua` autostarts: `picom`, `~/.config/polybar/launch.sh`, `pcmanfm --desktop`, `nitrogen --restore`, `lxsession`, `kmix`, `nm-applet`, `redshift`, touchpad `xinput` tweaks. Install `redshift`, `kmix` or comment them out. `Mod+Shift+Return` binds `rofi -show run`.
* `kitty.conf` only includes `current-theme.conf` (Catppuccin-Mocha) — install `kitty` and keep both files together.

---

## Quick copy-paste: full setup on base Arch

```bash
sudo pacman -Syu --needed git base-devel stow curl wget
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si
git clone https://github.com/kavyadeepdev/dotfiles.git ~/dotfiles
cd ~/dotfiles

# pick your stack:
stow common          # always first
# stow dwm
# stow sway
# stow openbox
# stow misc
```

Then do the per-section post-install above (shell framework, TPM, `nvim` first run, `fc-cache`, suckless `make install`, `systemctl enable --now NetworkManager bluetooth`, `systemctl --user enable --now mpd`).

## Updating

```bash
cd ~/dotfiles
git pull
stow -R common  # repeat for dwm/sway/openbox/misc as needed
# rebuild suckless after dwm update:
for d in dwm dmenu st slstatus; do cd ~/.config/$d && sudo make clean install; done
```
