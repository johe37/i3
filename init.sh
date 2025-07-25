#!/bin/bash
set -e

### GLOBALS ###
PKG_MGR=dnf
PACKAGES=(
  i3
  i3lock
  i3status
  i3blocks
  dmenu
  lightdm
  lightdm-gtk-greeter
  xrandr
  lxappearance
  arc-theme
  materia-gtk-theme
  papirus-icon-theme
  qt5ct
  kvantum
  feh
)
SCREEN_RES=2560x1440

# Color codes
COLOR_RESET="\033[0m"
COLOR_INFO="\033[1;32m"   # Green
COLOR_WARN="\033[1;33m"   # Yellow
COLOR_ERROR="\033[1;31m"  # Red
COLOR_DEBUG="\033[1;34m"  # Blue
COLOR_LOG="\033[1;37m"    # Light gray

### FUNCTIONS ###
log() {
  local level="$1"
  shift
  local msg="$*"
  local timestamp
  timestamp=$(date +"%Y-%m-%d %H:%M:%S")

  case "$level" in
    INFO)
      echo -e "${COLOR_INFO}[$timestamp] [INFO]  $msg${COLOR_RESET}"
      ;;
    WARN)
      echo -e "${COLOR_WARN}[$timestamp] [WARN]  $msg${COLOR_RESET}"
      ;;
    ERROR)
      echo -e "${COLOR_ERROR}[$timestamp] [ERROR] $msg${COLOR_RESET}"
      ;;
    DEBUG)
      echo -e "${COLOR_DEBUG}[$timestamp] [DEBUG] $msg${COLOR_RESET}"
      ;;
    *)
      echo -e "${COLOR_LOG}[$timestamp] [LOG]   $msg${COLOR_RESET}"
      ;;
  esac
}

install_deps(){
  for pkg in "${PACKAGES[@]}"; do
    log INFO "Trying to install package $pkg..." 
    sudo $PKG_MGR install -y $pkg
  done
}

setup_screen(){
  log INFO "Setting screen resolution..."
  primary_screen=$(xrandr | grep primary | grep -w 'connected' | cut -d ' ' -f 1)
  printf "\n# Set screen resolution\nexec_always xrandr --output $primary_screen --mode $SCREEN_RES" >> ~/.config/i3/config

  log INFO "Setting wallpaper..."
  printf "\n# Display wallpaper\nexec_always feh --bg-fill ~/.config/i3/assets/earth.jpg" >> ~/.config/i3/config
}

main(){
  install_deps

  log INFO "Setting up syslinks to gtk config folders"
  ln -s $PWD/gtk-3.0 ~/.config/gtk-3.0
  ln -s $PWD/gtk-4.0 ~/.config/gtk-4.0
  
  setup_screen
}

main
