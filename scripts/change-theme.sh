#!/bin/bash

dark_theme() {
  sed -i "s/let g:material_theme_style = 'lighter'/let g:material_theme_style = 'darker'/g" /home/tim/.config/nvim/colors.vim
  sed -i "s/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/g" /home/tim/.config/gtk-4.0/settings.ini
  [[ -f /home/tim/.config/spicetify/config-xpui.ini ]] && sed -i "s/color_scheme            = White/color_scheme            = Nord-Dark/g" /home/tim/.config/spicetify/config-xpui.ini && spicetify apply enable-devtool
}

light_theme() {
  sed -i "s/let g:material_theme_style = 'darker'/let g:material_theme_style = 'lighter'/g" /home/tim/.config/nvim/colors.vim
  sed -i "s/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/g" /home/tim/.config/gtk-4.0/settings.ini
  [[ -f /home/tim/.config/spicetify/config-xpui.ini ]] && sed -i "s/color_scheme            = Base/color_scheme            = White/g" /home/tim/.config/spicetify/config-xpui.ini && spicetify apply enable-devtool
}

check_files() {
# neovim
[[ ! -f /home/tim/.config/nvim/colors.vim ]] && printf "let g:material_theme_style = 'darker'\ncolorscheme material\nif has(\"termguicolors\") \" set true colors\n  set t_8f=\[[38;2;%lu;%lu;%lum\n  set t_8b=\[[48;2;%lu;%lu;%lum\n  set termguicolors\nendif" > /home/tim/.config/nvim/colors.vim
}


check_files

case $1 in
  "--dark")
    dark_theme
    ;;
  "--light")
    light_theme
    ;;
esac

exit 0
