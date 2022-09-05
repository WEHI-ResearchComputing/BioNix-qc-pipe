{ bionix }:

# a list
input:

with bionix;
with pkgs;
with lib;

# let configFile = writeTextFile {
#   name = "mutliqc_config";
#   text = ''
#     extra_fn_clean_exts:
#     - "_R1"
#   '';
# };

# in
stage {
  name = "multiqc-report";
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
