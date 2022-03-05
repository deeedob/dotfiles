<div align="center">
  <h1>DD0xb's Dotfiles</h1>
</div>
Hello there and welcome to my dotfiles. 
I use these for all my [**Arch Linux**](https://archlinux.org/) Desktop Environments.
![plot]( ./Screenshots/screen_1.png )

## Prerequisite 

It's recommended to install the [#base dependencies](#base-dependencies) first for everything to work before cloning this repository.
As always with customized dotfiles, take into account that these won't fit your exact needs.
I use [**Dotbot**](https://github.com/anishathalye/dotbot) for managing my dotfiles across multiple machines!

  clone this repository:
```bash
$ git clone https://github.com/deeedob/ddob-dotfiles.git 
```
Now logout:
```bash
$ cd ddob-dotfiles; ./install
```

## Dependencies
### Base Dependencies

**Official:**
This will get you up and running with my dotfiles. If you want to get an understanding of what's going on I highly recommend to have a short read about these application.
```
# pacman -S git openssh xorg-server xorg-xinit xorg-xrandr bspwm sxhkd xwallpaper rofi dunst alacritty slop scrot jack2 qjackctl pulseaudio pulseaudio-jack alsa-utils refind neovim nautilus ranger calcurse htop termdown zsh ufw mpd nautilus-terminal
```
**AUR:** \
[picom (git) *](https://aur.archlinux.org/packages/picom-git/) \
[polybar](https://aur.archlinux.org/packages/polybar/) \
[fonts](https://aur.archlinux.org/packages/nerd-fonts-complete/) \
[icons](https://aur.archlinux.org/packages/ttf-material-design-icons/) \
[candy-icons](https://aur.archlinux.org/candy-icons-git.git)
[oh-my-zsh](https://aur.archlinux.org/packages/oh-my-zsh-git/) \
[zsh-theme](https://archlinux.org/packages/community/x86_64/zsh-theme-powerlevel10k/) \
[zsh-autosuggestions-git](https://aur.archlinux.org/packages/zsh-autosuggestions-git/) \
[zsh-autocompletion-git](https://aur.archlinux.org/packages/zsh-autocomplete-git/)

Install with yay:
```
# yay -S picom-git polybar spotify nerd-fonts-complete ttf-all-the-icons tdrop-git flameshot nautilus-metadata-editor nautilus-admin nautilus-open-any-terminal
```
<br>
For nautilus-open-any-terminal:
```
gsettings set com.github.stunkymonkey.nautilus-open-any-terminal terminal alacritty
```

**GIT:** \
[widgets: eww](https://github.com/elkowar/eww) \
[PTTabs: Polybar dropdown script](https://github.com/Nikzt/polybar-terminal-tabs) \
[refind-black](https://github.com/anthon38/refind-black) \
[Nordic-darker](https://github.com/Barbarossa93/Genome/tree/main/.themes/Nordic-darker) \

## Software recommendations \
Tasty applications I really enjoy using.

**Official**
```
# pacman -S neofetch keepassxc firefox-developer-edition neomutt zip unzip gimp inkscape blender plocate
```

**code**
```
# pacman -S code clion 
```

**lifestyle**
```
# pacman -S joplin discord telegram-desktop
```

**games**
```
# yay -S lichessnativefier
```
