# Croire

## Getting a hash for override:

From: https://github.com/NixOS/nixpkgs/issues/191128#issuecomment-1514224101

> Here's an example to get that sha256. You can verify this example against [the current pkg for the GitHub CLI](https://github.com/NixOS/nixpkgs/blob/cd749f58ba83f7155b7062dd49d08e5e47e44d50/pkgs/applications/version-management/git-and-tools/gh/default.nix#L11).
>
> ```shell
> nix-shell -p nix-prefetch-git jq --run "nix hash to-sri sha256:\$(nix-prefetch-git --url https://github.com/cli/cli --quiet --rev v2.20.2 | jq -r '.sha256')"
> ```

## Updating

```shell
nix flake update
```

## Cleaning

```shell
nix store optimise
```

```shell
nix-collect-garbage -d
```
