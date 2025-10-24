# Testing Library Functions

This document describes how to test the library functions to ensure they work correctly.

## Manual Testing

### Testing auto-import.nix

1. Navigate to any module with a `default.nix` that uses the function
2. Check that the imports work correctly:

```bash
# From the repository root
nix-instantiate --eval --strict -E '(import ./modules/nixos/services/default.nix { }).imports'
```

Expected: A list of paths to all .nix files in the directory except default.nix

### Testing files-as-names.nix

1. Test with a directory that uses it (e.g., homebrew casks):

```bash
# From the repository root
nix-instantiate --eval --strict -E 'let casks = (import ./lib/files-as-names.nix) ./modules/darwin/packages/casks; in casks'
```

Expected: A list of filenames without the .nix extension

### Testing flake.lib functions

Check that the flake exports the library functions:

```bash
# From the repository root
nix eval .#lib.autoImport --apply 'x: "function exists"'
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

- [ ] All 33+ files updated with new import patterns
- [ ] No syntax errors in modified files
- [ ] Path calculations are correct (count ../s match directory depth)
- [ ] lib/ directory created with all utilities
- [ ] modules/flake/lib.nix created and exports functions
- [ ] Documentation files created (README.md, TESTING.md)
- [ ] Legacy files updated with deprecation notices
- [ ] Configuration builds successfully
- [ ] No broken imports

## Common Issues

### Path Calculation Errors

If imports fail, verify the path depth:
```bash
# Count directory levels from file to repo root
echo "path/to/module" | awk -F/ '{print NF}'
```

Use this many `../` in the import path.

### Syntax Errors

Check for:
- Missing parentheses around the import
- Incorrect directory argument (should be `./.`)
- Missing semicolons

## Rollback

If issues are found, the original pattern can be restored:

```nix
imports = builtins.map (fn: ./${fn}) (
  builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.))
);
```
