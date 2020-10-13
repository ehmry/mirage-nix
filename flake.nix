{
  description = "A flake for building MirageOS unikernels";

  inputs = {
    opam2nix.url = "github:ehmry/opam2nix/v1-flake";
    nixpkgs.follows = "opam2nix/nixpkgs";
  };

  outputs = { self, nixpkgs, opam2nix }:
    let
      systems = [ "aarch64-linux" "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f system);
    in rec {

      packages = forAllSystems (system: {
        mirage = import ./. {
          pkgs = nixpkgs.legacyPackages.${system};
          opam2nix = opam2nix.defaultApp.${system};
        };
      });

      defaultPackage = forAllSystems (system: self.packages.${system}.mirage);

      devShell = forAllSystems (system:
        with nixpkgs.legacyPackages.${system};
        mkShell {
          buildInputs = [ gnumake opam self.packages.${system}.mirage ];
        });

    };
}
