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
  xdg.configFile.gtk3 = {
    source = ./config/gtk-3.0;
    recursive = true;
  };
}
