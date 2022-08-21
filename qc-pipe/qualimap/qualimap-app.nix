{ bionix, stdenv, fetchurl, rPackages, rWrapper, R, unzip, jre}:

with bionix;
let
  inherit (rPackages) buildRPackage;
#   NOISeq = buildRPackage rec {
#     name = "NOISeq-${version}";
#     version = "2.40.0";
#     src = fetchurl {
#         url = "https://bioconductor.org/packages/release/bioc/src/contrib/NOISeq_2.40.0.tar.gz";
#         sha256 = "0ah6adlhv4254jkssinn2ik8n811hd1nw85bnzqk2kwhl49nrk27";
#     };
#     buildInputs = with rPackages; [ R Biobase Matrix ];
#   };

#   Repitools = buildRPackage rec {
#     name = "";
#     version = "";
#     src = fetchurl {
#         url = "";
#         sha256 = "";
#     };
#     buildInputs = [ R ];
#   };

#   Rsamtools = buildRPackage rec {
#     name = "";
#     version = "";
#     src = fetchurl {
#         url = "";
#         sha256 = "";
#     };
#     buildInputs = [ R ];
#   };

#   rtracklayer = buildRPackage rec {
#     name = "";
#     version = "";
#     src = fetchurl {
#         url = "";
#         sha256 = "";
#     };
#     buildInputs = [ R ];
#   };

#   qualimap = buildRPackage rec {
#     name = "QualiMap-${version}";
#     version = "2.2.1";
#     requireX = false;
#     src = fetchurl {
#         url = "https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip";
#         sha256 = "0ig001brgkafii5wigf8j82ixx24xqxca9a2dk2pcg6895pddw88";
#     };
#     propagatedBuildInputs = with rPackages; [ R XML optparse NOISeq Repitools Rsamtools rtracklayer ];
#   };

# r-optparse-1.7.1
# r-NOISeq-2.40.0
# r-Repitools-1.42.0
# r-Rsamtools-2.12.0
# r-rtracklayer-1.56.1

#   r = rWrapper.override {
#     packages = with rPackages; [ qualimap ];
#   };
in 
stdenv.mkDerivation rec {
#   inherit (qualimap) name;
#   inherit (qualimap) version;

  name = "QualiMap-${version}";
  version = "2.2.1";
  src = fetchurl {
      url = "https://bitbucket.org/kokonech/qualimap/downloads/qualimap_v2.2.1.zip";
      sha256 = "0ig001brgkafii5wigf8j82ixx24xqxca9a2dk2pcg6895pddw88";
  };
  propagatedBuildInputs = with rPackages; [ R XML optparse NOISeq Repitools Rsamtools rtracklayer ];
#   buildInputs = with pkgs; [ jre r unzip ];
  buildInputs = [ jre unzip ];

#   unpackPhase = ''
#     unzip $src -d $TMPDIR
#   '';

  installPhase =  ''
    mkdir -p $out/libexec/qualimap
    cp -r . $out/libexec/qualimap
    mkdir $out/bin
    ln -s $out/libexec/qualimap/qualimap $out/bin
    chmod 755 $out/libexec/qualimap/qualimap
  '';
}