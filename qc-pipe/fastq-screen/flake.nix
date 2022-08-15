{
  description = "Flake fastq-screen-wf on ecoli genome";

  inputs = {
    bionix.url = "github:papenfusslab/bionix";
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, bionix, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system: with bionix.lib
        {
          overlays = [ (self: super: { fastq-screen = self.callBionix ./fastq-screen.nix { };})];
          nixpkgs = import nixpkgs { inherit system; };
        };
        {
          defaultPackage = callBionix ./. { };
        }
      );
}
