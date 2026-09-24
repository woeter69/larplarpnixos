#!/usr/bin/env bash

# Define paths
WALL_DIR="$HOME/Pictures/Wallpapers"
HYPR_CONF="$HOME/.config/hypr/hyprland.conf"
PAPER_CONF="$HOME/.config/hypr/hyprpaper.conf"

# Check if the wallpaper directory exists
if [ ! -d "$WALL_DIR" ]; then
    echo "Error: Wallpaper directory not found at $WALL_DIR"
    exit 1
fi

# Collect wallpapers
mapfile -t IMAGES < <(find "$WALL_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | sort)
COUNT=${#IMAGES[@]}

if [ "$COUNT" -eq 0 ]; then
    echo "No wallpapers found in $WALL_DIR"
    exit 0
fi

# Dynamically calculate columns and rows based on wallpaper count
if [ "$COUNT" -le 4 ]; then
    COLS=$COUNT
    LINES=1
else
    COLS=5
    LINES=$(( (COUNT + COLS - 1) / COLS ))
    if [ "$LINES" -gt 3 ]; then
        LINES=3
    fi
fi

# Calculate window width to fit items snugly with zero dead space
WINDOW_WIDTH=$(( COLS * 184 + 32 ))
if [ "$WINDOW_WIDTH" -gt 1100 ]; then
    WINDOW_WIDTH=1100
fi

# Use rofi to select a wallpaper
SELECTED=$(printf '%s\n' "${IMAGES[@]}" \
    | while read -r img; do echo -en "$img\0icon\x1f$img\n"; done \
    | rofi -dmenu -p "Select Wallpaper" -show-icons \
           -theme "$HOME/.config/rofi/wallselect/style.rasi" \
           -theme-str "window { width: ${WINDOW_WIDTH}px; } listview { columns: ${COLS}; lines: ${LINES}; }")

# Exit if cancelled
if [ -z "$SELECTED" ]; then
    echo "No wallpaper selected."
    exit 0
fi

# --- 1. Update hyprland.conf variable ---
if grep -q "^\$wallpaper =" "$HYPR_CONF"; then
    sed -i "s#^\$wallpaper =.*#\$wallpaper = $SELECTED#" "$HYPR_CONF"
else
    echo "Warning: \$wallpaper variable not found in hyprland.conf"
fi

# --- 2. Update hyprpaper.conf ---
cat <<EOF > "$PAPER_CONF"
preload = $SELECTED
wallpaper = ,$SELECTED

wallpaper {
    monitor = 
    path = $SELECTED
    fit_mode = cover
}

splash = false
ipc = on
EOF

# --- 3. Apply changes immediately ---
if command -v hyprctl &>/dev/null && hyprctl hyprpaper listloaded &>/dev/null; then
    hyprctl hyprpaper preload "$SELECTED"
    hyprctl hyprpaper wallpaper ",$SELECTED"
    hyprctl hyprpaper unload all
else
    pkill hyprpaper 2>/dev/null || true
    hyprpaper &> /dev/null &
fi

echo "Wallpaper updated to $SELECTED."
