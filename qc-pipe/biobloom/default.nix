# biobloom workflow using ecoli workflow

{ bionix ? import <bionix> { } }:

with bionix;
with lib;

let
  fastAFiles =
    {
      ecoli = fetchFastA {
        url = "https://github.com/WEHIGenomicsRnD/qc-pipe/raw/main/.test/data/GCF_013166975.1_ASM1316697v1_genomic.fna";
        sha256 = "0rcph75mczwsn6q7aqcpdpj75vjd9v2insmhnf8dmcyyldz25dqi";
      };
    };

in
biobloom.filter { inherit bionix; } fastAFiles.ecoli
