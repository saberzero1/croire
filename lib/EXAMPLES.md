# Library Functions - Usage Examples

This document provides practical examples of how to use the library functions via the `croire-lib` parameter.

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
{ croire-lib, ... }:
{
  imports = croire-lib.autoImport ./.;
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
{ croire-lib, ... }:
{
  imports =
    croire-lib.autoImport ./.
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
{ croire-lib, ... }:
let
  casks =
    croire-lib.filesAsNames ./.
    ++ [
      "nikitabobko/tap/aerospace"
    ];
in
{
  homebrew.casks = casks;
}
```

## Example 4: Parent Module Passing croire-lib

**File:** `modules/nixos/default.nix`

This shows how parent modules make `croire-lib` available to their children:

```nix
{ flake, pkgs, ... }:
{
  imports = [
    ./services
    ./packages
    ./system
  ];

  # Make library functions available to all child modules
  _module.args = {
    croire-lib = flake.lib.croire;
  };
  
  # ... rest of configuration
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
{ croire-lib, lib, pkgs, ... }:
let
  grammarPackages = builtins.attrValues pkgs.vimPlugins.nvim-treesitter-parsers;
  filterNonPackage = builtins.filter lib.isDerivation;
  filterBroken = builtins.filter (n: !n.meta.broken);
  filterEmpty = builtins.filter (n: n.pname or "" != "");
  allGrammars = filterEmpty (filterBroken (filterNonPackage grammarPackages));
in
{
  imports = croire-lib.autoImport ./.;

  programs.lazyvim.extraPackages = allGrammars;
}
```

## How croire-lib Is Passed Down

The `croire-lib` parameter is automatically available in all modules through the module argument system:

1. **Flake-parts module** (`/modules/flake/lib.nix`) exports `flake.lib.croire.*`
2. **Parent modules** receive `flake` context and pass `croire-lib` via `_module.args`
3. **Child modules** receive `croire-lib` as a parameter

No path calculations needed! Just use `{ croire-lib, ... }:` in your module signature.

## Benefits

1. **No path calculations**: Access functions via parameter, not relative imports
2. **Type-safe**: Module system validates the parameter exists
3. **Reduced code duplication**: Pattern defined once in flake-parts module
4. **Easier maintenance**: Updates happen in one place
5. **Better readability**: `croire-lib.autoImport` is clearer than nested builtins
6. **Consistency**: All modules use the same pattern
7. **Documentation**: Functions are well-documented
