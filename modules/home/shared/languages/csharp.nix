{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      dotnet-sdk_9
      csharpier
    ]
    ++ (with pkgs.dotnetPackages; [
      nuget
    ]);
}
