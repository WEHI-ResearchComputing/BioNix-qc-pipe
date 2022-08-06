{ stdenv, unzip, perl, fetchurl }:

stdenv.mkDerivation rec {
  name = "fastq-screen-${version}";
  version = "0.15.2";

  src = fetchurl {
    url = "https://github.com/StevenWingett/FastQ-Screen/archive/refs/tags/v0.15.2.zip";
    sha256 = "19baxr9bc58fczaszgavq6ldfdhnkrb2v4m7f5zw7isq98qbg6vh";
  };

  buildInputs = [ unzip perl ];

  phases = ["unpackPhase" "installPhase" "fixupPhase" ];

  installPhase =  ''
    install -Dm755 ./fastq_screen $out/bin/fastq_screen
  '';
}
