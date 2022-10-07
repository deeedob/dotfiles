#!/usr/bin/zsh

echo "################"
echo "# install root #"
echo "################"

if [ -d files/root ] 
  then
    DIR=$(pwd)
    echo "Current directory: ${DIR}"
    sudo ln -fvs ${DIR}/files/root/usr/share/icons/Bibata-Modern-TokyoNight /usr/share/icons/
    sudo ln -fvs ${DIR}/files/root/usr/share/icons/default/index.theme /usr/share/icons/default/
  else
    echo "AN ERROR OCURRED!"
fi

