{ bionix ? import <bionix> { }
, inputs
, ref
}:

with bionix;
with lib;
with pkgs;

let
  preprocess = flip pipe [
    (samtools-add.stats { })
    (bwa.align { inherit ref; })
    (sambamba.sort { nameSort = true; })
    (samtools.fixmate { })
    (samtools.sort { })
    (samtools.markdup { })
  ];

in
map (preprocess) inputs