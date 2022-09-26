{ bionix
, flags ? null
, filters
}:

{ input1
, input2 ? null
}:

with bionix;
with lib;
with types;

stage {
  name = "biobloomcategorizer";
  buildInputs = [ biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/biobloomcategorizer
    chmod 755 $out/biobloomcategorizer
    ln -s ${filters.txtFile} $out/biobloomcategorizer
    ln -s ${filters.bfFile} $out/biobloomcategorizer
    ln -s ${input1} $out/biobloomcategorizer
    cd $out/biobloomcategorizer
    biobloomcategorizer \
      ${optionalString (input2 != null) "-e"} \
      ${optionalString (flags != null) flags} \
      -f ${filters.bfFile} \
      ${input1} ${optionalString (input2 != null) input2}
  '';
}

# mkdir -p $out/biobloomcategorizer
# biobloomcategorizer ${optionalString (flags != null) flags} \
#   ${optionalString (paired == true) "-e"} \
#   -f ${filter} \
#   ${input} \
