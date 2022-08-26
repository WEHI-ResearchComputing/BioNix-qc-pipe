{ bionix }:

input:

with bionix;
with lib;
with pkgs;

stage {
  name = "biobloom-filter";
  buildInputs = [ bionix.biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/biobloomfilter
    biobloommaker -p input ${input} \
        -o $out/biobloomfilter
  '';
}
