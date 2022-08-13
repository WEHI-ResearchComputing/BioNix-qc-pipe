{ bionix, stdenv, unzip, perl, fetchurl }:

with bionix;

stdenv.mkDerivation rec {
  name = "fastq-screen-${version}";
  version = "0.15.2";

  src = fetchurl {
    url = "https://github.com/StevenWingett/FastQ-Screen/archive/refs/tags/v0.15.2.zip";
    sha256 = "/kmNXj4yMSFredWVroHCzU3deGwu8fij8LWvU/gAjZ8=";
  };

  buildInputs = with pkgs; [ bowtie2 unzip perl ];

  installPhase =  ''
    install -Dm755 ./fastq_screen $out/bin/fastq_screen
  '';
}
