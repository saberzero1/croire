# Library Functions - Usage Examples

This document provides practical examples of how to use the library functions.

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
{ ... }:
{
  imports = (import ../../../lib/auto-import.nix) ./.;
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
{ ... }:
{
  imports =
    (import ../../../lib/auto-import.nix) ./.
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
{ ... }:
let
  casks =
    (import ../../../../lib/files-as-names.nix) ./.
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
```

## Example 4: Using Flake Library (for modules with flake context)

**File:** `modules/nixos/default.nix` (hypothetical)

```nix
{ flake, ... }:
{
  # Using flake.lib instead of standalone import
  imports = flake.lib.autoImport ./services;
  
  # Or for getting names
  casks = flake.lib.filesAsNames ./packages/casks;
}
```

## Example 5: Complex Case with Multiple Patterns

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
{ lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = (import ../../../../../../lib/auto-import.nix) ./.;

  programs.lazyvim.extraPackages = allGrammars;
}
```

## Path Calculation Guide

To determine the correct path:

1. Count the number of directory levels from your file to the repository root
2. Use that many `../` segments

Examples:
- `modules/nixos/services/default.nix` → 3 levels → `../../../lib/auto-import.nix`
- `modules/darwin/packages/casks/default.nix` → 4 levels → `../../../../lib/files-as-names.nix`
- `modules/home/shared/programs/lazyvim/plugins/default.nix` → 6 levels → `../../../../../../lib/auto-import.nix`

## Benefits

1. **Reduced code duplication**: The pattern appears only once in the library
2. **Easier maintenance**: Updates to the pattern logic only need to happen in one place
3. **Better readability**: The intent is clearer with a named function
4. **Consistency**: All files use the same approach
5. **Documentation**: The library files are documented with usage examples
