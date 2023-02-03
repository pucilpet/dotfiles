{
  config,
  pkgs,
  lib,
  ...
}: {
  # Configuring programs :)

  xdg.configFile.awesome = {
    source = ./config/awesome;
    recursive = true;
  };
  xdg.configFile.picom = {
    source = ./config/picom;
  };
  xdg.configFile.rofi = {
    source = ./config/rofi;
    recursive = true;
  };
}
