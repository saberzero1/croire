# Library Functions

This directory contains documentation for the reusable utility functions available via `flake.inputs.self.lib.croire`.

## Usage

All modules in this repository use the `flake` parameter to access library functions. This provides access to library functions without any relative path calculations:

```nix
{ flake, ... }:
{
  # Auto-import all .nix files
  imports = flake.inputs.self.lib.croire.autoImport ./.;

  # Get filenames as names
  casks = flake.inputs.self.lib.croire.filesAsNames ./.;

  # Recursively import (rare use case)
  imports = flake.inputs.self.lib.croire.autoImportRecursive ./.;

  # Override licenses in flake (allows for evaluation of unfree packages in flakes)
  imports = flake.inputs.self.lib.croire.overrideLicenses pkgs.somePackage;
}
```

### Benefits:

- ✅ No path calculations needed
- ✅ Works in imports attribute (unlike module arguments)
- ✅ Type-safe via Nix
- ✅ More readable code
- ✅ Consistent across all modules

## Available Functions

### flake.inputs.self.lib.croire.autoImport

Automatically imports all `.nix` files in a directory except `default.nix`.

**Usage:**

```nix
{ flake, ... }:
{
  imports = flake.inputs.self.lib.croire.autoImport ./.;
}
```

**Replaces the pattern:**

```nix
imports = builtins.map (fn: ./${fn}) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
);
```

### flake.inputs.self.lib.croire.filesAsNames

Gets a list of filenames (without `.nix` extension) from a directory, excluding `default.nix`.

**Usage:**

```nix
{ flake, ... }:
let
  casks = flake.inputs.self.lib.croire.filesAsNames ./.;
in
{
  homebrew.casks = casks;
}
```

**Replaces the pattern:**

```nix
casks = builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf ./${fn})) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
);
```

### flake.inputs.self.lib.croire.autoImportRecursive

Recursively imports all `.nix` files in a directory tree (excluding `default.nix`).

**Usage:**

```nix
{ flake, ... }:
{
  imports = flake.inputs.self.lib.croire.autoImportRecursive ./.;
}
```

## How It Works

The library functions are defined in `/modules/flake/lib.nix` as a flake-parts module that exports `flake.lib.croire.*`.

Modules access these functions using the `flake` parameter, which provides access to the current flake's outputs via `flake.inputs.self.lib`:

```nix
# In any module
{ flake, ... }:
{
  imports = flake.inputs.self.lib.croire.autoImport ./.;
}
```

This approach works even in the `imports` attribute because `flake.inputs.self.lib` is evaluated early in the Nix evaluation process, unlike module arguments which aren't available until after imports are processed.

### flake.inputs.self.lib.croire.overrideLicenses

Overrides licenses in a package set to allow evaluation of unfree packages in flakes.

**Usage:**

```nix
{ flake, ... }:
{
  imports = flake.inputs.self.lib.croire.overrideLicenses pkgs.somePackage;
}
```

This function modifies the license attributes of packages to bypass restrictions on unfree software, enabling their evaluation within Nix flakes.
