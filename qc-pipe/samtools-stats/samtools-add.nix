{ bionix }:

with bionix;

rec {
  stats = callBionixE ./samtools-stats.nix;
}
