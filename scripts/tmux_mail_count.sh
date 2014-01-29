#!/usr/bin/env bash

maildirs="$HOME/.mail/*/inbox/new/"
mailz="$(find $maildirs -type f | wc -l)"

if [[ $mailz -gt 0 ]]
then
    echo -n "#[fg=white,bg=red] U: $mailz #[default]"
fi

exit 0
