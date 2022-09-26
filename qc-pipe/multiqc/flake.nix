{
  description = "Flake MultiQC-wf on ecoli genome";

  inputs = {
    bionix.url = "github:papenfusslab/bionix";
    nixpkgs.url = "github:nixos/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
    multiqc-flake.url = "github:ewels/multiqc";
  };

  outputs = { self, nixpkgs, bionix, flake-utils, multiqc-flake }:
    flake-utils.lib.eachDefaultSystem
      (system: with bionix.lib
        {
          overlays = [
            (self: super: rec {
              multiqc-package = multiqc-flake.packages.${system}.default;
              multiqc = self.callBionix ./multiqc.nix { inherit multiqc-package; };
            })
          ];
          nixpkgs = import nixpkgs { inherit system; };
        };
      {
        defaultPackage = callBionix ./. { };
      }
      );
}
