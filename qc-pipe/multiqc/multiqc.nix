{ bionix, multiqc-package }:

with bionix;

rec {
  report = callBionixE ./multiqc-report.nix;
}
