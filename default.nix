{ self ? ./., pkgs ? import <nixpkgs> { }, opam2nix ? import
  (builtins.fetchTarball
    "https://github.com/timbertson/opam2nix/archive/v1.tar.gz") { } }:

let
  ocaml = pkgs.ocaml-ng.ocamlPackages_4_08.ocaml;
  selection = opam2nix.build {
    inherit ocaml;
    selection = ./opam-selection.nix;
    src = self;
  };

in selection.mirage.overrideAttrs (
  attrs: {
    nativeBuildInputs = attrs.nativeBuildInputs or [ ] ++ [ pkgs.makeWrapper ];
    preFixup = let binPath = pkgs.lib.makeBinPath [ selection.dune ocaml pkgs.gcc ];
    in ''
      env
      wrapProgram $out/bin/mirage \
        --prefix PATH : ${binPath} \
        --prefix OCAMLPATH : "$OCAMLPATH:$out/lib/ocaml/${ocaml.version}/site-lib"
    '';
  })
