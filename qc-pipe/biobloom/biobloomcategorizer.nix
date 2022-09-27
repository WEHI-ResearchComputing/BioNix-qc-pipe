{ bionix
, flags ? null
, filter
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
    biobloomcategorizer \
      -t $NIX_BUILD_CORES \
      ${optionalString (input2 != null) "-e"} \
      ${optionalString (flags != null) flags} \
      -f ${filter}/filter.bf \
      ${input1} ${optionalString (input2 != null) input2}
    cp _summary.tsv $out
  '';
  passthru.multicore = true;
}
