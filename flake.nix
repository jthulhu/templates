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
        description = "[dev+pkg] Bash template.";
      };
      ocaml = {
        path = ./ocaml;
        description = "[dev] OCaml template.";
      };
      coq = {
        path = ./coq;
        description = "[dev] Coq template.";
      };
      pgsql = {
        path = ./pgsql;
        description = "[dev] PostgreSQL shell.";
      };
      latex-article = {
        path = ./latex-article;
        description = "[dev] Latex article template.";
      };
      pharo = {
        path = ./pharo;
        description = "[dev] Pharo template.";
      };
    };
  };
}
