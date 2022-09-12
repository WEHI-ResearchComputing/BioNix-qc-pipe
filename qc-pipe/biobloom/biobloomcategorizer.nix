{ bionix
, flags ? null
, filters
}:

inputs:

with bionix;
with lib;
with types;

# fa/fq/compressed gz
# assert (matchFiletype "biobloomcategorizer-input" { fa = _: true; } inputs);

stage {
  name = "biobloomcategorizer";
  buildInputs = [ biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/biobloomcategorizer
    biobloomcategorizer ${optionalString (flags != null) flags} \
      -f ${filters} \
      ${inputs} \
  '';
}

# mkdir -p $out/biobloomcategorizer
# biobloomcategorizer ${optionalString (flags != null) flags} \
#   ${optionalString (paired == true) "-e"} \
#   -f ${filter} \
#   ${input} \
