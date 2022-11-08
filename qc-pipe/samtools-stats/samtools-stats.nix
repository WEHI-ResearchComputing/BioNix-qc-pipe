{ bionix }:

input:

with bionix;
with lib;
with types;

assert (matchFiletype "samtools-stats" { bam = _: true; cram = _: true; sam = _: true; } input);

stage {
  name = "samtools-stats";
  buildInputs = with pkgs; [ samtools ];
  outputs = [ "out" ];
  buildCommand = ''
    samtools stats ${input} > $out
  '';
}
