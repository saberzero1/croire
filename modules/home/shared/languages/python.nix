{ pkgs, ... }: {
  home.packages = with pkgs.python312Packages; [
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

    # Playwright
    playwright
    playwright-driver
    playwright-test
    playwright-stealth
    playwrightcapture
  ];

}
