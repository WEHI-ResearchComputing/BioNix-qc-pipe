# QC-pipe workflow that takes fastq files and perform different quality control metrics

{ bionix ? import <bionix> { } }:

with bionix;
with lib;

let
  qctools =
    let
      # an ecoli sample
      inputs =
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

      # reference ecoli sample
      ref = fetchFastA {
        url = "https://github.com/WEHIGenomicsRnD/qc-pipe/raw/main/.test/data/GCF_013166975.1_ASM1316697v1_genomic.fna";
        sha256 = "0rcph75mczwsn6q7aqcpdpj75vjd9v2insmhnf8dmcyyldz25dqi";
      };

      # "databases" (for fastq-screen)
      databases = {
        ecoli = ref;
      };

      # alignment of fastq files before qc via qualimap and samtools-stats 
      preprocess = flip pipe [
        (bwa.align { inherit ref; })
        (sambamba.sort { nameSort = false; })
      ];

      filter = biobloom.filter { } ref;
    in
    {
      qualimap = qualimap.check { } (preprocess inputs);
      samtools = samtools-add.stats { } (preprocess inputs);
      fastq-screen = fastq-screen.check { inherit databases; } inputs;
      fastqc = fastqc-add.check { } inputs.input1;
      biobloom = biobloom.categorize { inherit filter; } { input1 = inputs.input1; };
    };
in
multiqc.report { } qctools
