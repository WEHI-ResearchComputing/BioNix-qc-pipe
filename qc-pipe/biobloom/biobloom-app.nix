{ bionix, fetchurl, fetchFromGitHub, stdenv }:

with bionix;

let
  sdsl = stdenv.mkDerivation rec {
    name = "SDSL-${version}";
    version = "2.1.1";
    src = fetchFromGitHub {
      owner = "simongog";
      repo = "sdsl-lite";
      rev = "0546faf0552142f06ff4b201b671a5769dd007ad";
      sha256 = "sha256-khg74mmdM7H7Cy5dMG8RzSHQUI1l9tTfM4xxCy2DjZw=";
      fetchSubmodules = true;
    };
    buildInputs = with pkgs; [ cmake doxygen graphviz ];
  };
in
stdenv.mkDerivation rec {
  name = "BioBloom-${version}";
  version = "2.3.5";

  src = fetchurl {
    url = "https://github.com/bcgsc/biobloom/releases/download/2.3.5/biobloomtools-2.3.5.tar.gz";
    sha256 = "0jb73iagsk7dzfbqzpv3ac0mzzp5k1jmavbm9zb7czw6zk8c1yq3";
  };
  buildInputs = with pkgs; [ boost zlib.dev sparsehash sdsl ];
}
