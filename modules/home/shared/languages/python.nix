{ pkgs, ... }:
{
  home.packages = with pkgs.python313Packages; [
    pandas
    matplotlib
    seaborn
    beautifulsoup4
    pip
    scikitlearn
    numpy
    python-dotenv
    black
    pytest

    playwright
    pytest-playwright
    playwright-stealth
    playwrightcapture

    tkinter
    async-tkinter-loop
    customtkinter
  ];

}
