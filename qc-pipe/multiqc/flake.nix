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
              qualimap = self.callBionix ../qualimap/qualimap.nix { };
              samtools-add = self.callBionix ../samtools-stats/samtools-add.nix { };
              fastq-screen = self.callBionix ../fastq-screen/fastq-screen.nix { };
              fastqc-add = self.callBionix ./fastqc-add.nix { };
              biobloom = self.callBionix ../biobloom/biobloom.nix { };
            })
          ];
          nixpkgs = import nixpkgs { inherit system; };
        };
      {
        defaultPackage = callBionix ./. { };
      }
      );
}
