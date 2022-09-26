{ bionix, multiqc-package }:

with bionix;

rec {
  app = pkgs.callPackage ./multiqc-app.nix { inherit bionix; };
  #app = pkgs.callPackage multiqc-package; #{ inherit bionix; };

  report = callBionixE ./multiqc-report.nix;
}
