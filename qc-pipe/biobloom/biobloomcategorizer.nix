{ bionix
, flags ? null
, paired ? false
}:

{ filter
, input
}:

with bionix;
with lib;
with types;

# fa/fq/compressed gz
assert (matchFiletype "biobloomcategorizer" { fa = _: true; fq = _: true; } input);

stage {
  name = "biobloomcategorizer";
  buildInputs = [ bionix.biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/biobloomcategorizer
    biobloomcategorizer ${optionalString (flags != null) flags} \
      ${optionalString (paired == true) "-e"} \
      -f ${filter} \
      ${input} \
  '';
}
