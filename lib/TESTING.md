# Testing Library Functions

This document describes how to test the library functions to ensure they work correctly.

## Testing croire-lib Functions

The library functions are accessed via the `croire-lib` parameter in modules. Testing is done by verifying the configuration builds successfully.

### Testing autoImport

Check that modules using `croire-lib.autoImport` work correctly:

```bash
# From the repository root
# Verify a module can be evaluated
nix-instantiate --eval --strict -E '
  let
    flake = builtins.getFlake (toString ./.);
    croire-lib = flake.lib.croire;
  in
    croire-lib.autoImport ./modules/nixos/services
'
```

Expected: A list of paths to all .nix files in the directory except default.nix

### Testing filesAsNames

Check that `croire-lib.filesAsNames` extracts filenames correctly:

```bash
# From the repository root
nix-instantiate --eval --strict -E '
  let
    flake = builtins.getFlake (toString ./.);
    croire-lib = flake.lib.croire;
  in
    croire-lib.filesAsNames ./modules/darwin/packages/casks
'
```

Expected: A list of filenames without the .nix extension

### Testing flake.lib.croire exports

Check that the flake exports the library functions:

```bash
# From the repository root
nix eval .#lib.croire.autoImport --apply 'x: "function exists"'
```

## Integration Testing

The best way to test is to build the configuration:

```bash
# For NixOS
sudo om ci run .#switch

# For macOS/Darwin
sudo om ci run .#switch
```

## Verification Checklist

- [ ] All 36 modules updated to use `croire-lib` parameter
- [ ] No syntax errors in modified files
- [ ] modules/flake/lib.nix exports `flake.lib.croire` functions
- [ ] Parent modules pass `croire-lib` via `_module.args`
- [ ] Documentation updated
- [ ] Configuration builds successfully
- [ ] No broken imports

## Common Issues

### Module Parameter Not Available

If a module can't find `croire-lib`, verify:
1. The parent module has `flake` context
2. The parent module passes `croire-lib` via `_module.args`
3. The child module declares `croire-lib` in its parameters

### Syntax Errors

Check for:
- Missing `croire-lib` in module parameters
- Incorrect function call syntax
- Missing semicolons
