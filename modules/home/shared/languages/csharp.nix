{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      dotnet-sdk_9
      csharpier
      mono
    ]
    ++ (with pkgs.dotnetPackages; [
      nuget
    ]);
}
