A Nix expression for building the [MirageOS](https://mirage.io/) utility.

Can be used traditionally or as a Nix flake. The flake must unfortunately be 
evaluated at the moment in impure mode.

# Traditional
```shell
nix-env -i -f https://github.com/ehmry/mirage-nix/archive/master.tar.gz
  # Install in the profile environment
```

# Flake

```shell
nix flake add mirage 'github:ehmry/mirage-nix'
  # Add this repository to the local registry

nix app mirage --impure --
  # Invoke the mirage tool
```

# Updating

The [opam-selection.nix](./opam-selection.nix) file must be updated manually,
a makefile is provided for this.
