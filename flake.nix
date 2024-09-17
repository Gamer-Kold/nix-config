{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }: {

    nixosConfigurations.pandora = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [ ./pandora-configuration.nix ./pandora-hardware.nix];
    };

  };
}
