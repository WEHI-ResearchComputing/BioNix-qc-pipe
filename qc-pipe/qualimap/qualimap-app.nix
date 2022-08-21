{ bionix, stdenv }:

with bionix;

stdenv.mkDerivation rec {
  name = "QualiMap";
  version = "2.2.1";

  src = fetchurl {
    url = "https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip";
    sha256 = "0ig001brgkafii5wigf8j82ixx24xqxca9a2dk2pcg6895pddw88";
  };

  buildInputs = with pkgs; [ jre R ];

  installPhase =  '' 
    Rscript scripts/installDependencies.r
  '';
}