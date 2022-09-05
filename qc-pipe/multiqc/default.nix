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
  dir = linkOutputs
    {
      "fastqc-report" = fastqc.check { } inputs1.input1;
    };
in
multiqc.report { } dir
