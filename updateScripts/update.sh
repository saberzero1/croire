#!/usr/bin/zsh

option="${1}"
status=$?

case ${option} in
    flakes)
        echo "Updating Flakes"
        $cmd="nix flake update"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished updating Flakes" || echo "Updating Flakes failed"
        ;;
    clean)
        echo "Collecting garbage."
        $cmd="nix-collect-garbage -d"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished collecting garbage" || echo "Collecting garbage failed"
        ;;
    build)
        echo "Building NixOS"
        $cmd="sudo nixos-rebuild build --flake . --impure"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished building NixOS" || echo "Building failed"
        ;;
    test)
        echo "Testing NixOS"
        $cmd="sudo nixos-rebuild test --flake . --impure"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished testing NixOS" || echo "Testing failed"
        ;;
    update)
        echo "Switching NixOS"
        $cmd="sudo nixos-rebuild switch --flake . --impure"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished switching NixOS" || echo "Switching failed"
        ;;
    all)
        echo "Building, testing, and switching NixOS"
        echo "Building NixOS"
        $cmd="sudo nixos-rebuild build --flake . --impure"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished building NixOS" || (echo "Building failed" && exit 1)
        echo "Testing NixOS"
        $cmd="sudo nixos-rebuild test --flake . --impure"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished testing NixOS" || (echo "Testing failed" && exit 1)
        echo "Switching NixOS"
        $cmd="sudo nixos-rebuild switch --flake . --impure"
        $cmd
        $status=$?
        [ $status -eq 0 ] && echo "Finished switching NixOS" || (echo "Switching failed" && exit 1)
        ;;
    *)
        echo "`basename ${0}`:usage: [flakes] | [clean] | [build] | [test] | [update] | [all]"
        exit 1 # Command to come out of the program with status 1
        ;; 
esac
