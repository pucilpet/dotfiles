{
  pkgs,
  config,
  lib,
  ...
}: let
  ifTheyExist = groups: builtins.filter (group: builtins.hasAttr group config.users.groups) groups;
in {
  users.mutableUsers = true;
  users.users.pucilpet = {
    description = "Petteri Pucilowski";
    isNormalUser = true;
    shell = pkgs.zsh;
    initialPassword = "nixos";
    extraGroups =
      [
        "wheel"
        "networkmanager"
        "video"
        "audio"
        "nix"
        "systemd-journal"
      ]
      ++ ifTheyExist [
        "docker"
        "podman"
        "git"
        "libvirtd"
        "mysql"
      ];
    uid = 1000;
  };
}
