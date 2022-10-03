{ bionix
, flags ? null
}:

inputs:

with bionix;
with lib;
with types;

let
  fafq = f: matchFiletype "biobloommaker" { fa = _: f; fq = _: f; gz = matchFiletype' "biobloommaker" { fa = _: f; fq = _: f; }; } f;
in
stage {
  name = "biobloommaker";
  buildInputs = [ biobloom.biobloom ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out
    biobloommaker -p filter ${optionalString (flags != null) flags} ${fafq inputs} \
      -t $NIX_BUILD_CORES \
      -o $out
  '';
  passthru.multicore = true;
}
