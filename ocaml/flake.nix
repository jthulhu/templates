{
  description = "!NAME!";
  
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs;
    utils.url = github:numtide/flake-utils;
  };
  
  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };
      in {
        devShell = with pkgs; mkShell {
          buildInputs = [
            ocaml
            core
            core_extended
            findlib
            merlin
            utop
          ];
        };
    });
}
