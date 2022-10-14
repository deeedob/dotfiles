#!/usr/bin/zsh

echo "################"
echo "# install root #"
echo "################"

if [ -d files/root ] 
  then
    sudo ln -fvs ${BASEDIR}/files/root/usr/share/icons/Bibata-Modern-TokyoNight /usr/share/icons/
    sudo ln -fvs ${BASEDIR}/files/root/usr/share/icons/default/index.theme /usr/share/icons/default/
    sudo ln -fvs ${BASEDIR}/files/root/etc/zshenv /etc/zsh/
    sudo ln -fvs ${BASEDIR}/files/root/etc/lightdm/lightdm.conf /etc/lightdm/
    sudo ln -fvs ${BASEDIR}/files/root/username.jpg /var/lib/AccountsService/icons/$(whoami).jpg
    sudo ln -fvs /usr/bin/alacritty /usr/bin/xterm # little trick
  else
    echo "AN ERROR OCURRED!"
    exit -1
fi

