{ bionix }:

with bionix;

rec {
  biobloom = pkgs.callPackage ./biobloom-app.nix { inherit bionix; };

  filter = callBionixE ./biobloom-filter.nix;
}
