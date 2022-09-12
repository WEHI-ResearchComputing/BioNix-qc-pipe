{
  description = "Flake for samtools-stats workflow";

  inputs = {
    bionix.url = "github:papenfusslab/bionix";
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, bionix, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: with bionix.lib
        {
          overlays = [ (self: super: { samtools-add = self.callBionix ./samtools-add.nix { };} ) ];
          nixpkgs = import nixpkgs { inherit system; };
        };
        {
          defaultPackage = callBionix ./. { };
        }
      );
}
