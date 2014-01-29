#!/usr/bin/env bash

maildirs="$HOME/.mail/*/inbox/new/"
mailz="$(find $maildirs -type f | wc -l)"
echo -n "$mailz"
exit 0
