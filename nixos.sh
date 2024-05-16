#!/usr/bin/zsh

option="${1}"
status=$?

case ${option} in
    update)
        echo "Updating Flakes"
        nix flake update
        [ $status -eq 0 ] && echo "Finished updating Flakes" || echo "Updating Flakes failed"
        ;;
    clean)
        echo "Collecting garbage."
        nix-collect-garbage -d
        [ $status -eq 0 ] && echo "Finished collecting garbage" || echo "Collecting garbage failed"
        ;;
    build)
        echo "Building NixOS"
        sudo nixos-rebuild build --flake . --impure
        [ $status -eq 0 ] && echo "Finished building NixOS" || echo "Building failed"
        ;;
    test)
        echo "Testing NixOS"
        sudo nixos-rebuild test --flake . --impure
        [ $status -eq 0 ] && echo "Finished testing NixOS" || echo "Testing failed"
        ;;
    switch)
        echo "Switching NixOS"
        sudo nixos-rebuild switch --flake . --impure
        [ $status -eq 0 ] && echo "Finished switching NixOS" || echo "Switching failed"
        ;;
    all)
        echo "Building, testing, and switching NixOS"
        echo "Building NixOS"
        sudo nixos-rebuild build --flake . --impure
        [ $status -eq 0 ] && echo "Finished building NixOS" || (echo "Building failed" && exit 1)
        echo "Testing NixOS"
        sudo nixos-rebuild test --flake . --impure
        [ $status -eq 0 ] && echo "Finished testing NixOS" || (echo "Testing failed" && exit 1)
        echo "Switching NixOS"
        sudo nixos-rebuild switch --flake . --impure
        [ $status -eq 0 ] && echo "Finished switching NixOS" || (echo "Switching failed" && exit 1)
        ;;
    *)
        echo "`basename ${0}`:usage: [update] | [clean] | [build] | [test] | [switch] | [all]"
        exit 1 # Command to come out of the program with status 1
        ;; 
esac
