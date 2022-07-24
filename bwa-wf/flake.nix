{
  description = "Sample variant calling using Platypus variant caller";

  inputs = {
    bionix.url = "github:papenfusslab/bionix";
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "github:nixos/nixpkgs"; 

  outputs = { self, ... }: {
    lib = import ./.;
  };
}
