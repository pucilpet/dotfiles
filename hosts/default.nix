{
  inputs,
  outputs,
  ...
}: let
  sharedModules =
    [
      inputs.home-manager.nixosModules.home-manager
      {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = true;
          extraSpecialArgs = {inherit inputs outputs;};
          users.pucilpet = ../home/pucilpet;
        };
      }
    ]
    ++ (builtins.attrValues outputs.nixosModules);
in {
  hp = outputs.lib.nixosSystem {
    modules =
      [
        ./hp
        {networking.hostName = "hp-petteri";}
      ]
      ++ sharedModules;

    specialArgs = {inherit inputs;};
    system = "x86_64-linux";
  };
}
