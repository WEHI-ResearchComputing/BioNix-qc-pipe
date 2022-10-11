{ bionix
, flags ? null
}:

with bionix;
with lib;

input:

stage {
  name = "fastqc-check";
  buildInputs = [ bionix.fastqc.fastqc pkgs.unzip ];
  stripStorePaths = false; # we do it explicity for fastqc
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/FastQC
    fastqc \
      -o $out/FastQC \
      ${optionalString (flags != null) flags} \
      ${input}
  '';
}
