{ bionix }:

# attrs
inputs:

with bionix;
with pkgs;
with lib;

stage {
  name = "multiqc-report";
  # nativeBuildInputs = [ python38Packages.setuptools ];
  buildInputs = [ multiqc-package ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/multiQC
    multiqc ${lib.concatStringsSep " " (lib.mapAttrsToList (_: val: "${val}") inputs)} \
      --outdir $out/multiQC
  '';
}
#       --config ${configFile} \
#     ${concatStringsSep " \$" inputs}
