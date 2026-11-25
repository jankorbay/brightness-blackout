#!/bin/bash
# Usage: ./install.sh            install for the current user and start it
#        ./install.sh uninstall  remove it and restore the screen
set -eu
BIN=$HOME/.local/bin/brightness-blackout
DESKTOP=$HOME/.config/autostart/brightness-blackout.desktop

pkill -f "$BIN" 2>/dev/null || true

if [ "${1:-}" = uninstall ]; then
  rm -f "$BIN" "$DESKTOP"
  echo "Uninstalled."
  exit
fi

install -Dm755 "$(dirname "$0")/brightness-blackout" "$BIN"
mkdir -p "$(dirname "$DESKTOP")"
cat > "$DESKTOP" <<EOF
[Desktop Entry]
Type=Application
Name=Brightness Blackout
Comment=Black out the screen at 0% brightness
Exec=$BIN
X-GNOME-Autostart-enabled=true
NoDisplay=true
EOF
setsid "$BIN" >/dev/null 2>&1 < /dev/null &
echo "Installed and running. Starts automatically at login."
