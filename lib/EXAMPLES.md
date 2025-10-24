# Library Functions - Usage Examples

This document provides practical examples of how to use the library functions via `flake.inputs.self.lib.croire`.

## Example 1: Simple Auto-Import

**File:** `modules/nixos/services/default.nix`

**Before:**
```nix
{ ... }:
{
  imports = builtins.map (fn: ./${fn}) (
    builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  );
}
```

**After:**
```nix
{ flake, ... }:
{
  imports = flake.inputs.self.lib.croire.autoImport ./.;
}
```

## Example 2: Auto-Import with Additional Imports

**File:** `modules/home/shared/default.nix`

**Before:**
```nix
{ ... }:
{
  imports =
    builtins.map (fn: ./${fn})
      (
        builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
      )
    ++ [
      ./languages
      ./programs
      ./services
      ./settings
    ];
}
```

**After:**
```nix
{ flake, ... }:
{
  imports =
    flake.inputs.self.lib.croire.autoImport ./.
    ++ [
      ./languages
      ./programs
      ./services
      ./settings
    ];
}
```

## Example 3: Extracting Filenames as Names

**File:** `modules/darwin/packages/casks/default.nix`

**Before:**
```nix
{ ... }:
let
  casks =
    builtins.map (fn: builtins.replaceStrings [ ".nix" ] [ "" ] (builtins.baseNameOf ./${fn}))
      (
        builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
      )
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
```

**After:**
```nix
{ flake, ... }:
let
  casks =
    flake.inputs.self.lib.croire.filesAsNames ./.
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
```

## Example 4: Complex Case with Multiple Patterns

**File:** `modules/home/shared/programs/lazyvim/plugins/default.nix`

**Before:**
```nix
{ lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = builtins.map (fn: ./${fn}) (
    builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
  );

  programs.lazyvim.extraPackages = allGrammars;
}
```

**After:**
```nix
{ flake, lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = flake.inputs.self.lib.croire.autoImport ./.;

  programs.lazyvim.extraPackages = allGrammars;
}
```

## How It Works

The library functions work through the flake system:

1. **Flake-parts module** (`/modules/flake/lib.nix`) exports `flake.lib.croire.*`
2. **Modules** use the `flake` parameter to access the library via `flake.inputs.self.lib.croire`
3. **No intermediate arguments** needed - direct access through flake outputs

This works even in the `imports` attribute because `flake.inputs.self.lib` is evaluated early in the Nix evaluation process, unlike module arguments which aren't available until after imports are processed.

## Benefits

1. **Works in imports**: Can be used in the `imports` attribute (unlike module arguments)
2. **No path calculations**: Access functions via flake parameter, not relative imports
3. **Type-safe**: Nix validates the function exists
4. **Reduced code duplication**: Pattern defined once in flake-parts module
5. **Easier maintenance**: Updates happen in one place
6. **Better readability**: `flake.inputs.self.lib.croire.autoImport` is clearer than nested builtins
7. **Consistency**: All modules use the same pattern
8. **Documentation**: Functions are well-documented
