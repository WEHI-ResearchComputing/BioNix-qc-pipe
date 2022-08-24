{ bionix, fetchurl, stdenv, unzip }:

with bionix;

let 
  sdsl = stdenv.mkDerivation rec {
    name = "SDSL-${version}";
    version = "2.1.1";
    src = fetchurl {
        url = "https://github.com/simongog/sdsl-lite/archive/refs/tags/v2.1.1.zip";
        sha256 = "0b5wfwr1z7p8qlyizwxd9yjbqfs4dckrd9fxbr60h1drjxfnyga6";
    };
    nativeBuildInputs = [ unzip ];
    buildInputs = with pkgs; [ cmake clang doxygen graphviz ];
    configurePhase = ''
      export HAVE_DOT="YES"
    '';
    installPhase = ''
      mkdir -p $out/bin
      BUILD_PORTABLE=1
    #   cp -r ./* $out/bin
    #   chmod 755 $out/bin/install.sh
    #   cd $out/bin
      chmod 755 $out/bin
      patchShebangs ./install.sh
    '';
  };
in
stdenv.mkDerivation rec {
  name = "BioBloom-${version}";
  version = "2.3.5";
  src = fetchurl {
      url = "https://github.com/bcgsc/biobloom/archive/refs/tags/2.3.5.zip";
      sha256 = "1ayd1jsbnb778jn59ahn87qym1b5ajmn85pynj9l2xdf8wyv3ggb";
  };

  nativeBuildInputs = [ unzip ];
  buildInputs = with pkgs; [ gcc boost zlib.dev sparsehash automake autoconf sdsl ];
  installPhase =  '' 
    mkdir -p $out/bin
    cp -r ./* $out/bin
    chmod 755 $out/bin
    cd $out/bin
    ./autogen.sh
    ./configure --with-sdsl=$sdsl && make install
  '';
}