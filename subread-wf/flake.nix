{
  description = "A flake for building sample workflow using subread";

  inputs = {
    bionix.url = "github:papenfusslab/bionix";
    nixpkgs.url = "github:nixos/nixpkgs";
  };

  outputs = { self, ... }: {
  };
}
