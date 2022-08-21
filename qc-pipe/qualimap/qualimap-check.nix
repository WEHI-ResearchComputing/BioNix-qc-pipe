{ bionix }:

input:

with bionix;
with lib;
with pkgs;

stage { 
  name = "qualimap-check";
  buildInputs = [ bionix.qualimap.qualimap ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/qualimap
    qualimap bamqc \
        -bam ${input} \
        -outdir $out/qualimap \
        -outformat HTML \
        -nt $NIX_BUILD_CORES
  '';
}
