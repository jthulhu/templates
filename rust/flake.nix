{
  description = "NAME";
  inputs = {
    cargo2nix.url = github:cargo2nix/cargo2nix/master;
    nixpkgs.url = github:NixOS/nixpkgs/nixpkgs-unstable;
    utils.url = github:numtide/flake-utils;
    rust-overlay = {
      url = github:oxalica/rust-overlay;
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "utils";
      };
    };
  };

  outputs = { self, cargo2nix, nixpkgs, utils, rust-overlay }:
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            (import "${cargo2nix}/overlay")
            rust-overlay.overlay
          ];
        };
        rustPkgs = pkgs.rustBuilder.makePackageSet' {
          rustChannel = "1.60.0";
          packageFun = import ./Cargo.nix;
        };
      in rec {
        defaultPackage = (rustPkgs.workspace.NAME {}).bin;
        defaultApp = utils.lib.mkApp {
          drv = self.defaultPackage.${system};
        };
        devShell = with pkgs; mkShell {
          packages = [
            cargo
            rustc
            rustfmt
            pre-commit
            rustPackages.clippy
          ];
          RUST_SRC_PATH = rustPlatform.rustLibSrc;
        };
      });
}
