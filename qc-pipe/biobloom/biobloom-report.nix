{ bionix }:

input:

with bionix;
with lib;
with pkgs;

stage {
  name = "biobloom-info";
  buildInputs = [ bionix.biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    ./biobloommaker -p input $input
  '';
}