{ config, pkgs, lib, ... }:

{
  # Configuring programs :)

  xdg.configFile.awesome = {
    source = ./config/awesome;
    recursive = true;
  };

}
