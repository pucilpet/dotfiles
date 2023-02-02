{
  config,
  outputs,
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./home.nix
    ./packages.nix
    ./configs.nix
    ./modules/shell
    ./modules/windowManager
    ./modules/programs
  ];
}
