# Testing Library Functions

This document describes how to test the library functions to ensure they work correctly.

## Testing flake.inputs.self.lib.croire Functions

The library functions are accessed via `flake.inputs.self.lib.croire` in modules. Testing is done by verifying the configuration builds successfully.

### Testing autoImport

Check that modules using `flake.inputs.self.lib.croire.autoImport` work correctly:

```bash
# From the repository root
# Verify a module can be evaluated
nix-instantiate --eval --strict -E '
  let
    flake = builtins.getFlake (toString ./.);
  in
    flake.lib.croire.autoImport ./modules/nixos/services
'
```

Expected: A list of paths to all .nix files in the directory except default.nix

### Testing filesAsNames

Check that `flake.inputs.self.lib.croire.filesAsNames` extracts filenames correctly:

```bash
# From the repository root
nix-instantiate --eval --strict -E '
  let
    flake = builtins.getFlake (toString ./.);
  in
    flake.lib.croire.filesAsNames ./modules/darwin/packages/casks
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

- [ ] All 36+ modules updated to use `flake.inputs.self.lib.croire` pattern
- [ ] No syntax errors in modified files
- [ ] modules/flake/lib.nix exports `flake.lib.croire` functions
- [ ] All modules have `flake` parameter in their function signature
- [ ] Documentation updated
- [ ] Configuration builds successfully
- [ ] No broken imports

## Common Issues

### Module Parameter Not Available

If a module can't find the library functions, verify:
1. The module has `flake` in its parameter list: `{ flake, ... }:`
2. The usage is correct: `flake.inputs.self.lib.croire.autoImport ./.`
3. The flake-parts module `/modules/flake/lib.nix` is being loaded

### Syntax Errors

Check for:
- Missing `flake` in module parameters
- Incorrect function call syntax (should be `flake.inputs.self.lib.croire.*`)
- Missing semicolons
