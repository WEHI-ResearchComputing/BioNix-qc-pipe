{ bionix }:

input:

with bionix;
with lib;
with pkgs;

stage {
  name = "qualimap-check";
  buildInputs = with pkgs; [ bionix.qualimap.qualimap jre8 ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/qualimap
    export JAVA_OPTS="-Djava.awt.headless=true" && qualimap bamqc \
        -bam ${input} \
        -outdir $out/qualimap \
        -outformat HTML \
        -nt $NIX_BUILD_CORES
  '';
  passthru.multicore = true;
}
