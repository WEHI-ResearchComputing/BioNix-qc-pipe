# Example workflow to run fastq-screen to evaluate quality of input against reference genome

{ bionix ? import <bionix> { } }:

with bionix;
with lib;

let
  # a list of of inputs (a paired set)
  inputs = 
    {
        input1 = fetchFastQ {
          url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-1.fq";
          sha256 = "qE6s8hKowiz3mvCq8/7xAzUz77xG9rAcsI2E50xMAk4=";
        };

        input2 = fetchFastQ {
          url = "https://github.com/PapenfussLab/bionix/raw/master/examples/sample1-2.fq";
          sha256 = "0czk85km6a91y0fn4b7f9q7ps19b5jf7jzwbly4sgznps7ir2kdk";
        };
      };
  

  # list of seq databases
  databases = [ fetchFastA {
    url = "https://github.com/PapenfussLab/bionix/raw/master/examples/ref.fa";
    sha256 = "0sy9hq8n55knfkiblam50dzaiwhrx6pv8b8l1njdn6kfj4wflz2p";
  } ];

in
fastq-screen.check { inherit inputs databases bionix; } 
