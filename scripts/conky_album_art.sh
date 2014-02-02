#!/usr/bin/env bash

musicdir="$HOME/Music/"

albumdir=$musicdir$(dirname "$(mpc -f %file% current)")
albumlink="$HOME/.mpd/albumart"

if [[ -e "$albumdir/folder.jpg" ]]
then
    ln -sf "$albumdir/folder.jpg" "$albumlink"
elif [[ -e "$albumdir/folder.png" ]]
then
    ln -sf "$albumdir/folder.png" "$albumlink"
else
    if [[ -e "$albumlink" ]]
    then
        rm "$albumlink"
    fi
fi

