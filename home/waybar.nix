{ ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        modules-left = [ "wlr/workspaces" ];
        modules-center = [ "clock" ];
        modules-right = [ "cpu" "memory" "temperature" "pulseaudio" "tray" ];

        "wlr/workspaces" = {
          format = "{icon}";
          on-scroll-up = "hyprctl dispatch workspace e+1";
          on-scroll-down = "hyprctl dispatch workspace e-1";
          format-icons = {
            "1" = "1";
            "2" = "2";
            "3" = "3";
            "4" = "4";
            "5" = "5";
            "6" = "6";
            "7" = "7";
            "8" = "8";
            "9" = "9";
            "10" = "10";
          };
        };

        clock = {
          interval = 1;
          format = "{:[ %H:%M:%S | %e %b %Y (%A) ]}";
        };

        cpu = {
          interval =  5;
          format = "CPU {usage}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        memory = {
          interval = 5;
          format = "MEM {}%";
          states = {
            warning = 70;
            critical = 90;
          };
        };
        pulseaudio = {
          scroll-step = 1;
          format = "VOL {volume}%";
          format-muted = "MUT {format_source}";
          format-source = "{volume}% ";
          format-source-muted = "";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%+";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 3%-";
        };
        temperature = {
          thermal-zone = 1;
          hwmon-path = "/sys/class/hwmon/hwmon0/temp1_input";
          critical-treshold = 80;
          format = "TMP {temperatureC}°C";
          format-critical = "{temperatureC}°C!";
          interval = 100;
        };
        tray = {
          icon-size = 15;
          spacing = 10;
        };
      };
    };

    style = ''
    @define-color purple #c5a1f7;
    @define-color blue #10a5db;
    @define-color red #e82424;
    @define-color green #7ae6d1;

    * {
      min-height: 0;
      margin: 0;
      font-family: "Hack Nerd Font";
      font-size: 1rem;
    }

  #waybar {
    background: rgba(0, 0, 0, .8);
    color: @purple;
    border-top: 3px solid transparent;
    padding-bottom: 1px;
  }


  #clock,
  #memory,
  #cpu,
  #temperature,
  #pulseaudio,
  #tray {
    padding: 2px 1rem;
    font-weight: bold;
    color: transparent;
    background-color: rgba(30, 30, 30, .2);
    text-shadow:
    0px 0px 1px @purple;
  }

  #network.disconnected {
    color: orange;
  }

  #temperature.critical {
    font-size: .9rem;
    color: red;
  }

  #workspaces {
    padding: 0;
  }

  #workspaces button {
    color: @purple;
    border-top-color: @purple;
    border-radius: 0;
    font-size: .5em;
    margin-bottom: 0px;
    padding-left: 6px;
    padding-right: 6px;
  }


  #workspaces button.focused {
    color: @black;
    text-shadow: none;
    background-color: @purple;
    padding-left: 0;
  }

  #workspaces button.urgent {
    border-color: @purple;
    color: @green;
  }
  '';
};
}
