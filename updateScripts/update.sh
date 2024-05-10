#!/bin/sh

option="${1}"
status=$?

case ${option} in
    build)
        echo "Building NixOS"
        $cmd="sudo nixos-rebuild build --flake ../. --impure"
        $status=$?
        [ $status -eq 0 ] && echo "Finished building NixOS" || echo "Building failed"
        ;;
    test)
        echo "Testing NixOS"
        $cmd="sudo nixos-rebuild test --flake ../. --impure"
        $status=$?
        [ $status -eq 0 ] && echo "Finished testing NixOS" || echo "Testing failed"
        ;;
    update)
        echo "Switching NixOS"
        $cmd="sudo nixos-rebuild switch --flake ../. --impure"
        $status=$?
        [ $status -eq 0 ] && echo "Finished switching NixOS" || echo "Switching failed"
        ;;
    all)
        echo "Building, testing, and switching NixOS"
        echo "Building NixOS"
        $cmd="sudo nixos-rebuild build --flake ../. --impure"
        $status=$?
        [ $status -eq 0 ] && echo "Finished building NixOS" || (echo "Building failed" && exit 1)
        echo "Testing NixOS"
        $cmd="sudo nixos-rebuild test --flake ../. --impure"
        $status=$?
        [ $status -eq 0 ] && echo "Finished testing NixOS" || (echo "Testing failed" && exit 1)
        echo "Switching NixOS"
        $cmd="sudo nixos-rebuild switch --flake ../. --impure"
        $status=$?
        [ $status -eq 0 ] && echo "Finished switching NixOS" || (echo "Switching failed" && exit 1)
        ;;
    *)
        echo "`basename ${0}`:usage: [build] | [test] | [update] | [all]"
        exit 1 # Command to come out of the program with status 1
        ;; 
esac
