{ bionix }:

with bionix;

rec {
  check = callBionixE ./fastqc-check-redef.nix;
}
