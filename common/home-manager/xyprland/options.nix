''
  input {
    kb_layout = br
      kb_variant =
      kb_model =
      kb_options =
      kb_rules =

      follow_mouse = 1

      touchpad {
        natural_scroll = no
      }

    sensitivity = 0
  }

  decoration {
    rounding = 0

      blur {
        enabled = true
          size = 6
      }

    drop_shadow = yes
      shadow_range = 4
      shadow_render_power = 3
      col.shadow = rgba(1a1a1aee)
  }

  animations {
    enabled = yes

      bezier = myBezier, 0.05, 0.9, 0.1, 1.05

      animation = windows, 1, 7, myBezier, popin
      animation = windowsOut, 1, 7, default, slide
      animation = border, 1, 10, default
      animation = fade, 1, 7, default
      animation = workspaces, 1, 6, default, fade
  }

  dwindle {
    pseudotile = yes
      preserve_split = yes
  }

  master {
    new_is_master = true
  }

  gestures {
    workspace_swipe = off
  }
''
