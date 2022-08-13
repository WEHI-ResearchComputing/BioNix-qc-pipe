{ bionix }:

with bionix;

rec {
  fastq-screen = pkgs.callPackage ./fastq-screen-app.nix { inherit bionix; };

  check = callBionixE ./fastq-screen-check.nix;
}
