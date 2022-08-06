{ bionix
, flags? null
, ref
}:

with bionix;
with lib;

{ input
, database? ref
}:

stage { 
  name = "fastq-screen-check";
  buildInputs = [ bionix.fastq-screen.fastq-screen ];
  stripStorePaths = false;
  outputs = [ "out" "zip" ];
  buildCommand = ''
    # write config file


    # run command
    fastq_screen --conf {fastq_screen.conf} \
      --outdir results/fastqScreen \
      {input.r1} {input.r2} #figure out how r1 and r2 is related to this line
    # 

    # replace output file name
    sed "s|$(basename ${input})|input|g" *.html > $out
    cp *.zip $zip
  '';
} 
