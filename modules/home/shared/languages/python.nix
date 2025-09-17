{ pkgs, ... }:
{
  home.packages = with pkgs.python3Packages; [
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
    requests

    # playwright
    # pytest-playwright
    # playwright-stealth
    # playwrightcapture

    tkinter
    async-tkinter-loop
    customtkinter
  ];

}
