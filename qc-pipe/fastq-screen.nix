{ bionix }:

with bionix;

{
  fastq-screen = pkgs/callPackage ./fastq-screen-app.nix { };

  check = callBionixE ./fastq-screen-check.nix;
}
