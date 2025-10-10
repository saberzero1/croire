#!/usr/bin/env bash

build_cachix() {
  set -x
  nix flake archive --json |
    jq -r '.path,(.inputs|to_entries[].value.path)' |
    cachix push "saberzero1"
  for target in $(
    nix flake show --json --all-systems | jq '
    ["checks", "packages", "devShells"] as $tops |
    $tops[] as $top |
    .[$top] |
    to_entries[] |
    .key as $arch |
    .value |
    keys[] |
    "\($top).\($arch).\(.)"
    ' | tr -d '"'
  ); do
    nix build --json ".#$target" "${@:2}" |
      jq -r '.[].outputs | to_entries[].value' |
      cachix push "saberzero1"
  done
}

build_cachix "$@"
