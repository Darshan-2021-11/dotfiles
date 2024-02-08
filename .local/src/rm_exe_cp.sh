#!/bin/bash

folder=~/programming/cp
find $folder -type f -executable -not -path */.git/* -print | sed -e "s/^\.\\///g" | while read -r line; do rm "$line"; done

