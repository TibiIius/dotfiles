#!/usr/bin/env bash

# Needed because the socket always has Kitty's PID at the end
KITTY_SOCKETS=$(ls /tmp | grep mykitty)

dark_theme() {
  sed -i "s/let g:material_style = 'lighter'/let g:material_style = 'palenight'/g" /home/tim/.config/nvim/colors.vim
  sed -i "s/gtk-application-prefer-dark-theme=0/gtk-application-prefer-dark-theme=1/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/\"workbench.colorTheme\": \"Material Theme Lighter High Contrast\"*/\"workbench.colorTheme\": \"Material Theme Palenight High Contrast\"/g" /home/tim/.config/Code/User/settings.json
  sed -i 's/OneHalfLight/OneHalfDark/g' $HOME/.config/bat/config
  ln -sf $HOME/.config/kitty/themes-github/ayu_mirage.conf $HOME/.config/kitty/current-theme.conf
}

light_theme() {
  sed -i "s/let g:material_style = 'palenight'/let g:material_style = 'lighter'/g" /home/tim/.config/nvim/colors.vim
  sed -i "s/gtk-application-prefer-dark-theme=1/gtk-application-prefer-dark-theme=0/g" /home/tim/.config/gtk-3.0/settings.ini
  sed -i "s/\"workbench.colorTheme\": \"Material Theme Palenight High Contrast\"*/\"workbench.colorTheme\": \"Material Theme Lighter High Contrast\"/g" /home/tim/.config/Code/User/settings.json
  sed -i 's/OneHalfDark/OneHalfLight/g' $HOME/.config/bat/config
  ln -sf $HOME/.config/kitty/themes-github/ayu_light.conf $HOME/.config/kitty/current-theme.conf
}

check_files() {
  # neovim
  [[ ! -f /home/tim/.config/nvim/colors.vim ]] && printf "let g:material_theme_style = 'darker'\ncolorscheme material\nif has(\"termguicolors\") \" set true colors\n  set t_8f=\[[38;2;%lu;%lu;%lum\n  set t_8b=\[[48;2;%lu;%lu;%lum\n  set termguicolors\nendif" > /home/tim/.config/nvim/colors.vim
}

main() {
  check_files

  case $1 in
    "--dark")
      dark_theme
      ;;
    "--light")
      light_theme
      ;;
  esac

  for KITTY_SOCKET in $KITTY_SOCKETS; do
    kitty @ --to unix:/tmp/$KITTY_SOCKET set-colors -a "/home/tim/.config/kitty/current-theme.conf"
  done
    

  exit 0
}

main $@
