{ pkgs ? import <nixpkgs> { } }:

with pkgs.lib;
with pkgs;

# write to .conf file 
writeTextFile {
  name = "fastq_screen.conf";
  text = "DATABASE\tHuman\t/some/path\nDATABASE\tMouse\t/some/other/path";
}
