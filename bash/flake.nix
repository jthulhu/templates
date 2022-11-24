{
  description = "!NAME!";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
  };

  outputs = { nixpkgs, utils, ... }:
    utils.lib.eachDefaultSystem (system:
      let
        inherit (pkgs) writeShellApplication lib;
        pkgs = import nixpkgs { inherit system; };
        name = "!NAME!";
        dependencies = with pkgs; [
          # Script dependencies
        ];
        devDependencies = with pkgs; [
          shellcheck
        ];
        drv = writeShellApplication {
          inherit name;
          runtimeInputs = dependencies;
          text = builtins.readFile "./!NAME!.sh";
        };
      in rec {
        packages."!NAME!" = drv;
        defaultPackage = packages."!NAME!";
        apps."!NAME!" = utils.lib.mkApp {
          inherit drv;
        };
        defaultApp = apps."!NAME!";
        devShell = pkgs.mkShell {
          packages = dependencies ++ devDependencies;
        };
      });
}
