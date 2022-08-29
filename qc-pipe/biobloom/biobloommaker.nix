{ bionix
, flags ? null
, prefix ? "sample"
}:

input:

with bionix;
with lib;
with types;

assert (matchFiletype "biobloommaker" { fa = _: true; fq = _: true; } input);

stage {
  name = "biobloommaker";
  buildInputs = [ bionix.biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/filter
    biobloommaker -p ${prefix} ${optionalString (flags != null) flags} ${input} \
      -t $NIX_BUILD_CORES \
      -o $out/filter
  '';
}
