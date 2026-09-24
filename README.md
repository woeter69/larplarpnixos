# ❄️ larplarpnixos — Niri & NixOS Dotfiles

A modern, fluid, and battery-efficient desktop configuration for **NixOS** powered by the **Niri** scrollable-tiling Wayland compositor and styled with the **Catppuccin Mocha** palette.

---

## 🎨 Visual Preview & Features

- **Compositor:** [Niri](https://github.com/YaLTeR/niri) — Infinite horizontal ribbon scrolling with vertical tile stacks.
- **Physics-Based Animations:** Custom spring physics with dynamic overshooting for window opens, closes, resizes, and workspace switches.
- **Hover-Based Focus:** `focus-follows-mouse` enabled for mouse interaction.
- **Gaps & Geometry:** 14px outer gaps with 10px rounded corners (`geometry-corner-radius 10`) and `clip-to-geometry true`.
- **Top Bar:** [Waybar](https://github.com/Alexays/Waybar) with Catppuccin Mocha theme, native `niri/workspaces`, interactive Bluetooth, Wi-Fi, and one-click NixOS updates.
- **Application Launchers:** Dual [Rofi](https://github.com/davatorium/rofi) (Wayland) and [Wofi](https://hg.sr.ht/~scoopta/wofi) support.
- **Wallpaper Selector:** Adaptive Rofi wallpaper grid (`Win + Shift + R`) that calculates columns and window width dynamically with zero dead space.
- **Power Menu:** [Wlogout](https://github.com/ArtsyMacaw/wlogout) styled in Catppuccin Mocha with opening keyframe animations (`fadeIn` and `popIn`).
- **Cursor Integration:** 20px Adwaita cursor synchronized across Niri, GTK3, GTK4, and XWayland with transformations (pointing hand, I-beam text, resize handles).

---

## 📁 Repository Structure

```text
larplarpnixos/
├── README.md                          # Documentation & keybindings reference
├── apply.sh                           # One-click deployment script
├── nixos/                             # NixOS system-level configuration
│   ├── configuration.nix              # Main NixOS system configuration
│   ├── hardware-configuration.nix     # Generated hardware configuration
│   ├── home.nix                       # Home Manager user profile & packages
│   ├── niri-config.kdl                # Niri compositor config for /etc/nixos
│   └── dotfiles/
│       └── waybar/                    # System Waybar theme source
├── config/                            # Standalone user dotfiles (~/.config)
│   ├── niri/
│   │   └── config.kdl                 # Live Niri configuration
│   ├── waybar/
│   │   ├── config.jsonc               # Waybar module layout
│   │   ├── style.css                  # Waybar CSS stylesheets
│   │   ├── mocha.css                  # Catppuccin Mocha color definitions
│   │   ├── Modules/                   # Modular Waybar components
│   │   └── Scripts/                   # Bar utility scripts
│   ├── rofi/
│   │   ├── launcher/                  # Main application launcher
│   │   ├── wallselect/                # Dynamic responsive wallpaper picker
│   │   ├── wifi/                      # NetworkManager Wi-Fi connector
│   │   ├── shortcut/                  # Keyboard shortcut modal cheatsheet
│   │   ├── clipboard/                 # Cliphist clipboard history manager
│   │   ├── hyprshot/                  # Screenshot utility
│   │   └── musicPlayer/               # MPRIS media launcher
│   ├── wlogout/
│   │   ├── layout                     # 6-button action definitions
│   │   ├── style.css                  # Catppuccin stylesheet & keyframe animations
│   │   ├── launch.sh                  # Launcher script
│   │   └── icons/                     # Power, reboot, lock, suspend, logout icons
│   ├── hypr/
│   │   ├── hyprpaper.conf             # Hyprpaper multi-monitor wallpaper config
│   │   ├── scripts/
│   │   │   └── lock.sh                # Screen lock script (hyprlock + swaylock fallback)
│   │   └── assets/                    # Default wallpapers
│   ├── gtk-3.0/
│   │   └── settings.ini               # GTK3 cursor theme and size
│   └── gtk-4.0/
│       └── settings.ini               # GTK4 cursor theme and size
└── wallpapers/                        # Collection of desktop backgrounds
    ├── wallpaper-craft.png
    └── wallpaper.jpg
```

---

## ⌨️ Keybindings Reference

> [!TIP]
> Press **`F1`** or **`Win + /`** at any time to open Niri's interactive hotkey cheatsheet!

### Core Applications
| Shortcut | Action |
| :--- | :--- |
| **`Win + Q`** | Open Terminal ([WezTerm](https://wezfurlong.org/wezterm/)) |
| **`Win + B`** | Open Web Browser (Firefox) |
| **`Win + E`** | Open Terminal File Manager ([Yazi](https://yazi-rs.github.io/)) |
| **`Win + C`** | Close Focused Window |
| **`Win + D`** | Open Rofi Application Launcher |
| **`Win + Shift + D`** | Open Wofi Application Launcher |
| **`Win + Escape`** | Open Animated Power Menu (wlogout) |
| **`Win + L`** | Lock Screen (`lock.sh` -> Swaylock / Hyprlock) |
| **`Ctrl + Shift + Tab`** | Open Task Manager ([btop](https://github.com/aristocratos/btop)) |

---

### Navigation & Focus
| Shortcut | Action |
| :--- | :--- |
| **Mouse Hover** | Focus window under cursor (`focus-follows-mouse`) |
| **`Alt + A`** / **`Win + Left`** | Focus column to the left |
| **`Alt + D`** / **`Win + Right`** | Focus column to the right |
| **`Alt + W`** / **`Win + Up`** | Focus tile above in the current column |
| **`Alt + S`** / **`Win + Down`** | Focus tile below in the current column |
| **`Win + Home`** | Jump to the first column on the workspace |
| **`Win + End`** | Jump to the last column on the workspace |

---

### Window & Column Movement
| Shortcut | Action |
| :--- | :--- |
| **`Alt + Shift + A`** / **`Win + Ctrl + Left`** | Move active column left |
| **`Alt + Shift + D`** / **`Win + Ctrl + Right`** | Move active column right |
| **`Alt + Shift + W`** / **`Win + Ctrl + Up`** | Move active tile up within column |
| **`Alt + Shift + S`** / **`Win + Ctrl + Down`** | Move active tile down within column |

---

### Column Magic (Consume, Expel & Tabs)
| Shortcut | Action |
| :--- | :--- |
| **`Win + [`** / **`Win + ]`** | Consume or expel window left / right |
| **`Win + ,`** | Consume neighboring window into current column |
| **`Win + .`** | Expel active window from column into its own column |
| **`Win + W`** | Toggle column tabbed display (accordion tabs) |

---

### Sizing, Presets & Placement
| Shortcut | Action |
| :--- | :--- |
| **`Win + R`** | Cycle preset column widths (`1/3`, `1/2`, `2/3`, `80%`) |
| **`Win + Space`** / **`Win + Shift + C`** | Center active column on screen |
| **`Win + F`** | Maximize column (expands to full screen width with gaps) |
| **`Win + P`** / **`Win + Shift + F`** | Fullscreen active window |
| **`Win + O`** | Toggle window floating |
| **`Win + Shift + V`** | Switch focus between floating and tiled windows |
| **`Win + -`** / **`Win + =`** | Shrink / expand column width by 10% |
| **`Win + Shift + -`** / **`Win + Shift + =`** | Shrink / expand window height by 10% |
| **`Win + Ctrl + R`** | Reset window height |

---

### Workspaces
| Shortcut | Action |
| :--- | :--- |
| **`Win + 1`** … **`Win + 0`** | Switch to workspace 1–10 |
| **`Win + Shift + 1`** … **`Win + Shift + 0`** | Move active column to workspace 1–10 |
| **`Win + Tab`** / **`Win + S`** | Toggle Overview Mode |
| **`Win + Scroll Down`** / **`Up`** | Switch to next / previous workspace |

---

### Menus, Utilities & Screenshots
| Shortcut | Action |
| :--- | :--- |
| **`Win + Shift + R`** | Open Dynamic Wallpaper Selector |
| **`Win + N`** | Open NetworkManager Wi-Fi Menu |
| **`Win + V`** | Open Clipboard History ([cliphist](https://github.com/sentriz/cliphist)) |
| **`Win + Shift + S`** | Select area and take screenshot (Hyprshot) |
| **`Print`** | Interactive Niri UI screenshot |
| **`Ctrl + Print`** | Full display screenshot |
| **`Alt + Print`** | Active window screenshot |

---

### Hardware & Media Controls
| Key | Action |
| :--- | :--- |
| **`XF86AudioRaiseVolume`** | Volume +5% (WirePlumber) |
| **`XF86AudioLowerVolume`** | Volume -5% (WirePlumber) |
| **`XF86AudioMute`** | Toggle audio mute |
| **`XF86AudioMicMute`** | Toggle microphone mute |
| **`XF86MonBrightnessUp`** | Brightness +5% (brightnessctl) |
| **`XF86MonBrightnessDown`** | Brightness -5% (brightnessctl) |
| **`XF86AudioPlay`** / **`Pause`** | Play / Pause media (playerctl) |
| **`XF86AudioNext`** / **`Prev`** | Next / Previous track (playerctl) |

---

## 🚀 Installation & Deployment

### Quick Deploy (Recommended)
Run the bundled deployment script directly from the repository:

```bash
cd /mnt/d_drive/programs/larplarpnixos
./apply.sh
```

This script will:
1. Copy NixOS system definitions and Home Manager configs to `/etc/nixos/`.
2. Link user dotfiles (`niri`, `waybar`, `rofi`, `wlogout`, `hypr`, `gtk`) into `~/.config/`.
3. Set up the default Adwaita cursor theme.
4. Run `sudo nixos-rebuild switch` to build and activate the system generation.
5. Reload Niri and Waybar live.

---

### Manual Deployment Steps

1. **Copy system configuration files:**
   ```bash
   sudo cp nixos/configuration.nix /etc/nixos/configuration.nix
   sudo cp nixos/hardware-configuration.nix /etc/nixos/hardware-configuration.nix
   sudo cp nixos/home.nix /etc/nixos/home.nix
   sudo cp nixos/niri-config.kdl /etc/nixos/niri-config.kdl
   sudo mkdir -p /etc/nixos/dotfiles/waybar
   sudo cp -r nixos/dotfiles/waybar/* /etc/nixos/dotfiles/waybar/
   ```

2. **Link user configuration files:**
   ```bash
   mkdir -p ~/.config ~/.icons/default ~/Pictures/Wallpapers
   cp wallpapers/* ~/Pictures/Wallpapers/

   ln -sfn $(pwd)/config/niri ~/.config/niri
   ln -sfn $(pwd)/config/waybar ~/.config/waybar
   ln -sfn $(pwd)/config/rofi ~/.config/rofi
   ln -sfn $(pwd)/config/wlogout ~/.config/wlogout
   ln -sfn $(pwd)/config/hypr ~/.config/hypr
   ln -sfn $(pwd)/config/gtk-3.0 ~/.config/gtk-3.0
   ln -sfn $(pwd)/config/gtk-4.0 ~/.config/gtk-4.0
   ```

3. **Rebuild NixOS:**
   ```bash
   sudo nixos-rebuild switch
   ```

4. **Reload Compositor:**
   ```bash
   niri msg action load-config-file
   pkill waybar && waybar &
   ```

---

## 🖼️ Managing Wallpapers

To add new wallpapers to your system:
1. Place image files (`.png`, `.jpg`, `.jpeg`, `.webp`) into `~/Pictures/Wallpapers/`.
2. Press **`Win + Shift + R`**.
3. The Rofi wallpaper picker will automatically adapt its width and grid columns to fit your wallpapers. Click any thumbnail to apply it across all connected monitors immediately!
