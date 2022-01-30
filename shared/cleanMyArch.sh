#! /bin/zsh

# ask if user want to remove orphans yes or no
echo "Listing oprhans : "
echo "-----------------"
sudo pacman -Qtdq
echo "-----------------"

echo "Do you want to remove orphans? (y/n)"
read answer
if [$answer = "y"]; then
    echo "Removing orphans..."
    pacman -Rns $(pacman -Qtdq)
    echo "Done!"
else
    echo "Aborting..."
fi

echo "User Cache Size : "
echo "-----------------"
du -sh /home/$USER/.cache
echo "-----------------"

echo "Do you want to remove user cache ? "
read answer
if [$answer = "y"]; then
    echo "Removing user cache..."
    sudo rm -rf /var/cache/pacman/pkg/*
    echo "Done!"
else
    echo "Aborting..."
fi