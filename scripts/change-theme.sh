#!/bin/bash

dark_theme() {
  sed -i "s/let g:material_theme_style = 'lighter'/let g:material_theme_style = 'darker'/g" /home/tim/.config/nvim/init.vim
  sed -i "s/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/g" /home/tim/.config/gtk-4.0/settings.ini

}

light_theme() {
  sed -i "s/let g:material_theme_style = 'darker'/let g:material_theme_style = 'lighter'/g" /home/tim/.config/nvim/init.vim
  sed -i "s/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/g" /home/tim/.config/gtk-4.0/settings.ini
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
