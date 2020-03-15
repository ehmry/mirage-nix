opam-selection.nix: Makefile flake.nix flake.lock
	nix app .#opam2nix --impure -- resolve mirage

all: opam-selection.nix
