{ bionix }:

with bionix;

rec {
  # multiqc = pkgs.callPackage ./multiqc-app.nix { inherit bionix; };
  app = pkgs.callPackage multiqc-package; # .defaultPackage;

  report = callBionixE ./multiqc-report.nix;
}
