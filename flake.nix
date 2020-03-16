{
  description = "A flake for building MirageOS unikernels";

  edition = 201909;

  inputs = {
    opam2nix = {
      type = "github";
      owner = "ehmry";
      repo = "opam2nix";
      ref = "v1-flake";
    };

    nixpkgs.follows = "opam2nix/nixpkgs";
  };

  outputs = { self, nixpkgs, opam2nix }:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      mirage = import ./. {
        inherit pkgs;
        opam2nix = opam2nix.defaultApp.x86_64-linux;
      };
    in rec {

      packages.x86_64-linux.mirage = mirage;
      defaultPackage.x86_64-linux = mirage;

      apps.x86_64-linux = {
        mirage = {
          type = "app";
          program = mirage + "/bin/mirage";
        };

        inherit (opam2nix.apps.x86_64-linux) opam2nix;
      };

      defaultApp.x86_64-linux = self.apps.x86_64-linux.mirage;

      devShell.x86_64-linux = pkgs.mkShell {
        buildInputs = with pkgs; [ gnumake opam ] ++ [ mirage ];
      };

    };
}
