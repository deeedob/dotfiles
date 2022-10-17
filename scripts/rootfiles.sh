#!/usr/bin/zsh

echo "################"
echo "# install root #"
echo "################"

if [ -d ${BASEDIR}/files/root ] 
  then
    sudo cp -r ${BASEDIR}/files/root/etc/lightdm/lightdm.conf /etc/lightdm/
    sudo cp -r ${BASEDIR}/files/root/usr/share/themes/Kanagawa-BL-LB /usr/share/themes
    sudo cp -r ${BASEDIR}/files/root/usr/share/icons/default/index.theme /usr/share/icons/default/
    sudo cp -r ${BASEDIR}/files/root/usr/share/icons/Bibata-Modern-TokyoNight /usr/share/icons/
    sudo cp -r ${BASEDIR}/files/root/usr/share/fonts/* /usr/share/fonts
    sudo cp -r ${BASEDIR}/files/root/username.jpg /var/lib/AccountsService/icons/$(whoami).jpg
    sudo cp -r ${BASEDIR}/files/root/etc/zsh/zshenv /etc/zsh/

  else
    echo "AN ERROR OCURRED!"
    exit -1
fi

