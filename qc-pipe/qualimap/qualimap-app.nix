{ bionix, stdenv, fetchurl, rPackages, rWrapper, R, unzip, makeWrapper }:

with bionix;
let
  r = rWrapper.override {
    packages = with rPackages; [ optparse NOISeq XML Repitools Rsamtools rtracklayer];
  };
in 
stdenv.mkDerivation rec {
  name = "QualiMap-${version}";
  version = "2.2.1";
  src = fetchurl {
      url = "https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip";
      sha256 = "0ig001brgkafii5wigf8j82ixx24xqxca9a2dk2pcg6895pddw88";
  };
  nativeBuildInputs = [ unzip ];
  propagatedBuildInputs = with pkgs; [ jre ];
  buildInputs = [  r makeWrapper ];

  installPhase = ''
    mkdir -p $out/bin
    cp -r ./* $out/bin
    chmod 755 $out/bin
  '';
}