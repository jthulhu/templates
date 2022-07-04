{
  description = "!NAME!";
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
  };
  outputs = { self, nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
        pypkgs = ps: with ps; [
          # Python packages
        ];
        pythonWithPkgs = pkgs.python3.withPackages pypkgs;
      in {
        devShell = with pkgs; mkShell {
          buildInputs = [
            pythonWithPkgs
            python3Packages.ptpython
          ];
        };
      });            
}
