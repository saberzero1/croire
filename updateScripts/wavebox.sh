#!/usr/bin/zsh

version=$(curl "https://download.wavebox.app/stable/linux/latest.json" | jq --raw-output '.["urls"]["tar"] | match("https://download.wavebox.app/stable/linux/tar/Wavebox_(.+).tar.gz").captures[0]["string"]')
echo ${version}
nix hash to-sri --type sha256 $(nix-prefetch-url --unpack https://download.wavebox.app/stable/linux/tar/Wavebox_${version}.tar.gz)
#$version=$(curl "https://download.wavebox.app/stable/linux/latest.json" | jq --raw-output '.["urls"]["tar"] | match("https://download.wavebox.app/stable/linux/tar/Wavebox_(.+).tar.gz").captures[0]["string"]')
#nix-update wavebox --version "$version"