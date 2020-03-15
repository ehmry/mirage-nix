{ self ? ./., pkgs ? import <nixpkgs> { }, opam2nix ? import
  (builtins.fetchTarball
    "https://github.com/timbertson/opam2nix/archive/v1.tar.gz") { } }:

let
  selection = opam2nix.build {
    ocaml = pkgs.ocaml-ng.ocamlPackages_4_08.ocaml;
    selection = ./opam-selection.nix;
    src = self;
  };
in selection.mirage
