# biobloom workflow using ecoli data

{ bionix ? import <bionix> { } }:

with bionix;
with lib;
with pkgs;

let
  inputs =
    {
      ecoli = fetchFastA {
        url = "https://github.com/WEHIGenomicsRnD/qc-pipe/raw/main/.test/data/GCF_013166975.1_ASM1316697v1_genomic.fna";
        sha256 = "0rcph75mczwsn6q7aqcpdpj75vjd9v2insmhnf8dmcyyldz25dqi";
      };
    };
  fq =
    {
      input1 = fetchFastQGZ {
        url = "https://github.com/WEHIGenomicsRnD/qc-pipe/raw/main/.test/fastq/ecoli_R1.fastq.gz";
        sha256 = "1zlz4c03xqi6lqkr2vkzm5h785jnx9sp956dwz4aiaij8w3jfsdb";
      };
      input2 = fetchFastQGZ {
        url = "https://github.com/WEHIGenomicsRnD/qc-pipe/raw/main/.test/fastq/ecoli_R2.fastq.gz";
        sha256 = "122gbmi4z7apxqlbjzjad0sqzxswnppa2jvix6nhf32sfvc48d54";
      };
    };
  filter = biobloom.filter { } inputs.ecoli;
in
biobloom.categorize { inherit filter; } { input1 = fq.input1; }
