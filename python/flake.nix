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
        pkg = pkgs.python3Packages.buildPythonApplication {
          pname = "!NAME!";
          version = "0.1.0";
          src = ./.;
          propagatedBuildInputs = pypkgs pkgs.python3Packages;
        };
      in {
        devShell = with pkgs; mkShell {
          buildInputs = [
            pythonWithPkgs
            python3Packages.ptpython
          ];
        };
        defaultPackage = pkg;
        defaultApp = utils.lib.mkApp {
          drv = pkg;
        };
      });
}
