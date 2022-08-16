{ bionix }:

with bionix;
with lib;
with pkgs;

stage {
  name = "fastq-screen-check";
  buildInputs = [ bionix.biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
  '';
}