{ pkgs, lib, ... }:
{
  # dotnet-sdk is completely broken on Darwin (nixpkgs #450126)
  # On Darwin, install dotnet-sdk via Homebrew cask instead
  home.packages = lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) (
    with pkgs;
    [
      dotnet-sdk_9
      csharpier
      mono
    ]
    ++ (with pkgs.dotnetPackages; [
      nuget
    ])
  );
}
