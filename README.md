A Nix expression for building the [MirageOS](https://mirage.io/) utility.

Can be used traditionally or as a Nix flake.

# Traditional
```shell
nix-env -i -f https://github.com/ehmry/mirage-nix/archive/master.tar.gz
  # Install in the profile environment
```

# Flake

```shell
nix flake add mirage 'github:ehmry/mirage-nix'
  # Add this repository to the local registry

nix run mirage
  # Invoke the mirage tool

nix dev-shell mirage
  # Enter a shell with the mirage tool
```

# Updating

The [opam-selection.nix](./opam-selection.nix) file must be updated manually,
a makefile is provided for this.
