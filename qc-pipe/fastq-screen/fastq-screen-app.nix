{ bionix, stdenv, unzip, perl, fetchurl }:

with bionix;

stdenv.mkDerivation rec {
  name = "fastq-screen-${version}";
  version = "0.15.2";

  src = fetchurl {
    url = "https://github.com/StevenWingett/FastQ-Screen/archive/refs/tags/v0.15.2.zip";
    sha256 = "17wd03w57bxmy2iziw9fdiwdskfdqa0sx5fmg5mj2c9j7rg8sjgy";
  };

  buildInputs = with pkgs; [ bowtie2 unzip perl ];

  installPhase =  '' 
    mkdir -p $out/bin
    install -m755 -t $out/bin \
    ./fastq_screen \
    ./interactive_graphs.js \
    ./fastq_screen_summary_template.html \
    ./FastQ_Screen_Logo.png \
    ./OpenSans-Regular.ttf
  '';
}
