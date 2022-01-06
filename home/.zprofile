# Some env variables
export EDITOR=nvim
export VISUAL=nvim
export BROWSER=firefox
export CM_LAUNCHER=rofi
export QT_QPA_PLATFORMTHEME=qt5ct
export KRITA_NO_STYLE_OVERRIDE=1
source "$HOME/.cargo/env"

# Load these here instead of .zshrc for performance concerns
# Extend PATH variable
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH
# Add poetry related stuff
[[ -d "$HOME/.poetry/bin" ]] && export PATH="$HOME/.poetry/bin:$PATH"
# Pyenv stuff
export PYENV_ROOT="$HOME/.pyenv" \
  && export PATH="$PYENV_ROOT/bin:$PATH" \
  && eval "$(pyenv init --path)" \
