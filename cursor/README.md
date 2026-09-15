These programs are used to control cursor behaviour using only keyboard, so no mouse or trackpad needed no more.

> Caution:
>1. All these configurations are set to be the default global shortcut; so if any software use the same shortcut, it won't work there.
>2. `Capslock` is turned off totally; use the default alternative `Shift` to write capital letters.

## SHORTCUTS GUIDE
#### CURSOR MOVEMENT
- `Alt + W/A/S/D` to move the cursor (support diagonal movement and acceleration)
  
#### SCROLLING
- `Alt + E` to scroll up
- `Alt + X` to scroll down
  
#### LEFT CLICK AND RIGHT CLICK
- `Capslock` to left click once
- Long Press `Capslock` to long press left click
- `Capslock + Space` to right click

## IMPLEMENTATION STEPS
#### WINDOWS
1. Install `Autohotkey` v1x.
2. Download or create the `.ahk` file. Double click to run.
3. Taraa, done and works perfectly.
4. (Optional) Autostart on login:
   1. `Windows + R`, type `shell:startup`, enter.
   2. Copy your .ahk file there. **It'll run as the startup app!**
   
#### UBUNTU (Works for `X11`, `Wayland` need adjustment)
Open your Terminal:
1. Install the `pynput` Python library.
```
pip3 install pynput
```
2. Set the `Capslock` button function to borrow other unused button function (because `Capslock` native function works like a toggle, it can just run on/off, can't do long press. Hence, we borrow a virtual button, here we use F13 which is not real physically, just X11 thingy).
```
xmodmap -e 'clear Lock'
xmodmap -e 'keycode 66 = F13'
```
3. Download or create the `.py` file.
4. Run it.
```
python3 cursor.py
```
5. (Optional) Autostart on login:
Create ~/.config/autostart/cursor-control.desktop:
```
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/cursor-control.desktop << 'EOF'
[Desktop Entry]
Type=Application
Name=Cursor Control
Exec=python3 /home/YOUR_USERNAME/cursor_control.py
X-GNOME-Autostart-enabled=true
EOF
```
Replace YOUR_USERNAME with your actual username, or use $HOME expansion carefully (desktop files don't expand ~, so use the full path).
