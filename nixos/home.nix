{ config, pkgs, lib, ... }:

{
  home.username = "woeter";
  home.homeDirectory = "/home/woeter";
  home.stateVersion = "26.05";
  home.enableNixpkgsReleaseCheck = false;

  # Supporting tools for the niri session.
  # (niri itself is installed system-wide via programs.niri.enable
  # in configuration.nix, not here.)
  home.packages = with pkgs; [
    wezterm             # Terminal, bound to Mod+Q in niri config
    wl-clipboard
    waybar              # Status bar
    grim                # Screen captures
    slurp
    xwayland-satellite  # XWayland app support under niri
    playerctl           # Media keys in config.kdl
    brightnessctl       # Brightness keys in config.kdl
    rofi                # Rofi with Wayland support built-in
    wofi                # Wofi application launcher
    wlogout             # Logout/power menu
    hyprpaper           # Wallpaper daemon
    swaybg              # Wallpaper tool
    cliphist            # Clipboard history manager
    blueman             # Bluetooth manager GUI (blueman-manager)
    libnotify           # notify-send utility
    hyprlock            # Lockscreen
    bibata-cursors      # Modern cursor theme
  ];

  # Screen locker — bound to Super+L in config.kdl
  programs.swaylock.enable = true;

  # Idle handling: lock after 5 min, screens off after 10 min, lock before sleep.
  services.swayidle = {
    enable = true;
    timeouts = [
      { timeout = 300; command = "${pkgs.swaylock}/bin/swaylock -f"; }
      { timeout = 600; command = "niri msg action power-off-monitors"; }
    ];
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
    };
  };

  # Notification daemon
  services.mako.enable = true;

  # Polkit GUI auth agent
  services.polkit-gnome.enable = true;
}
