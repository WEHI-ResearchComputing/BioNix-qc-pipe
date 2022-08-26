{ bionix }:

with bionix;

rec {
  biobloom = pkgs.callPackage ./biobloom-app.nix { inherit bionix; };

  report = callBionixE ./biobloom-report.nix;
}
