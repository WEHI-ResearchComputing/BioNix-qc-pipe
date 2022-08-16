{ bionix, stdenv }:

with bionix;

stdenv.mkDerivation rec {
  name = "";
  version = "";

  src = fetchurl {
    url = "";
    sha256 = "";
  };

  buildInputs = [ ] ;

  installPhase =  '' 
  '';
}