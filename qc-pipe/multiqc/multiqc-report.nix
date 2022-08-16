{ bionix
, inputs
}:

with bionix;
with pkgs;
with lib;

let configFile = writeTextFile {
    name = "mutliqc_config";
    text = ''
      extra_fn_clean_exts:
      - "_R1"
    ''
}

in
stage { 
  name = "multiqc-report";
  buildInputs = with pkgs; [ bionix.multiqc.multiqc ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/multiQC
    # mutliqc commands
  '';
}