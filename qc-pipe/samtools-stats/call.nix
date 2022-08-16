{ bionix
, inputs
, ref
}:

with bionix;
with lib;

let
  preprocess = flip pipe [
    (samtools.stats { })
    (bwa.align { inherit ref; })
    (sambamba.sort { nameSort = true; })
    (samtools.fixmate { })
    (samtools.sort { })
    (samtools.markdup { })
  ];

in
map preprocess inputs