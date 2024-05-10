#!/usr/bin/zsh

echo $(curl "https://download.wavebox.app/stable/linux/latest.json" | jq --raw-output '.["urls"]["tar"] | match("https://download.wavebox.app/stable/linux/tar/Wavebox_(.+).tar.gz").captures[0]["string"]')
#$version=$(curl "https://download.wavebox.app/stable/linux/latest.json" | jq --raw-output '.["urls"]["tar"] | match("https://download.wavebox.app/stable/linux/tar/Wavebox_(.+).tar.gz").captures[0]["string"]')
#nix-update wavebox --version "$version"