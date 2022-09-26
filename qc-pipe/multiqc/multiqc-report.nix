{ bionix }:

# a list
input:

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
    multiqc \
      # concat a list of qc tools output files DIRECTORY
      $input \
      -o $out/multiQC -f
  '';
}
#       --config ${configFile} \
#     ${concatStringsSep " \$" inputs}
