{ bionix }:

with bionix;

rec {
  qualimap = pkgs.callPackage ./qualimap-app.nix { inherit bionix; };

  check = callBionixE ./qualimap-check.nix;
}
