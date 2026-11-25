# brightness-blackout

Turns the screen fully black when you step brightness down to 0% on Linux Mint (Cinnamon).
Everything else works as before: the brightness keys and the slider behave normally, and stepping up from 0% brings the picture back.

Best on OLED screens, where black pixels emit no light. On LCD screens the backlight may still glow faintly.

## Requirements

- Linux Mint / Cinnamon on X11 (not Wayland)
- `xrandr`, `gdbus`, `dbus-monitor` (installed by default on Mint)

## Install

```bash
git clone https://github.com/jankorbay/brightness-blackout.git
cd brightness-blackout
./install.sh
```

It installs for the current user (no sudo), starts right away, and starts automatically at every login.

## Use

- Press brightness-down (or drag the slider) to 0% → the screen goes black.
- Press brightness-up → the screen comes back.

Brightness keys are ignored by Cinnamon while a panel menu is open. If the keys do nothing, press Esc first.

## Stuck on a black screen?

Press brightness-up. If that does not help, open a terminal blind (Ctrl+Alt+T) and run:

```bash
pkill -f brightness-blackout
```

The screen is restored when the script stops.

## Uninstall

```bash
./install.sh uninstall
```

## How it works

A small bash script listens for Cinnamon's brightness `Changed` D-Bus signal. When brightness is 0% it sets screen gamma to 0 (`xrandr --brightness 0`); when it goes above 0% it sets gamma back to 1. It does no polling and uses a few MB of memory.

Note: if Night Light is on, its tint is reset when leaving 0% until Cinnamon reapplies it.
