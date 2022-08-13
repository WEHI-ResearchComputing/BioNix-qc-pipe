{ bionix
, flags? null
, databases ? bionix.ref.grch38.seq
, inputs
}:

with bionix;
with lib;
with pkgs;

# write to .conf file 
let 
  configFile = writeTextFile {
    name = "fastq_screen.conf";
    text = 
      let toFastQConf = 
        let recurse = path: value:
          if isAttrs value && !isDerivation value
          then mapAttrsToList (n: recurse ([n] ++ path)) value
          else if length path > 1
          then "${concatStringsSep "\t" (reverseList path)}\t${toString value}"
          else "$(head path)\t$(toString value}";
        in
          attrs: concatStringsSep "\n" (flatten (recurse [] attrs));
      in 
        with bionix; toFastQConf { DATABASE = lib.mapAttrs (_: s: "${bowtie.index {} s}/ref") {grch38 = ref.grch38.seq;};};
  };

in stage { 
  name = "fastq-screen-check";
  buildInputs = [ bionix.fastq-screen.fastq-screen ];
  stripStorePaths = false;
  outputs = [ "out" "zip" ];
  buildCommand = ''
    mkdir -p $out/results/fastqScreen
    fastq_screen --conf ${configFile} \
        --outdir $out/results/fastqScreen \
        ${inputs.input1} ${inputs.input2}
  '';
}
