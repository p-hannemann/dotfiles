#!/bin/sh

SCRIPT=`realpath $0`
SCRIPTPATH=`dirname $SCRIPT`

function symlink() {
  if [ -e $2 ] && [ ! -L $2 ]; then
    echo "regular file exists at $2, not overriding!"
    return
  fi

  if [ "$(readlink $2)" == $1 ]; then
    echo "$2 already correct, skipping"
    return
  fi

  echo "creating link at $2"
  $3 ln --symbolic --no-target-directory --force $1 $2
}

# set up fixed location for the dotfile repo
symlink $SCRIPTPATH ~/.dotfiles

# homedir dotfiles
symlink ~/.dotfiles/.profile ~/.profile
# symlink ~/.dotfiles/.Xmodmap ~/.Xmodmap
symlink ~/.dotfiles/.zprofile ~/.zprofile
symlink ~/.dotfiles/.zshrc ~/.zshrc
# symlink ~/.dotfiles/.xinitrc ~/.xinitrc

# .config
mkdir -p ~/.config/

for file in ~/.dotfiles/.config//*; do
  echo $file
  symlink $file ~/.config/$(basename $file)
done

# symlink ./$(hostname).conf ~/.config/hypr/machines/current.conf

# ~/bin
mkdir -p ~/bin
for file in ~/.dotfiles/bin/*; do
  symlink $file ~/bin/$(basename $file)
done

# symlink ~/.dotfiles/.config/keyd /etc/keyd sudo

# ~/Pictures/screenshots
mkdir -p ~/Pictures/wallpaper
for file in ~/.dotfiles/Pictures/wallpaper/*; do
  symlink $file ~/Pictures/wallpaper/$(basename $file)
done
