{ bionix }:

with bionix;

rec {
  biobloom = pkgs.callPackage ./biobloom-app.nix { inherit bionix; };

  filter = callBionixE ./biobloommaker.nix;
  categorize = callBionixE ./biobloomcategorizer.nix;
}
