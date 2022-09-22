{
  description = "!NAME!";
  
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = { self, nixpkgs, utils }:
    utils.lib.eachDefaultSystem (system:
      let
        inherit (pkgs.stdenv) mkDerivation;
        pkgs = import nixpkgs { inherit system; };
        buildInputs = with pkgs; [
          gcc
          gnumake
        ];
      in {
        defaultPackage = mkDerivation {
          inherit buildInputs;
          pname = "!NAME!";
          version = "0.1.0";
          src = ./.;
          makeFlags = [
            "PREFIX=${placeholder "out"}"
          ];
        };
        devShell = with pkgs; mkShell {
          packages = [
            clang-tools
            gdb
            valgrind
          ] ++ buildInputs;
        };
      });
}
