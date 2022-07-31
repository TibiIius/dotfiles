#!/bin/bash

dark_theme() {
  sed -i "s/let g:material_theme_style = 'lighter'/let g:material_theme_style = 'palenight'/g" /home/tim/.config/nvim/colors.vim
  sed -i "s/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/\"workbench.colorTheme\": \"Material Theme Lighter High Contrast\"*/\"workbench.colorTheme\": \"Material Theme Palenight High Contrast\"/g" /home/tim/.config/Code/User/settings.json
  sed -i "s/\"workbench.colorTheme\": \"Material Theme Lighter High Contrast\"*/\"workbench.colorTheme\": \"Material Theme Palenight High Contrast\"/g" /home/tim/.var/app/com.visualstudio.code/config/Code/User/settings.json
  sed -i 's/one-light/one-dark/g' ./.hyper.js
  [[ -f /home/tim/.config/spicetify/config-xpui.ini ]] && sed -i "s/color_scheme            = light/color_scheme            = dark/g" /home/tim/.config/spicetify/config-xpui.ini && spicetify -qn apply enable-devtools
}

light_theme() {
  sed -i "s/let g:material_theme_style = 'palenight'/let g:material_theme_style = 'lighter'/g" /home/tim/.config/nvim/colors.vim
  sed -i "s/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/\"workbench.colorTheme\": \"Material Theme Palenight High Contrast\"*/\"workbench.colorTheme\": \"Material Theme Lighter High Contrast\"/g" /home/tim/.config/Code/User/settings.json
  sed -i "s/\"workbench.colorTheme\": \"Material Theme Palenight High Contrast\"*/\"workbench.colorTheme\": \"Material Theme Lighter High Contrast\"/g" /home/tim/.var/app/com.visualstudio.code/config/Code/User/settings.json
  sed -i 's/one-dark/one-light/g' ./.hyper.js
  [[ -f /home/tim/.config/spicetify/config-xpui.ini ]] && sed -i "s/color_scheme            = dark/color_scheme            = light/g" /home/tim/.config/spicetify/config-xpui.ini && spicetify -qn apply enable-devtools
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
