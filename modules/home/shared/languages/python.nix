{ pkgs, ... }:
{
  home.packages = with pkgs.python313Packages; [
    pandas
    matplotlib
    seaborn
    pip
    scikitlearn
    numpy
    python-dotenv
    black
    pytest
    json5

    # playwright
    # pytest-playwright
    # playwright-stealth
    # playwrightcapture

    tkinter
    async-tkinter-loop
    customtkinter
  ];

}
