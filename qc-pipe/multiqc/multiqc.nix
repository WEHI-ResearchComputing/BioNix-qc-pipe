{ bionix }:

with bionix;

rec {
  multiqc = pkgs.callPackage ./multiqc-app.nix { inherit bionix; };

  report = callBionixE ./multiqc-report.nix;
}