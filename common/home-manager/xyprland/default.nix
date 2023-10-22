{ ... }: {
  imports = [ ./waybar ];

  programs.xyprland = let
    mkMonitor = name: resolution: position: scale: {
      inherit name resolution position scale;
    };
    mkVar = name: value: { inherit name value; };
    mkBind = text: {
      inherit text;
      flags = null;
    };
    mkFlagBind = text: flags: mkBind text // { inherit flags; };
  in {
    enable = true;
    xwayland.enable = true;
    extraConfig.pre = import ./options.nix;
    extraConfig.post = import ./ws_switchers.nix;

    options = {
      general = {
        gaps_in = 1;
        gaps_out = 0;
        layout = "dwindle";
        "col.active_border" = "rgba(eeeeee88) rgba(ffffffbb) 45deg";
        "col.inactive_border" = "rgba(000000aa)";
      };
    };

    monitors = [ (mkMonitor "DP-2" "1920x1080@60" "0x0" "1") ];

    env = [
      (mkVar "QT_QPA_PLATFORM" "wayland;xcb")
      (mkVar "SDL_VIDEODRIVER" "wayland")
      (mkVar "MOZ_ENABLE_WAYLAND" "1")
      (mkVar "WLR_RENDERER_ALLOW_SOFTWARE" "1")
      (mkVar "XDG_CURRENT_DESKTOP" "Hyprland")
      (mkVar "XDG_SESSION_TYPE" "wayland")
      (mkVar "XDG_SESSION_DESKTOP" "Hyprland")
      (mkVar "GDK_BACKEND" "wayland,x11")
      (mkVar "XCURSOR_SIZE" "32")
    ];

    defaultWorkspaces = let
      mkSilent = text: {
        inherit text;
        silent = true;
      };
    in {
      "2" = [ "firefox" ];
      "3" = [ "Thunar" ];
      "4" = [ (mkSilent "Okular") (mkSilent "title:^Deluge$") ];
      "5" = [ "discord" ];
      "6" = [ "Audacity" "krita" ];
      "7" = [ (mkSilent "lutris") (mkSilent "Steam") ];
      "9" = [ (mkSilent "title:^(.*)- Obsidian(.*)$") ];
    };

    binds = (map (bind: mkBind bind) [
      "$mod, return, exec, alacritty"
      "$mod, Q, killactive, "
      "$mod, N, exec, thunar"
      "$mod, space, togglefloating, "
      "$mod, D, exec, rofi -show run"
      "$mod, P, pseudo,"
      "$mod, O, togglesplit,"
      "$mod, F, fullscreen"
      "$mod, left, movefocus, l"
      "$mod, right, movefocus, r"
      "$mod, up, movefocus, u"
      "$mod, down, movefocus, d"
      "$mod, L, movefocus, l"
      "$mod, H, movefocus, r"
      "$mod, K, movefocus, u"
      "$mod, J, movefocus, d"
      "$mod, mouse_down, workspace, e+1"
      "$mod, mouse_up, workspace, e-1"
      ", Print, exec, sshot --screen -o $HOME/imgs/screenshots"
      "SHIFT, Print, exec, sshot --area -o $HOME/imgs/screenshots"
      "$mod, r, submap, resize"
    ]) ++ [
      (mkFlagBind
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+"
        "le")
      (mkFlagBind
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-"
        "le")
      (mkFlagBind
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle" "le")
      (mkFlagBind "$mod, mouse:272, movewindow" "m")
      (mkFlagBind "$mod, mouse:273, resizewindow" "m")
    ];

    submaps = {
      resize = map (bind: mkFlagBind bind "e") [
        ", right, resizeactive,10 0"
        ", left, resizeactive,-10 0"
        ", up, resizeactive,0 -10"
        ", down, resizeactive,0 10"
      ];
    };

    onceStart = [
      "fcitx5"
      "waybar"
      "swww init"
      "alacritty"
      "firefox"
      "discord"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP exec-once=systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    ];
  };
}
