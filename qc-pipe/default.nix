# Example workflow to align input against reference genome (defaults to GRCH38)

{ bionix ? import <bionix> { }
, ref ? bionix.ref.grch38.seq
}:

with bionix;
with lib;

let
  preprocess = flip pipe [
    (subread.align { inherit ref; })
    (sambamba.sort { })
  ];

  inputs = [
    # Sample 1
      {
        input1 = fetchFastQ {
          url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-1.fq";
          sha256 = "qE6s8hKowiz3mvCq8/7xAzUz77xG9rAcsI2E50xMAk4=";
        };

        input2 = fetchFastQ {
          url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-2.fq";
          sha256 = "0czk85km6a91y0fn4b7f9q7ps19b5jf7jzwbly4sgznps7ir2kdk";
        };
      }
  ];
  ref = fetchFastA {
    url = "https://github.com/PapenfussLab/bionix/raw/master/examples/ref.fa";
    sha256 = "0sy9hq8n55knfkiblam50dzaiwhrx6pv8b8l1njdn6kfj4wflz2p";
  };

in 
fastqc.fastqc { } (map preprocess inputs)

