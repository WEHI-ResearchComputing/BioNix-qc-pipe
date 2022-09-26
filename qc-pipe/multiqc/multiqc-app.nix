{ bionix, python38Packages }:

with bionix;

python38Packages.buildPythonPackage rec {
  name = "MultiQC-1.14";
  src = ./.;
  # propogatedBuildInputs = [ python38Packages.setuptools ];
  buildInputs = [ multiqc-package ];
}
