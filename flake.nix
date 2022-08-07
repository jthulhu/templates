{
  description = "My personal templates";
  outputs = { self }: {
    templates = {
      rust = {
        path = ./rust;
        description = "[dev+pkg] Rust template, with Naersk and rust-overlay.";
      };
      rust-prologin = {
        path = ./rust-prologin;
        description = "[dev] Rust template for prologin problem submission.";
      };
      c = {
        path = ./c;
        description = "[dev] C template.";
      };
      python = {
        path = ./python;
        description = "[dev+pkg] Python template.";
      };
      bash = {
        path = ./bash;
        description = "[dev]Bash template.";
      };
      ocaml = {
        path = ./ocaml;
        description = "[dev] OCaml template.";
      };
    };
  };
}
