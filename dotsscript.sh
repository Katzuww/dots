echo Welcome to Openbox auto install script. . .
echo Starting script. . .

echo INSTALLING REQUIRED DEPENDENCIES
sudo pacman -S rsync
sudo pacman -Syu xorg-server xorg-xrandr xorg-xrdb psmisc
sudo pacman -S python

echo INSTALLING YAY
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -s
sudo pacman -U yay*

cd

echo END
yay -S dunst nitrogen openbox rofi rxvt-unicode-truecolor-wide-glyphs tint2 picom obmenu-generator perl-gtk3

sudo pacman -Syu pulseaudio pulseaudio-alsa mpd mpc ncmpcpp

yay -S alsa-utils brightnessctl imagemagick scrot w3m wireless_tools xclip xsettingsd xss-lock

sudo pacman -S polkit-gnome

yay -S thunar thunar-archive-plugin thunar-volman ffmpegthumbnailer tumbler
yay -S geany geany-plugins gimp gsimplecal inkscape mpv parcellite pavucontrol viewnior xfce4-power-manager

sudo pacman -S htop nano neofetch

sudo pacman -Syu zsh firefox

echo INSTALLING OH-MY-ZSH. . .
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo INSTALLING NANO ADD-ONS. . .
curl https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh | sh

echo INSTALLING FONTS. . .
mkdir -pv ~/.fonts/{Cantarell,Comfortaa,IcoMoon-Custom,Nerd-Patched,Unifont}💲 mkdir -pv ~/.fonts/{Cantarell,Comfortaa,IcoMoon-Custom,Nerd-Patched,Unifont}

wget --no-hsts -cNP ~/.fonts/Comfortaa/ https://raw.githubusercontent.com/googlefonts/comfortaa/main/fonts/OTF/Comfortaa-{Bold,Regular}.otf
wget --no-hsts -cNP ~/.fonts/IcoMoon-Custom/ https://github.com/owl4ce/dotfiles/releases/download/ng/{Feather,Material}.ttf
wget --no-hsts -cNP ~/.fonts/Nerd-Patched/ https://github.com/owl4ce/dotfiles/releases/download/ng/M+.1mn.Nerd.Font.Complete.ttf
wget --no-hsts -cNP ~/.fonts/Nerd-Patched/ https://github.com/owl4ce/dotfiles/releases/download/ng/{M+.1mn,Iosevka}.Nerd.Font.Complete.Mono.ttf
wget --no-hsts -cNP ~/.fonts/Unifont/ https://unifoundry.com/pub/unifont/unifont-14.0.02/font-builds/unifont-14.0.02.ttf
wget --no-hsts -cN https://download-fallback.gnome.org/sources/cantarell-fonts/0.303/cantarell-fonts-0.303.1.tar.xz

tar -xvf cantarell*.tar.xz --strip-components 2 --wildcards -C ~/.fonts/Cantarell/ \*/\*/Cantarell-VF.otf

echo INSTALLING ICONS. . .
mkdir -pv ~/.icons

wget --no-hsts -cN https://github.com/owl4ce/dotfiles/releases/download/ng/{Gladient_JfD,Papirus{,-Dark}-Custom}.tar.xz

tar -xf Gladient_JfD.tar.xz -C ~/.icons/
tar -xf Papirus-Custom.tar.xz -C ~/.icons/
tar -xf Papirus-Dark-Custom.tar.xz -C ~/.icons/

sudo ln -vs ~/.icons/Papirus-Custom /usr/share/icons/
sudo ln -vs ~/.icons/Papirus-Dark-Custom /usr/share/icons/

echo INSTALLING WALLPAPERS. . .
mkdir -pv ~/.wallpapers/{mechanical,eyecandy}

wget --no-hsts -cNP ~/.wallpapers/mechanical/ https://github.com/owl4ce/dotfiles/releases/download/ng/{batik-1_4K,okita-souji_FHD}.jpg
wget --no-hsts -cNP ~/.wallpapers/eyecandy/ https://github.com/owl4ce/dotfiles/releases/download/ng/{cherry-blossoms,floral-artistic-2}_FHD.jpg

mkdir -pv ~/.urxvt/ext

(cd ~/.urxvt/ext/; curl -LO https://raw.githubusercontent.com/simmel/urxvt-resize-font/master/resize-font)
(cd ~/.urxvt/ext/; curl -LO https://raw.githubusercontent.com/mina86/urxvt-tabbedex/master/tabbedex)

echo SYNCHRONIZATION
cd ~/Documents/

git clone --depth 1 --recurse-submodules https://github.com/owl4ce/dotfiles.git

rsync -avxHAXP --exclude-from=- dotfiles/. ~/ << "EXCLUDE"
.git*
LICENSE
*.md
EXTRA_JOYFUL
EXCLUDE

rsync -avxHAXP --exclude-from=- dotfiles/EXTRA_JOYFUL/. ~/ << "EXCLUDE"
.git*
EXCLUDE

fc-cache -rv

sudo pacman -Syu xorg-xinit