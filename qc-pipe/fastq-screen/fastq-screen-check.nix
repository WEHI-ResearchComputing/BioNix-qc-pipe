{ bionix
, flags? null
, databases 
}:

input:

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
          else "$(head path)\t${toString value}";
        in
          attrs: concatStringsSep "\n" (flatten (recurse [] attrs));
      in with bionix; concatStringsSep "\n" [
        "BOWTIE2 ${bowtie2}/bin/bowtie2"
        "${toFastQConf {
          DATABASE = lib.mapAttrs (_: s: "${bowtie.index {} s}") databases;
        }}/ref"
      ];
  };
in stage { 
  name = "fastq-screen-check";
  buildInputs = with pkgs; [ bionix.fastq-screen.fastq-screen bowtie2 ];
  stripStorePaths = false;
  outputs = [ "out" ];
  buildCommand = ''
    mkdir -p $out/fastqScreen
    fastq_screen --aligner bowtie2 \
        --conf ${configFile} \
        --threads $NIX_BUILD_CORES \
        --outdir $out/fastqScreen \
        ${input.input1} ${input.input2}
  '';
}
