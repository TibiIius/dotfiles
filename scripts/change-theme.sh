#!/bin/bash

dark_theme() {
  sed -i "s/let g:material_theme_style = 'lighter'/let g:material_theme_style = 'darker'/g" /home/tim/.config/nvim/init.vim
}

light_theme() {
  sed -i "s/let g:material_theme_style = 'darker'/let g:material_theme_style = 'lighter'/g" /home/tim/.config/nvim/init.vim
}

case $1 in
  "--dark")
    dark_theme
    ;;
  "--light")
    light_theme
    ;;
esac

exit 0
