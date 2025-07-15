{ pkgs, ... }:
let
  cd = {
    "-" = "cd -"; # Go back to previous directory
    ".." = "cd .."; # Go up one directory
    "..." = "cd ../.."; # Go up two directories
    "...." = "cd ../../.."; # Go up three directories
    "....." = "cd ../../../.."; # Go up four directories
    "......" = "cd ../../../../.."; # Go up five directories
    "......." = "cd ../../../../../.."; # Go up six directories
    "........" = "cd ../../../../../../.."; # Go up seven directories
    "........." = "cd ../../../../../../../.."; # Go up eight directories
    ".........." = "cd ../../../../../../../../.."; # Go up nine directories
    "..........." = "cd ../../../../../../../../../.."; # Go up ten directories
    "~" = "cd ~"; # Go to home directory
  };
  git = {
    g = "git"; # Git command
    ga = "git add"; # Add files to staging area
    gaa = "git add --all"; # Add all files to staging area
    gb = "git branch"; # List branches
    # gbd = "git branch -d"; # Delete branch
    # gbD = "git branch -D"; # Force delete branch
    gco = "git checkout"; # Checkout branch or commit
    gcm = "git commit -m"; # Commit changes with message
    gca = "git commit --amend --no-edit"; # Amend last commit without changing message
    gcma = "git commit --amend"; # Amend last commit with editor
    gd = "git diff"; # Show differences
    gdc = "git diff --cached"; # Show staged differences
    gf = "git fetch"; # Fetch changes from remote repository
    gfa = "git fetch --all"; # Fetch all changes from all remotes
    gl = "git log --oneline --reverse --graph --decorate --all"; # Show commit log in a graph format
    gp = "git pull"; # Pull changes from remote repository
    gpa = "git pull --all"; # Pull changes from all remotes
    gpu = "git push"; # Push changes to remote repository
    gs = "git status"; # Show status of working directory
  };
  just = {
    j = "${pkgs.just}/bin/just --choose";
    jj = "${pkgs.just}/bin/just --global-justfile";
    gj = "${pkgs.just}/bin/just --global-justfile --choose 2>/dev/null";
  };
  ls = {
    ls = "${pkgs.eza}/bin/eza --icons --long --group-directories-first";
    lsa = "${pkgs.eza}/bin/eza --icons --long --all --group-directories-first";
    lsd = "${pkgs.eza}/bin/eza --icons --long --group-directories-first --tree";
    lsae = "${pkgs.eza}/bin/eza --icons --long --all --group-directories-first --tree";
    ll = "${pkgs.eza}/bin/eza --icons --long";
    la = "${pkgs.eza}/bin/eza --icons --long --all";
    lld = "${pkgs.eza}/bin/eza --icons --long --tree";
    lae = "${pkgs.eza}/bin/eza --icons --long --all --tree";
  };
  npm = {
    npb = "npm build"; # Build npm project
    npc = "npm cache"; # Clear npm cache
    npd = "npm dev"; # Start npm development server
    npg = "npm global"; # Manage global npm packages
    npi = "npm install"; # Install npm dependencies
    npl = "npm list"; # List npm packages
    npp = "npm publish"; # Publish npm package
    npr = "npm run"; # Run npm script
    nprw = "npm run watch"; # Run npm script in watch mode
    nps = "npm start"; # Start npm project
    npsv = "npm serve"; # Start npm server
    npt = "npm test"; # Run npm tests
    npu = "npm update"; # Update npm packages
    # npx = "npx || npm exec"; # Run npx command
    npx = "npx"; # Run npx command
    npy = "npm why"; # Explain why a package is installed
  };
  utility = {
    h = "history"; # Show command history
    now = "date '+%Y-%m-%d %A %T %Z'"; # Date and time
    ports = "sudo lsof -i -P"; # List open ports
    p = "pwd"; # Print working directory
    path = "echo \${PATH//:/\\n}"; # Print PATH variable separated by newlines
    reload = "exec $SHELL -l"; # Reload shell
    tree = "tree --dirsfirst"; # List files in tree format
    ts = "tmux-sessionizer"; # Tmux sessionizer
    uuid = "uuidgen | tr -d '\n' | tr '[:upper:]' '[:lower:]' | pbcopy && pbpaste && echo"; # Generate UUID, copy to clipboard, and print
    week = "date +%V"; # Get current week number
    weather = "curl -s 'wttr.in/?format=3'"; # Get weather in a short format
  };
  vi = {
    vi = "${pkgs.neovim}/bin/nvim";
    vim = "${pkgs.neovim}/bin/nvim";
    vimdiff = "${pkgs.neovim}/bin/nvim -d";
  };
  yazi = {
    y = "${pkgs.yazi}/bin/yazi";
  };
in
{
  home.shellAliases =
    {
      # uuid = "uuidgen";
    }
    // cd
    // git
    // just
    // ls
    // npm
    // utility
    // vi
    // yazi;
}
