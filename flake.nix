{
  description = "My personal templates";
  outputs = { self }: {
    templates = {
      rust-bin = {
        path = ./rust-bin;
        description = "[dev+pkg] Rust template, with Naersk and rust-overlay.";
      };
      rust-lib = {
        path = ./rust-lib;
        description = "[dev+pkg] Rust template, with Naersk and rust-overlay, for libraries.";
      };
      c = {
        path = ./c;
        description = "[dev+pkg] C template.";
      };
      python = {
        path = ./python;
        description = "[dev+pkg] Python template.";
      };
      bash = {
        path = ./bash;
        description = "[dev] Bash template.";
      };
      ocaml = {
        path = ./ocaml;
        description = "[dev] OCaml template.";
      };
      latex-article = {
        path = ./latex-article;
        description = "[dev] Latex article template.";
      };
    };
  };
}
